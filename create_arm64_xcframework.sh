#!/bin/bash

# 创建 arm64-only XCFramework 并配置跳过 x86_64 验证

set -e

echo "创建 arm64-only XCFramework（配置跳过 x86_64 验证）..."

# 配置
SCHEME="MLanguageManager"
PRODUCT_NAME="MLanguageManager"
BUILD_DIR="build"
XCFRAMEWORK_NAME="${PRODUCT_NAME}.xcframework"

# 清理
rm -rf "$BUILD_DIR"
rm -rf "$XCFRAMEWORK_NAME"

# 1. 构建真机版本 (arm64)
echo "构建真机版本..."
xcodebuild archive \
  -scheme "$SCHEME" \
  -destination "generic/platform=iOS" \
  -archivePath "$BUILD_DIR/ios.xcarchive" \
  -sdk iphoneos \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# 2. 构建模拟器版本 (arm64)
echo "构建模拟器版本..."
xcodebuild archive \
  -scheme "$SCHEME" \
  -destination "generic/platform=iOS Simulator" \
  -archivePath "$BUILD_DIR/simulator.xcarchive" \
  -sdk iphonesimulator \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# 3. 创建 XCFramework
echo "创建 XCFramework..."
xcodebuild -create-xcframework \
  -framework "$BUILD_DIR/ios.xcarchive/Products/Library/Frameworks/$PRODUCT_NAME.framework" \
  -framework "$BUILD_DIR/simulator.xcarchive/Products/Library/Frameworks/$PRODUCT_NAME.framework" \
  -output "$XCFRAMEWORK_NAME"

# 验证
if [ -d "$XCFRAMEWORK_NAME" ]; then
  echo "✅ XCFramework 创建成功"
  echo "架构信息:"
  find "$XCFRAMEWORK_NAME" -name "$PRODUCT_NAME" -type f | while read binary; do
    echo "  - $(dirname $(dirname $binary)): $(lipo -info "$binary" | cut -d: -f3)"
  done
else
  echo "❌ XCFramework 创建失败"
  exit 1
fi

echo "🎉 XCFramework 创建完成！"
