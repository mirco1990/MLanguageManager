//
//  GlobalLanguageDataProvider.h
//  WIFI_LED
//
//  Created by Parker on 2025/11/25.
//  Copyright © 2025 Parker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalLanguages.h"

NS_ASSUME_NONNULL_BEGIN
/// 自定义语言数据提供者协议
@protocol  GlobalLanguageDataProvider  <NSObject>

@required
/// 获取指定语言和表的字符串字典
/// @param language 语言
/// @param table 表名（可为nil）
/// @return 字符串字典
- (nullable NSDictionary<NSString *, NSString *> *)stringsForLanguage:(GlobalLanguage *)language table:(nullable NSString *)table;

@optional
/// 预加载语言数据
/// @param language 语言
/// @param table 表名（可为nil）
/// @param completion 完成回调
- (void)preloadStringsForLanguage:(GlobalLanguage *)language table:(nullable NSString *)table completion:(void(^)(BOOL success, NSError * _Nullable error))completion;

/// 检查语言数据是否可用
/// @param language 语言
/// @param table 表名（可为nil）
- (BOOL)isLanguageDataAvailable:(GlobalLanguage *)language table:(nullable NSString *)table;

/// 获取支持的语言列表
- (NSArray<GlobalLanguage *> *)supportedLanguages;

@end

NS_ASSUME_NONNULL_END
