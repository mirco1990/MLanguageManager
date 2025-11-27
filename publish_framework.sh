#!/bin/bash

# 完整的框架发布脚本

set -e

echo "🚀 开始发布 MLanguageManager 框架..."

# 1. 创建 XCFramework
echo "📦 创建 XCFramework..."
./create_arm64_xcframework.sh

# 2. 验证框架是否创建成功
if [ ! -d "MLanguageManager.xcframework" ]; then
  echo "❌ XCFramework 创建失败"
  exit 1
fi

echo "✅ XCFramework 创建成功"

# 3. 验证 podspec
echo "🔍 验证 podspec..."
pod spec lint MLanguageManager.podspec --allow-warnings --skip-import-validation

# 4. 提交到 Git
echo "📝 提交到 Git..."
git add .
git commit -m "发布版本 1.0.0 - 添加 XCFramework 支持 (arm64 only)"
git tag -f 1.0.0
git push origin main
git push -f origin 1.0.0

echo "✅ 发布完成!"
echo ""
echo "下一步: 如果需要推送到 CocoaPods Trunk，运行:"
echo "pod trunk push MLanguageManager.podspec --allow-warnings"
