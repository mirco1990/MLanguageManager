# MLanguageManager
🌍 全球语言支持 - 覆盖 80+ 国家语言
⚡ 高性能缓存 - 内存+磁盘双重缓存机制
🔄 热切换支持 - 运行时动态切换语言
📱 模块化设计 - 支持多表分离管理
🛠 灵活配置 - 可启用指定语言子集 
🔧 易于集成 - 简洁 API，快速上手

 ⚡使用方法：
   🔧安装:pod 'MLanguageManager'
  ⚡使用
                   
  // 0.监听语言设置
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageDidChange:) name:GlobalLanguageDidChangeNotification object:nil];

      // 1. 初始化配置
      GlobalLanguageManager *manager = [GlobalLanguageManager sharedManager];
      manager.enableMemoryCache = YES;

      // 2. 配置可用语言---支持的语言
        NSArray *availableLanguages = @[
            [GlobalLanguage languageWithType:GlobalLanguageChineseSimplified],
            [GlobalLanguage languageWithType:GlobalLanguageChineseTraditional],
            [GlobalLanguage languageWithType:GlobalLanguageEnglish],
            [GlobalLanguage languageWithType:GlobalLanguageSpanish],
            [GlobalLanguage languageWithType:GlobalLanguageFrench],
            [GlobalLanguage languageWithType:GlobalLanguageJapanese]
        ];
     [manager configureAvailableLanguages:availableLanguages];

     // 3. 设置当前语言
      [manager setLanguage:[GlobalLanguage languageWithType:@"zh-Hans"]];

     // 4. 使用本地化字符串
      NSString *welcome = [manager localizedStringForKey:@"welcome"];
      NSLog(@"欢迎语: %@", welcome);
