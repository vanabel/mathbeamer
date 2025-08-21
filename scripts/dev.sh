#!/bin/bash

# ustcmb 开发辅助脚本
# 使用方法: ./scripts/dev.sh <命令>
# 命令: build, test, package, clean, check

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_info() {
    echo -e "${BLUE}[信息]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[成功]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[警告]${NC} $1"
}

print_error() {
    echo -e "${RED}[错误]${NC} $1"
}

# 检查命令是否存在
check_command() {
    if ! command -v $1 &> /dev/null; then
        print_error "命令 '$1' 未找到，请先安装"
        exit 1
    fi
}

# 检查必要文件
check_files() {
    print_info "检查项目文件..."
    
    if [ ! -f "ustcmb.dtx" ]; then
        print_error "ustcmb.dtx 文件不存在"
        exit 1
    fi
    
    if [ ! -f "Makefile" ]; then
        print_error "Makefile 文件不存在"
        exit 1
    fi
    
    print_success "项目文件检查通过"
}

# 构建项目
build_project() {
    print_info "开始构建项目..."
    check_files
    check_command "make"
    
    make clean
    make all
    
    print_success "项目构建完成！"
}

# 运行测试
run_tests() {
    print_info "运行项目测试..."
    check_files
    check_command "make"
    
    # 检查生成的文件
    if [ ! -f "ustcmb.cls" ]; then
        print_error "ustcmb.cls 未生成"
        exit 1
    fi
    
    if [ ! -f "ustcmb.pdf" ]; then
        print_error "ustcmb.pdf 未生成"
        exit 1
    fi
    
    if [ ! -f "ustcmb-main.pdf" ]; then
        print_error "ustcmb-main.pdf 未生成"
        exit 1
    fi
    
    print_success "所有测试通过！"
}

# 创建发布包
create_package() {
    print_info "创建发布包..."
    check_files
    check_command "make"
    
    # 先构建项目
    make all
    
    # 创建发布包
    make zip
    
    print_success "发布包创建完成！"
}

# 清理项目
clean_project() {
    print_info "清理项目文件..."
    check_command "make"
    
    make clean
    make distclean
    
    # 清理额外的文件
    rm -f *.zip
    rm -rf ustcmb-*/
    
    print_success "项目清理完成！"
}

# 检查版本一致性
check_version() {
    print_info "检查版本一致性..."
    
    if [ ! -f "Makefile" ] || [ ! -f "ustcmb.dtx" ]; then
        print_error "Makefile 或 ustcmb.dtx 不存在"
        exit 1
    fi
    
    # 从Makefile获取版本
    VERSION_IN_MAKEFILE=$(grep '^VER=' Makefile | cut -d' ' -f2)
    
    # 从DTX获取版本
    VERSION_IN_DTX=$(grep '\\ProvidesPackage.*ustcmb' ustcmb.dtx | sed 's/.*\[\(.*\)\].*/\1/')
    
    if [ "$VERSION_IN_MAKEFILE" != "$VERSION_IN_DTX" ]; then
        print_error "版本不一致！"
        echo "  Makefile: $VERSION_IN_MAKEFILE"
        echo "  DTX:      $VERSION_IN_DTX"
        exit 1
    fi
    
    print_success "版本一致性检查通过: $VERSION_IN_MAKEFILE"
}

# 显示帮助信息
show_help() {
    echo "ustcmb 开发辅助脚本"
    echo ""
    echo "使用方法: $0 <命令>"
    echo ""
    echo "命令:"
    echo "  build     - 构建项目"
    echo "  test      - 运行测试"
    echo "  package   - 创建发布包"
    echo "  clean     - 清理项目"
    echo "  check     - 检查版本一致性"
    echo "  help      - 显示此帮助信息"
    echo ""
    echo "示例:"
    echo "  $0 build      # 构建项目"
    echo "  $0 test       # 运行测试"
    echo "  $0 package    # 创建发布包"
}

# 主逻辑
case $1 in
    "build")
        build_project
        ;;
    "test")
        run_tests
        ;;
    "package")
        create_package
        ;;
    "clean")
        clean_project
        ;;
    "check")
        check_version
        ;;
    "help"|"--help"|"-h"|"")
        show_help
        ;;
    *)
        print_error "未知命令: $1"
        echo ""
        show_help
        exit 1
        ;;
esac
