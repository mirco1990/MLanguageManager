//
//  GlobalLanguageManager.m
//  WIFI_LED
//
//  Created by Parker on 2025/11/25.
//  Copyright © 2025 Parker. All rights reserved.
//

#import "GlobalLanguageManager.h"
#import "GlobalLanguageDataProvider.h"
// 内存缓存类
@interface LanguageMemoryCache : NSObject
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableDictionary *> *cache;
- (void)setStrings:(NSDictionary *)strings forLanguage:(NSString *)languageCode;
- (NSDictionary *)stringsForLanguage:(NSString *)languageCode;
- (void)removeStringsForLanguage:(NSString *)languageCode;
- (void)clearAll;
@end

@implementation LanguageMemoryCache

- (instancetype)init {
    self = [super init];
    if (self) {
        _cache = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setStrings:(NSDictionary *)strings forLanguage:(NSString *)languageCode {
    @synchronized (self) {
        self.cache[languageCode] = [strings mutableCopy];
    }
}

- (NSDictionary *)stringsForLanguage:(NSString *)languageCode {
    @synchronized (self) {
        return [self.cache[languageCode] copy];
    }
}

- (void)removeStringsForLanguage:(NSString *)languageCode {
    @synchronized (self) {
        [self.cache removeObjectForKey:languageCode];
    }
}

- (void)clearAll {
    @synchronized (self) {
        [self.cache removeAllObjects];
    }
}

@end

// 主要实现
@interface GlobalLanguageManager ()

@property (nonatomic, strong) GlobalLanguage *currentLanguage;
@property (nonatomic, copy) NSArray<GlobalLanguage *> *availableLanguages;
@property (nonatomic, strong) LanguageMemoryCache *memoryCache;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSDictionary *> *languageData;
@property (nonatomic, strong) NSMutableDictionary<NSString *, id<GlobalLanguageDataProvider>> *customDataProviders;
@property (nonatomic, strong) dispatch_queue_t dataQueue;
@property (nonatomic, copy) NSString *baseDirectory;

@end

@implementation GlobalLanguageManager

+ (instancetype)sharedManager {
    static GlobalLanguageManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _memoryCache = [[LanguageMemoryCache alloc] init];
        _languageData = [NSMutableDictionary dictionary];
        _customDataProviders = [NSMutableDictionary dictionary];
        _dataQueue = dispatch_queue_create("com.wm.language.manager", DISPATCH_QUEUE_SERIAL);
        

        _enableMemoryCache = YES;
        _baseDirectory = [self defaultBaseDirectory];
        
        [self loadSavedSettings];
        [self setupBaseDirectory];
    }
    return self;
}

#pragma mark - 目录管理

- (NSString *)defaultBaseDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths.firstObject;
    return [documentsDirectory stringByAppendingPathComponent:@"LanguageResources"];
}

- (void)setupBaseDirectory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    
    if (![fileManager fileExistsAtPath:self.baseDirectory isDirectory:&isDirectory]) {
        NSError *error = nil;
        [fileManager createDirectoryAtPath:self.baseDirectory
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:&error];
        if (error) {
            NSLog(@"Failed to create base directory: %@", error);
        }
    }
}


#pragma mark - Bundle 文件路径管理

- (NSString *)filePathForLanguage:(GlobalLanguage *)language table:(NSString *)table {
    // 获取 GlobalLanguage.bundle 路径
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"GlobalLanguage" ofType:@"bundle"];
    if (!bundlePath) {
        NSLog(@"GlobalLanguage.bundle not found in main bundle");
        return nil;
    }
    
    NSBundle *languageBundle = [NSBundle bundleWithPath:bundlePath];
    if (!languageBundle) {
        NSLog(@"Failed to load GlobalLanguage.bundle");
        return nil;
    }
    
    NSString *fileName = table ? [NSString stringWithFormat:@"%@_%@", language.languageType, table] : language.languageType;
    return [languageBundle pathForResource:fileName ofType:@"json"];
}

#pragma mark - 数据加载

- (void)loadLanguageDataForLanguage:(GlobalLanguage *)language
                         completion:(nullable LanguageDataLoadCompletion)completion {
    [self loadLanguageDataForLanguage:language table:nil completion:completion];
}

