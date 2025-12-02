#!/bin/bash

# ============ 用户配置区 ============
FRAMEWORK_NAME="MLanguageManager" # 你的框架名
PODSPEC_NAME="${FRAMEWORK_NAME}.podspec" # podspec文件名
FRAMEWORK_PATH="./MLanguageManager.framework" # 预编译framework的路径，相对于脚本位置
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

# ========== 新增：用户选择是否推送 Git ==========
echo ""
echo "📤 Git 推送选项："
echo "  1) 推送分支和标签（推荐，首次发布或代码有更新）"
echo "  2) 只推送标签（代码已推送，仅需更新标签）"
echo "  3) 跳过 Git 推送（已推送过，直接进入验证步骤）"
read -p "请选择 (1/2/3): " -n 1 -r
echo

case $REPLY in
    1)
        # 推送分支（使用智能推送处理远程有更新的情况）
        echo "推送分支到远程仓库..."
        
        # 智能推送函数
        smart_push() {
            local remote="$1"
            local branch="$2"
            
            echo "尝试推送分支..."
            if git push "$remote" "$branch" 2>&1 | grep -q "rejected"; then
                echo "⚠️  推送被拒绝，远程有本地没有的更新"
                echo "尝试拉取远程更新并合并..."
                
                read -p "是否拉取远程更新并合并？(y/n): " -n 1 -r
                echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    if git pull "$remote" "$branch" --rebase; then
                        echo "✅ 拉取并合并成功，重新推送..."
                        git push "$remote" "$branch" && return 0
                    else
                        echo "❌ 拉取失败，可能存在冲突"
                        return 1
                    fi
                else
                    echo "是否强制推送（覆盖远程）？(y/n): " -n 1 -r
                    echo
                    if [[ $REPLY =~ ^[Yy]$ ]]; then
                        git push "$remote" "$branch" --force && return 0
                    else
                        echo "⏹️  用户取消推送"
                        return 1
                    fi
                fi
            else
                return 0
            fi
        }
        
        if smart_push "${GIT_REMOTE}" "${BRANCH}"; then
            echo "✅ 分支推送成功。"
        else
            echo "❌ 分支推送失败，请手动处理"
            exit 1
        fi
        
        # 推送标签
        echo "创建并推送标签 v${VERSION}..."
        git tag -d "${VERSION}" 2>/dev/null || true
        git push "${GIT_REMOTE}" --delete "refs/tags/${VERSION}" 2>/dev/null || true
        git tag "${VERSION}"
        git push "${GIT_REMOTE}" --tags
        echo "✅ Git标签 v${VERSION} 已创建并推送。"
        ;;
        
    2)
        # 只推送标签
        echo "创建并推送标签 v${VERSION}..."
        git tag -d "${VERSION}" 2>/dev/null || true
        git push "${GIT_REMOTE}" --delete "refs/tags/${VERSION}" 2>/dev/null || true
        git tag "${VERSION}"
        git push "${GIT_REMOTE}" --tags
        echo "✅ Git标签 v${VERSION} 已创建并推送。"
        ;;
        
    3)
        # 跳过 Git 推送
        echo "⏭️  跳过 Git 推送步骤"
        ;;
        
    *)
        echo "❌ 无效选择，默认跳过 Git 推送"
        ;;
esac

# 6. 验证podspec（纯OC二进制框架专用验证）
echo "🧪 步骤6：验证podspec文件..."

# 纯Objective-C二进制框架专用验证参数
VALIDATE_CMD="pod spec lint \"${PODSPEC_NAME}\" \
  --allow-warnings \
  --skip-import-validation \
  --use-libraries \
  --skip-tests \
  --sources=\"https://cdn.cocoapods.org\" \
  --verbose"

echo "执行验证命令: ${VALIDATE_CMD}"
eval ${VALIDATE_CMD}

# 检查验证结果
if [ $? -eq 0 ]; then
    echo "✅ podspec 验证通过！"
else
    echo "⚠️  podspec 验证失败，尝试备用方案..."
    
    # 备用方案1：仅验证真机架构
    echo "尝试备用方案1：仅验证真机架构..."
    if pod spec lint "${PODSPEC_NAME}" \
      --allow-warnings \
      --skip-import-validation \
      --use-libraries \
      --skip-tests \
      --platforms=ios; then
        echo "✅ podspec 验证通过（仅真机架构）！"
    else
        echo "⚠️  备用方案1失败，尝试备用方案2..."
        
        # 备用方案2：更宽松的验证
        echo "尝试备用方案2：最宽松验证..."
        if pod spec lint "${PODSPEC_NAME}" \
          --allow-warnings \
          --skip-import-validation \
          --use-libraries \
          --skip-tests \
          --no-clean; then
            echo "✅ podspec 验证通过（最宽松模式）！"
        else
            echo "❌ 所有验证尝试都失败"
            echo ""
            echo "手动诊断步骤："
            echo "1. 检查框架完整性: file ${BINARY_PATH}"
            echo "2. 检查未定义符号: nm ${BINARY_PATH} 2>/dev/null | grep ' U ' | head -10"
            echo "3. 创建测试项目验证:"
            echo "   mkdir -p ~/Desktop/TestPod && cd ~/Desktop/TestPod"
            echo "   cat > Podfile << 'EOF'"
            echo "   platform :ios, '12.0'"
            echo "   target 'TestApp' do"
            echo "     pod '${FRAMEWORK_NAME}', :path => '$(pwd)'"
            echo "   end"
            echo "   EOF"
            echo "   pod install"
            exit 1
        fi
    fi
fi

# 7. 发布到CocoaPods（针对纯OC二进制框架优化）
echo "🚀 步骤7：发布到CocoaPods Trunk..."
read -p "确认要发布到CocoaPods公共仓库吗？(y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "使用纯OC二进制框架专用参数发布..."
    
    # 发布命令（与验证时使用相同参数以确保一致性）
    PUBLISH_CMD="pod trunk push \"${PODSPEC_NAME}\" \
      --allow-warnings \
      --skip-import-validation \
      --use-libraries \
      --skip-tests"
    
    echo "执行发布命令: ${PUBLISH_CMD}"
    eval ${PUBLISH_CMD}
    
    if [ $? -eq 0 ]; then
        echo "🎉 发布完成！"
        echo ""
        echo "后续步骤："
        echo "1. 等待约10-30分钟，CocoaPods索引更新"
        echo "2. 在其他项目中测试：pod '${FRAMEWORK_NAME}', '~> ${VERSION}'"
        echo "3. 也可以先搜索验证：pod search ${FRAMEWORK_NAME} 或 pod try ${FRAMEWORK_NAME}"
        echo ""
        echo "注意：由于框架仅支持arm64架构，用户需要："
        echo "  - 使用Apple Silicon Mac（M1/M2/M3芯片）"
        echo "  - 或在真机设备上运行"
    else
        echo "❌ 发布失败"
        echo ""
        echo "可以尝试手动发布命令："
        echo "  pod trunk push ${PODSPEC_NAME} --allow-warnings --skip-import-validation --use-libraries"
    fi
else
    echo "⏹️  已取消发布。"
fi