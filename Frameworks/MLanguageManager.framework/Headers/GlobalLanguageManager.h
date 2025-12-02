//
//  GlobalLanguageManager.h
//  WIFI_LED
//
//  Created by Parker on 2025/11/25.
//  Copyright © 2025 Parker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import "GlobalLanguages.h"

#define localizedString(key) [[GlobalLanguageManager sharedManager] localizedStringForKey:key]

NS_ASSUME_NONNULL_BEGIN

/// 语言数据加载完成回调
typedef void(^LanguageDataLoadCompletion)(BOOL success, NSError * _Nullable error);

/// 全球语言管理器
@interface GlobalLanguageManager : NSObject

/// 单例实例
+ (instancetype)sharedManager;

/// 当前语言
@property (nonatomic, strong, readonly) GlobalLanguage *currentLanguage;

/// 可用的语言列表
@property (nonatomic, copy, readonly) NSArray<GlobalLanguage *> *availableLanguages;

/// 是否启用内存缓存
@property (nonatomic, assign) BOOL enableMemoryCache;

/// 设置当前语言
- (void)setLanguage:(GlobalLanguage *)language;

/// 配置可用的语言列表
- (void)configureAvailableLanguages:(NSArray<GlobalLanguage *> *)languages defaultLanguageType:(GlobalLanguageType)defaultType;

/// 加载语言数据
- (void)loadLanguageDataForLanguage:(GlobalLanguage *)language
                         completion:(nullable LanguageDataLoadCompletion)completion;

/// 预加载多个语言数据
- (void)preloadLanguages:(NSArray<GlobalLanguage *> *)languages
              completion:(nullable LanguageDataLoadCompletion)completion;

/// 获取本地化字符串
-(NSString *)localizedStringForKey:(NSString *)key;

/// 清除内存缓存
- (void)clearMemoryCache;

/// 清除磁盘缓存
- (void)clearDiskCacheWithCompletion:(nullable void(^)(void))completion;

/// 保存字符串到文件
- (BOOL)saveStrings:(NSDictionary<NSString *, NSString *> *)strings
        forLanguage:(GlobalLanguage *)language
              table:(nullable NSString *)table
              error:(NSError **)error;


@end

NS_ASSUME_NONNULL_END
