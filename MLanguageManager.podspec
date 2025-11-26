Pod::Spec.new do |s|

  s.name         = "MLanguageManager"
  s.version      = "1.0.0"
  s.summary      = "专业级的 iOS 全球多语言国际化 SDK"
  
  s.description  = <<-DESC
                   专业级的 iOS 多语言国际化 SDK，支持全球 80+ 种语言动态切换。无需依赖系统 .lproj 文件，可配置启用指定语言，完美适配复杂多变的国际化需求。
                   轻量级、高性能，助力应用快速实现全球化部署。
                   DESC

  s.homepage     = "https://github.com/mirco1990/MLanguageManager"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "WangMing" => "286241793@qq.com" }
  
  # 修复部署目标版本
  s.platform     = :ios, "12.0"
  
  s.source       = { :git => "https://github.com/mirco1990/MLanguageManager.git", :tag => "#{s.version}" }
  
  # 方案 A: 使用预编译框架（确保文件存在）
  s.vendored_frameworks = 'MLanguageManager.framework'
  
  # 或者方案 B: 使用源代码
  # s.source_files = 'MLanguageManager/Classes/**/*.{h,m}'
  # s.public_header_files = 'MLanguageManager/Classes/**/*.h'
  
  s.frameworks = "Foundation"
  s.libraries = "c++", "xml2"
  
  # 如果需要 ARC
  s.requires_arc = true
  
  # 如果有依赖项，取消注释并添加
  # s.dependency "SomeDependency", "~> 1.0"

end