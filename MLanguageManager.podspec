#
#  Be sure to run `pod spec lint MLanguageManager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "MLanguageManager"
  s.version      = "1.0.0"
  s.summary      = "专业级的 iOS 全球多语言国际化 SDK"
  s.description  = <<-DESC
                   专业级的 iOS 多语言国际化 SDK，支持全球 80+ 种语言动态切换。无需依赖系统 .lproj 文件，可配置启用指定语言，完美适配复杂多变的国际化需求。
		   轻量级、高性能，助力应用快速实现全球化部署。

		   

		   使用方法：
		   usage：
                    
                   安装:pod 'MLanguageManager'
                   
	          // 0.监听语言设置
    	          [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageDidChange:) name:GlobalLanguageDidChangeNotification object:nil];

                  // 1. 初始化配置
                  GlobalLanguageManager *manager = [GlobalLanguageManager sharedManager];
                  manager.enableMemoryCache = YES;

                  // 2. 配置可用语言
                  NSArray *availableLanguages = @[
                   [GlobalLanguage languageWithType:@"zh-Hans"],
                   [GlobalLanguage languageWithType:@"zh-Hant"],
                   [GlobalLanguage languageWithType:@"en"],
                   [GlobalLanguage languageWithType:@"es"],
                   [GlobalLanguage languageWithType:@"fr"],
                   [GlobalLanguage languageWithType:@"ja"]
                  ];
                 [manager configureAvailableLanguages:availableLanguages];

                 // 3. 设置当前语言
                  [manager setLanguage:[GlobalLanguage languageWithType:@"zh-Hans"]];

                 // 4. 使用本地化字符串
                  NSString *welcome = [manager localizedStringForKey:@"welcome"];
                  NSLog(@"欢迎语: %@", welcome);

                   DESC

  s.homepage     = "https://github.com/mirco1990/MLanguageManager.git"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author             = { "WangMing" => "286241793@qq.com" }
  # Or just: s.author    = "WangMing"
  # s.authors            = { "WangMing" => "286241793@qq.com" }
 

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  # s.platform     = :ios
  s.platform     = :ios, "8.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/mirco1990/MLanguageManager.git", :tag => "#{s.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

# s.source_files  = "Classes", "Classes/**/*.{h,m}"
# s.exclude_files = "Classes/Exclude"
  # s.public_header_files = "Classes/**/*.h"

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.vendored_frameworks = 'AdvertiserSDK.framework'
  # s.framework  = "SomeFramework"
  s.frameworks = "Foundation"

  # s.library   = "iconv"
  s.libraries = "c++", "xml2"


  # ――― Project Settings ―――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