- (void)loadLanguageDataForLanguage:(GlobalLanguage *)language
                              table:(nullable NSString *)table
                         completion:(nullable LanguageDataLoadCompletion)completion {
    NSError *error = nil;
    BOOL success = NO;
    
    // 首先检查内存缓存
    NSString *cacheKey = table ? [NSString stringWithFormat:@"%@_%@", language.languageType, table] : language.languageType;
    NSDictionary *cachedData = [self.memoryCache stringsForLanguage:cacheKey];
    
    if (cachedData && self.enableMemoryCache) {
        self.languageData[cacheKey] = cachedData;
        success = YES;
    } else {
        // 检查自定义数据提供者
        id<GlobalLanguageDataProvider> customProvider = self.customDataProviders[language.languageType];
        if (customProvider) {
            NSDictionary *strings = [customProvider stringsForLanguage:language table:table];
            if (strings) {
                self.languageData[cacheKey] = strings;
                if (self.enableMemoryCache) {
                    [self.memoryCache setStrings:strings forLanguage:cacheKey];
                }
                success = YES;
            }
        }
        
        // 如果没有自定义提供者或提供者返回空，从 Bundle 文件加载
        if (!success) {
            NSString *filePath = [self filePathForLanguage:language table:table];
            NSDictionary *strings = [self loadStringsFromBundleFile:filePath error:&error];
            
            if (strings) {
                self.languageData[cacheKey] = strings;
                if (self.enableMemoryCache) {
                    [self.memoryCache setStrings:strings forLanguage:cacheKey];
                }
                success = YES;
            } else {
                NSLog(@"Failed to load language data for %@ from path: %@", language.languageType, filePath);
            }
        }
    }
    
    if (completion) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(success, error);
        });
    }
}

// 从 GlobalLanguage.bundle 加载 JSON 文件的方法
- (NSDictionary *)loadStringsFromBundleFile:(NSString *)filePath error:(NSError **)error {
    if (!filePath) {
        if (error) {
            *error = [NSError errorWithDomain:@"GlobalLanguageManager"
                                         code:404
                                     userInfo:@{NSLocalizedDescriptionKey: @"Language file path is nil"}];
        }
        return nil;
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        if (error) {
            *error = [NSError errorWithDomain:@"GlobalLanguageManager"
                                         code:404
                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Language file not found at path: %@", filePath]}];
        }
        return nil;
    }
    
    NSData *data = [NSData dataWithContentsOfFile:filePath options:0 error:error];
    if (!data) {
        return nil;
    }
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
    if (!jsonObject) {
        return nil;
    }
    
    // 检查是否是字典类型
    if (![jsonObject isKindOfClass:[NSDictionary class]]) {
        if (error) {
            *error = [NSError errorWithDomain:@"GlobalLanguageManager"
                                         code:500
                                     userInfo:@{NSLocalizedDescriptionKey: @"Invalid JSON format: root object is not a dictionary"}];
        }
        return nil;
    }
    
    NSDictionary *jsonDict = (NSDictionary *)jsonObject;
    
    // 提取 translations 字段
    NSDictionary *translations = jsonDict[@"translations"];
    if (!translations || ![translations isKindOfClass:[NSDictionary class]]) {
        if (error) {
            *error = [NSError errorWithDomain:@"GlobalLanguageManager"
                                         code:500
                                     userInfo:@{NSLocalizedDescriptionKey: @"Invalid JSON format: missing 'translations' dictionary"}];
        }
        return nil;
    }
    
    return translations;
}

#pragma mark - 本地化字符串获取

- (NSString *)localizedStringForKey:(NSString *)key {
    return [self localizedStringForKey:key table:nil arguments:nil];
}

- (NSString *)localizedStringForKey:(NSString *)key table:(nullable NSString *)table {
    return [self localizedStringForKey:key table:table arguments:nil];
}

- (NSString *)localizedStringForKey:(NSString *)key table:(nullable NSString *)table arguments:(nullable NSArray *)arguments {
    if (!key) return @"";
    
    NSString *cacheKey = table ? [NSString stringWithFormat:@"%@_%@", self.currentLanguage.languageType, table] : self.currentLanguage.languageType;
    NSDictionary *strings = self.languageData[cacheKey];
    
    NSString *result = strings[key];
    
    // 如果当前表中没找到，尝试在不带表名的默认数据中查找
    if (!result && table) {
        NSDictionary *defaultStrings = self.languageData[self.currentLanguage.languageType];
        result = defaultStrings[key];
    }
    
    // 如果还是没找到，回退到 key 本身
    if (!result) {
        result = key;
        NSLog(@"Localized string not found for key: %@ in language: %@, table: %@", key, self.currentLanguage.languageType, table ?: @"default");
    } else {
        // 移除语言标识前缀（如"[繁體中文] "）
        result = [self removeLanguagePrefixFromString:result];
    }
    
    // 处理格式化参数
    if (arguments && arguments.count > 0) {
        result = [self formatString:result withArguments:arguments];
    }
    
    return result;
}

// 移除语言标识前缀的方法
- (NSString *)removeLanguagePrefixFromString:(NSString *)string {
    // 匹配模式：[任意字符] 后面跟一个空格
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\[[^\\]]+\\]\\s"
                                                                           options:0
                                                                             error:nil];
    if (regex) {
        NSRange range = [regex rangeOfFirstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
        
        if (range.location != NSNotFound) {
            return [string substringFromIndex:range.length];
        }
    }
    
    return string;
}

