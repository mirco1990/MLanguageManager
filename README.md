# MLanguageManager
🌍 全球语言支持 - 覆盖 140+ 国家语言
⚡ 高性能缓存 - 内存+磁盘双重缓存机制
🔄 热切换支持 - 运行时动态切换语言
📱 模块化设计 - 支持多表分离管理
🛠 灵活配置 - 可启用指定语言子集 
🔧 易于集成 - 简洁 API，快速上手

 ⚡使用方法：
   🔧安装:pod 'MLanguageManager'
  ⚡使用
                   
  监听语言设置,语言发生切换时会发送切换通知
  
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageDidChange:) name:GlobalLanguageDidChangeNotification object:nil];

  初始化SDK并配置需要开启的语种
  
      GlobalLanguageManager *manager = [GlobalLanguageManager sharedManager];
      manager.enableMemoryCache = YES;
      NSArray *availableLanguages = @[
            [GlobalLanguage languageWithType:GlobalLanguageChineseSimplified],// 简体中文
            [GlobalLanguage languageWithType:GlobalLanguageChineseTraditional],// 繁体中文
            [GlobalLanguage languageWithType:GlobalLanguageEnglish],// 英文
            [GlobalLanguage languageWithType:GlobalLanguageSpanish],// 西班牙
            [GlobalLanguage languageWithType:GlobalLanguageFrench],// 法语
            [GlobalLanguage languageWithType:GlobalLanguageJapanese]// 日语
      ];
      
     // 设置支持语言，默认为英文。
     [manager configureAvailableLanguages:availableLanguages defaultLanguageType:GlobalLanguageEnglish];

   使用本地化字符串
   
      NSString *welcome = [manager localizedStringForKey:@"welcome"];
      NSLog(@"欢迎语: %@", welcome);


