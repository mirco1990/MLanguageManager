Pod::Spec.new do |s|
  s.name         = "MLanguageManager"
  s.version      = "1.0.0"
  s.summary      = "专业级的 iOS 全球多语言国际化 SDK"
  s.description  = <<-DESC
                   专业级的 iOS 多语言国际化 SDK，支持全球 80+ 种语言动态切换。
                   无需依赖系统 .lproj 文件，可配置启用指定语言，完美适配复杂多变的国际化需求。
                   轻量级、高性能，助力应用快速实现全球化部署。
                   DESC

  s.homepage     = "https://github.com/mirco1990/MLanguageManager"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "mirco1990" => "your_email@example.com" }  # 修改为mirco1990的邮箱
  
  # 设置平台要求
  s.platform     = :ios, "12.0"
  
  # 源代码信息 - 关键：指向你的二进制框架的Git仓库
  s.source       = { 
    :git => "https://github.com/mirco1990/MLanguageManager.git", 
    :tag => "#{s.version}" 
  }
  
  # 关键：指定预编译的二进制框架（仅 arm64）
  s.vendored_frameworks = 'MLanguageManager.framework'
  
  # 依赖的系统框架
  s.frameworks = "Foundation", "UIKit"
  
  # 启用 ARC
  s.requires_arc = true
  
  # ========== 关键：针对仅 arm64 二进制框架的配置 ==========
  
  # 1. 明确声明支持的架构（仅 arm64）
  s.pod_target_xcconfig = {
    # 真机架构
    'ARCHS[sdk=iphoneos*]' => 'arm64',
    # 模拟器架构 - 对于仅 arm64 的二进制框架，模拟器也需要 arm64
    'ARCHS[sdk=iphonesimulator*]' => 'arm64',
    # 排除 x86_64 架构（因为框架不包含它）
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64 i386',
    # 确保构建时使用正确的架构
    'VALID_ARCHS' => 'arm64'
  }
  
  # 2. 为用户项目配置（确保使用者项目也能正确处理）
  s.user_target_xcconfig = {
    # 排除不支持的架构
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64 i386',
    # 告诉 Xcode 模拟器只使用 arm64
    'ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  
  # 3. 声明二进制框架是为真机编译的
  s.ios.vendored_frameworks = 'MLanguageManager.framework'
  
  # 4. 添加 Swift 版本支持（如果有Swift代码）
  # s.swift_version = "5.0"
  
  # 5. 添加资源文件（如果有）
  # s.resource_bundles = {
  #   'MLanguageManager' => ['Resources/*.lproj', 'Resources/*.strings']
  # }
end