// 字符串格式化方法
- (NSString *)formatString:(NSString *)string withArguments:(NSArray *)arguments {
    NSMutableString *result = [string mutableCopy];
    
    for (NSUInteger i = 0; i < arguments.count; i++) {
        NSString *placeholder = [NSString stringWithFormat:@"{%lu}", (unsigned long)i];
        NSString *replacement = [NSString stringWithFormat:@"%@", arguments[i]];
        
        [result replaceOccurrencesOfString:placeholder 
                                withString:replacement
                                   options:0
                                     range:NSMakeRange(0, result.length)];
        
        NSString *percentPlaceholder = [NSString stringWithFormat:@"%%%lu", (unsigned long)(i + 1)];
        [result replaceOccurrencesOfString:percentPlaceholder 
                                withString:replacement
                                   options:0
                                     range:NSMakeRange(0, result.length)];
        
        // 支持 %@ 占位符
        NSString *atPlaceholder = [NSString stringWithFormat:@"%%@"];
        if ([result containsString:atPlaceholder]) {
            NSRange range = [result rangeOfString:atPlaceholder];
            if (range.location != NSNotFound) {
                [result replaceCharactersInRange:range withString:replacement];
            }
        }
    }
    
    return [result copy];
}

#pragma mark - Bundle 资源管理

- (BOOL)copyBundledLanguageFilesToDocumentsIfNeeded {
    // 获取 GlobalLanguage.bundle 路径
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"GlobalLanguage" ofType:@"bundle"];
    if (!bundlePath) {
        NSLog(@"GlobalLanguage.bundle not found in main bundle");
        return NO;
    }
    
    NSBundle *languageBundle = [NSBundle bundleWithPath:bundlePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 获取 bundle 中所有 JSON 文件
    NSArray *jsonFiles = [languageBundle pathsForResourcesOfType:@"json" inDirectory:nil];
    
    BOOL success = YES;
    for (NSString *sourcePath in jsonFiles) {
        NSString *fileName = [sourcePath lastPathComponent];
        NSString *destinationPath = [self.baseDirectory stringByAppendingPathComponent:fileName];
        
        // 如果目标文件不存在，则复制
        if (![fileManager fileExistsAtPath:destinationPath]) {
            NSError *copyError = nil;
            [fileManager copyItemAtPath:sourcePath toPath:destinationPath error:&copyError];
            if (copyError) {
                NSLog(@"Failed to copy %@: %@", fileName, copyError);
                success = NO;
            } else {
                NSLog(@"Copied %@ to documents", fileName);
            }
        }
    }
    
    return success;
}

- (NSString *)getBundleResourcePath:(NSString *)resourceName ofType:(NSString *)type {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"GlobalLanguage" ofType:@"bundle"];
    if (!bundlePath) return nil;
    
    NSBundle *languageBundle = [NSBundle bundleWithPath:bundlePath];
    return [languageBundle pathForResource:resourceName ofType:type];
}

#pragma mark - 数据保存（用于动态更新语言文件）

- (BOOL)saveStrings:(NSDictionary<NSString *, NSString *> *)strings
        forLanguage:(GlobalLanguage *)language
              table:(nullable NSString *)table
              error:(NSError **)error {
    NSString *filePath = [self.baseDirectory stringByAppendingPathComponent:
                         table ? [NSString stringWithFormat:@"%@_%@.json", language.languageType, table] : 
                         [NSString stringWithFormat:@"%@.json", language.languageType]];
    
    return [self saveJSON:strings toFile:filePath error:error];
}

- (BOOL)saveJSON:(NSDictionary *)strings toFile:(NSString *)filePath error:(NSError **)error {
    NSData *data = [NSJSONSerialization dataWithJSONObject:strings
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:error];
    if (!data) return NO;
    
    return [data writeToFile:filePath options:NSDataWritingAtomic error:error];
}

#pragma mark - 公共方法

