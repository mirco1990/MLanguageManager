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
  s.author       = { "WangMing" => "286241793@qq.com" }
  
  # 设置平台要求
  s.platform     = :ios, "12.0"
  
  # 源代码信息
  s.source       = { 
    :git => "https://github.com/mirco1990/MLanguageManager.git", 
    :tag => "#{s.version}" 
  }
  
  # 使用 XCFramework
  s.vendored_frameworks = 'MLanguageManager.framework'
  
  # 依赖的系统框架
  s.frameworks = "Foundation", "UIKit"
 # s.libraries = "c++", "xml2"
  
  # 启用 ARC
  s.requires_arc = true
  
  # 重要：跳过 x86_64 架构验证
  # 这允许在 Apple Silicon Mac 上通过验证
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64',
    'VALID_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  s.user_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64',
    'VALID_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  s.ios.deployment_target = '12.0'
  s.pod_target_xcconfig = { 'ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end