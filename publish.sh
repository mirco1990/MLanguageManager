#!/bin/bash

# ============ 用户配置区 ============
FRAMEWORK_NAME="MLanguageManager" # 你的框架名
PODSPEC_NAME="${FRAMEWORK_NAME}.podspec" # podspec文件名
FRAMEWORK_PATH="./MLanguageManager.framework" # 预编译framework的路径，相对于脚本位置
# 注意：如果framework在git仓库内，建议放在项目根目录或指定子目录
GIT_REMOTE="origin" # Git远程仓库别名
BRANCH="main" # 要推送的分支名（根据你的仓库调整，如main/master）
VERSION="1.0.0" # 本次发布的版本号，务必与podspec中的s.version一致
# ===================================

set -e # 任何语句执行失败就退出
echo "🚀 开始发布流程：${FRAMEWORK_NAME} 二进制框架 v${VERSION}"
echo "📁 框架路径：${FRAMEWORK_PATH}"

# 0. 检查是否提供framework路径参数（可选增强）
if [ $# -eq 1 ]; then
    FRAMEWORK_PATH=$1
    echo "使用参数指定的框架路径：${FRAMEWORK_PATH}"
fi

# 1. 检查必要文件
echo "📋 步骤1：检查必要文件..."
if [ ! -f "${PODSPEC_NAME}" ]; then
    echo "❌ 错误：未找到 ${PODSPEC_NAME} 文件！"
    exit 1
fi

if [ ! -d "${FRAMEWORK_PATH}" ]; then
    echo "❌ 错误：未找到预编译框架文件 ${FRAMEWORK_PATH}！"
    echo "请将编译好的 ${FRAMEWORK_NAME}.framework 放到指定路径，或修改脚本中的 FRAMEWORK_PATH 变量。"
    exit 1
fi

# 2. 验证framework架构
echo "🔍 步骤2：验证二进制文件架构..."
BINARY_PATH="${FRAMEWORK_PATH}/${FRAMEWORK_NAME}"
if [ -f "${BINARY_PATH}" ]; then
    ARCHS=$(lipo -info "${BINARY_PATH}" 2>/dev/null || echo "")
    if [[ -z "${ARCHS}" ]]; then
        echo "❌ 错误：无法读取二进制文件架构信息。文件可能损坏或格式不正确。"
        exit 1
    fi
    echo "架构信息：${ARCHS}"
    
    # 检查是否包含arm64（必需）
    if [[ "${ARCHS}" != *"arm64"* ]]; then
        echo "❌ 错误：二进制文件不包含arm64架构！无法发布仅支持arm64的框架。"
        exit 1
    fi
    
    # 检查是否只包含arm64（可选，但建议）
    if [[ "${ARCHS}" == *"x86_64"* ]] || [[ "${ARCHS}" == *"i386"* ]]; then
        echo "⚠️  警告：二进制文件包含模拟器架构(x86_64/i386)，这可能导致在真机+模拟器的'胖'框架。"
        echo "       如果你确定要发布仅真机(arm64)版本，请重新编译并排除模拟器架构。"
        read -p "是否继续？(y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "⏹️  已取消发布。"
            exit 0
        fi
    fi
    echo "✅ 架构验证通过。"
else
    echo "❌ 错误：在 ${FRAMEWORK_PATH} 中找不到核心二进制文件！"
    exit 1
fi

# 3. 检查podspec版本一致性
echo "📝 步骤3：检查podspec版本一致性..."
PODSPEC_VERSION=$(grep -E "s\.version\s*=" "${PODSPEC_NAME}" | head -1 | sed "s/.*= *['\"]\([^'\"]*\)['\"].*/\1/")
if [ -z "${PODSPEC_VERSION}" ]; then
    echo "⚠️  警告：无法从 ${PODSPEC_NAME} 中提取版本号，将使用脚本配置的版本号 ${VERSION}"
else
    if [ "${PODSPEC_VERSION}" != "${VERSION}" ]; then
        echo "❌ 错误：podspec文件中的版本号(${PODSPEC_VERSION})与脚本配置的版本号(${VERSION})不一致！"
        echo "请修改podspec文件或脚本中的VERSION变量，确保两者一致。"
        exit 1
    fi
    echo "✅ podspec版本号一致：${VERSION}"
fi

# 4. 确保framework在git跟踪的目录中（如果不在则复制到指定位置）
echo "🗂️  步骤4：准备framework文件..."
# 检查framework是否在git仓库内
if git ls-files --error-unmatch "${FRAMEWORK_PATH}" >/dev/null 2>&1; then
    echo "✅ framework已在git跟踪中。"
else
    # 如果不在git跟踪中，复制到项目根目录下的Frameworks目录（推荐做法）
    TARGET_DIR="./Frameworks"
    mkdir -p "${TARGET_DIR}"
    TARGET_PATH="${TARGET_DIR}/${FRAMEWORK_NAME}.framework"
    
    echo "将framework复制到git可跟踪目录：${TARGET_PATH}"
    rm -rf "${TARGET_PATH}"
    cp -R "${FRAMEWORK_PATH}" "${TARGET_PATH}"
    
    # 更新变量，后续使用新路径
    FRAMEWORK_PATH="${TARGET_PATH}"
    echo "✅ framework已复制到 ${FRAMEWORK_PATH}"
fi

# 5. Git提交与打标签（关键：推送framework）
echo "🏷️  步骤5：Git提交与打标签 v${VERSION}..."
# 检查是否有未提交的更改
if git diff-index --quiet HEAD --; then
    echo "ℹ️  当前没有未提交的更改。"
else
    echo "以下文件有未提交的更改："
    git status --short
    
    read -p "是否提交这些更改？(y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git add -A
        git commit -m "发布 ${FRAMEWORK_NAME} 二进制框架版本 ${VERSION}"
        echo "✅ 更改已提交。"
    else
        echo "❌ 发布流程中止：必须先提交或撤销未提交的更改。"
        exit 1
    fi
fi

# 推送分支
echo "推送分支到远程仓库..."
git push "${GIT_REMOTE}" "${BRANCH}" || {
    echo "❌ 推送分支失败，请检查网络连接和权限。"
    exit 1
}
echo "✅ 分支推送成功。"

# 删除可能存在的旧标签，然后创建并推送新标签
echo "创建并推送标签 v${VERSION}..."
git tag -d "${VERSION}" 2>/dev/null || true
git push "${GIT_REMOTE}" --delete "refs/tags/${VERSION}" 2>/dev/null || true
git tag "${VERSION}"
git push "${GIT_REMOTE}" --tags
echo "✅ Git标签 v${VERSION} 已创建并推送。"

# 6. 验证podspec（现在可以从远程仓库正确获取代码）
echo "🧪 步骤6：验证podspec文件..."
pod spec lint "${PODSPEC_NAME}" \
    --allow-warnings \
    --verbose \
    --sources="https://cdn.cocoapods.org"  # 使用官方源，避免私有源干扰
echo "✅ podspec 验证通过！"

# 7. 发布到CocoaPods
echo "🚀 步骤7：发布到CocoaPods Trunk..."
read -p "确认要发布到CocoaPods公共仓库吗？(y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    pod trunk push "${PODSPEC_NAME}" --allow-warnings
    echo "🎉 发布完成！"
    echo ""
    echo "后续步骤："
    echo "1. 等待约10-30分钟，CocoaPods索引更新"
    echo "2. 在其他项目中测试：pod '${FRAMEWORK_NAME}', '~> ${VERSION}'"
    echo "3. 也可以先搜索验证：pod search ${FRAMEWORK_NAME}"
else
    echo "⏹️  已取消发布。"
fi