- (void)setLanguage:(GlobalLanguage *)language {
    // 检查语言是否可用
    BOOL isAvailable = NO;
    for (GlobalLanguage *availableLanguage in self.availableLanguages) {
        if ([availableLanguage.languageType isEqualToString:language.languageType]) {
            isAvailable = YES;
            break;
        }
    }
    
    if (!isAvailable) {
        NSLog(@"Language %@ is not available", language.languageType);
        return;
    }
    
    // 加载新语言的数据
    [self loadLanguageDataForLanguage:language completion:^(BOOL success, NSError *error) {
        if (success) {
            self.currentLanguage = language;
            
            // 保存设置
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:language.languageType forKey:@"SelectedGlobalLanguage"];
            [defaults synchronize];
            
            // 发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:GlobalLanguageDidChangeNotification object:language];
            
            NSLog(@"Language changed to: %@", language.displayName);
        } else {
            NSLog(@"Failed to load language data for %@: %@", language.languageType, error);
        }
    }];
}

- (void)configureAvailableLanguages:(NSArray<GlobalLanguage *> *)languages {
    self.availableLanguages = [languages copy];
    
    // 保存设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languageTypes = [languages valueForKeyPath:@"@unionOfObjects.languageType"];
    [defaults setObject:languageTypes forKey:@"AvailableGlobalLanguages"];
    [defaults synchronize];
    
    // 如果当前语言不在可用列表中，切换到第一个可用语言
    BOOL currentLanguageAvailable = NO;
    for (GlobalLanguage *language in languages) {
        if ([language.languageType isEqualToString:self.currentLanguage.languageType]) {
            currentLanguageAvailable = YES;
            break;
        }
    }
    
    if (!currentLanguageAvailable && languages.count > 0) {
        [self setLanguage:languages.firstObject];
    }
}

- (void)preloadLanguages:(NSArray<GlobalLanguage *> *)languages
              completion:(nullable LanguageDataLoadCompletion)completion {
    dispatch_group_t group = dispatch_group_create();
    __block NSError *lastError = nil;
    __block NSUInteger successCount = 0;
    
    for (GlobalLanguage *language in languages) {
        dispatch_group_enter(group);
        [self loadLanguageDataForLanguage:language completion:^(BOOL success, NSError *error) {
            if (success) {
                successCount++;
            } else {
                lastError = error;
            }
            dispatch_group_leave(group);
        }];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (completion) {
            completion(successCount == languages.count, lastError);
        }
    });
}

- (void)clearMemoryCache {
    [self.memoryCache clearAll];
    [self.languageData removeAllObjects];
    NSLog(@"Memory cache cleared");
}

- (void)clearDiskCacheWithCompletion:(nullable void(^)(void))completion {
    dispatch_async(self.dataQueue, ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error = nil;
        
        if ([fileManager fileExistsAtPath:self.baseDirectory]) {
            [fileManager removeItemAtPath:self.baseDirectory error:&error];
            if (error) {
                NSLog(@"Failed to clear disk cache: %@", error);
            }
            [self setupBaseDirectory]; // 重新创建目录
        }
        
        [self clearMemoryCache];
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), completion);
        }
    });
}

- (void)registerCustomDataProvider:(id<GlobalLanguageDataProvider>)provider forLanguage:(GlobalLanguageType)languageType {
    self.customDataProviders[languageType] = provider;
}

#pragma mark - 私有方法

- (void)loadSavedSettings {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
       // 加载可用的语言列表
    NSArray<NSString *> *savedLanguageTypes = [defaults stringArrayForKey:@"AvailableGlobalLanguages"];
    if (savedLanguageTypes) {
        NSMutableArray *languages = [NSMutableArray array];
        for (NSString *type in savedLanguageTypes) {
            [languages addObject:[GlobalLanguage languageWithType:type]];
        }
        self.availableLanguages = [languages copy];
    } else {
        // 默认启用所有支持的语言
        self.availableLanguages = [GlobalLanguage allSupportedLanguages];
    }
    
    // 加载保存的语言设置
    NSString *savedLanguageType = [defaults stringForKey:@"SelectedGlobalLanguage"];
    if (savedLanguageType) {
        self.currentLanguage = [GlobalLanguage languageWithType:savedLanguageType];
    } else {
        self.currentLanguage = [GlobalLanguage systemPreferredLanguage];
    }
    
 
    
    // 预加载当前语言数据
    [self loadLanguageDataForLanguage:self.currentLanguage completion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"Successfully preloaded language data for: %@", self.currentLanguage.languageType);
        } else {
            NSLog(@"Failed to preload language data for: %@, error: %@", self.currentLanguage.languageType, error);
        }
    }];
}

@end
