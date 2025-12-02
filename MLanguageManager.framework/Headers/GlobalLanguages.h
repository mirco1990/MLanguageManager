//
//  APPLanguage.h
//  WIFI_LED
//
//  Created by Parker on 2025/11/25.
//  Copyright © 2025 Parker. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

/// 全球语言类型定义
typedef NSString * GlobalLanguageType NS_STRING_ENUM;

// 亚洲语言
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageChineseSimplified;// 简体中文
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageChineseTraditional;// 繁体中午呢
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageJapanese;// 日语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageKorean;// 韩语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageHindi;//印地语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageArabic;// 阿拉伯语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageHebrew;//希伯来语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageThai;// 泰语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageVietnamese;// 越南语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageIndonesian;;//印尼语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageMalay;//马来语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageFilipino;//菲律宾语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageBurmese;//缅甸语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageKhmer;//高棉语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageLao;//老挝语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageMongolian;//蒙古语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageNepali;//尼泊尔语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageSinhala;//僧伽罗语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageTamil;//泰米尔语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageTelugu;//泰卢固语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageUrdu;//乌尔都语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageBengali;//孟加拉语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguagePersian;//波斯语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguagePashto;//普什图语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageKurdish;//库尔德语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageKazakh;//哈萨克语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageUzbek;//乌兹别克语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageTurkish; // 土耳其语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageAzerbaijani; // 阿塞拜疆语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageGeorgian;// 格鲁吉亚语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageArmenian; // 亚美尼亚语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageTurkmen;// 土库曼语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageTajik; // 塔吉克语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageKyrgyz; // 吉尔吉斯语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageDari; // 达里语（阿富汗波斯语）
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageKashmiri; // 克什米尔语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageSindhi; // 信德语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageMarathi; // 马拉地语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageGujarati; // 古吉拉特语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageKannada; // 卡纳达语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageMalayalam; // 马拉雅拉姆语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageOdia; // 奥里亚语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguagePunjabi; // 旁遮普语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageAssamese; // 阿萨姆语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageMaithili; // 迈蒂利语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageSantali; // 桑塔利语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageKashubian; // 卡舒比语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageTibetan; // 藏语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageUyghur; // 维吾尔语（修正拼写）
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageDzongkha; // 宗卡语（不丹）


// 欧洲语言
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageEnglish;// 英语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageSpanish;// 西班牙语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageFrench;// 法语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageGerman;// 德语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageItalian;// 意大利
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguagePortuguese;// 葡萄牙
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageRussian;// 俄语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageDutch;// 荷兰语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguagePolish;//波兰语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageUkrainian;
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageRomanian;//罗马尼亚语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageGreek;// 希腊语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageCzech;//捷克语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageSwedish;//瑞典语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageNorwegian;//挪威语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageDanish;//丹麦语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageFinnish;//芬兰语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageHungarian;//匈牙利语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageBulgarian;//保加利亚语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageCroatian;//克罗地亚语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageSlovak;//斯洛伐克语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageSlovenian;//斯洛文尼亚语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageSerbian;//塞尔维亚语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageBelarusian;//白俄罗斯语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageLithuanian;//立陶宛语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageLatvian;//拉脱维亚语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageEstonian;//爱沙尼亚语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageIcelandic;//冰岛语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageAlbanian;//阿尔巴尼亚语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageMacedonian;//马其顿语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageMaltese;//马耳他语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageBosnian;//波斯尼亚语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageMontenegrin;//黑山语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageCatalan; // 加泰罗尼亚语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageBasque; // 巴斯克语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageGalician; // 加利西亚语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageWelsh; // 威尔士语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageIrish; // 爱尔兰语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageScottishGaelic; // 苏格兰盖尔语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageBreton; // 布列塔尼语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageLuxembourgish; // 卢森堡语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageFaroese; // 法罗语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageSami; // 萨米语

//// 非洲语言
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageSwahili;//斯瓦希里语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageAmharic;//阿姆哈拉语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageAfrikaans;//南非荷兰语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageYoruba;//约鲁巴语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageIgbo;// 伊博语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageHausa;// 豪萨语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageSomali;// 索马里语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageZulu;// 祖鲁语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageXhosa;// 科萨语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageShona;// 绍纳语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageOromo;// 奥罗莫语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageMalagasy;// 马尔加什语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageKinyarwanda;// 卢旺达语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageKirundi; // 隆迪语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageTigrinya;// 提格里尼亚语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageWolof;// 沃洛夫语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageFulah;// 富拉语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageBambara;// 班巴拉语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageAfar; // 阿法尔语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageBemba; // 本巴语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageChichewa; // 齐切瓦语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageKikuyu; // 基库尤语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageKongo; // 刚果语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageLingala; // 林加拉语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageLuganda; // 卢干达语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageNdebele; // 恩德贝勒语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageSesotho; // 塞索托语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageSetswana; // 茨瓦纳语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageSwati; // 斯瓦特语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageTsonga; // 聪加语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageVenda; // 文达语
// 美洲语言
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguagePortugueseBrazil;// 巴西葡萄牙语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageSpanishLatinAmerica;// 拉丁美洲西班牙语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageFrenchCanadian;// 加拿大法语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageQuechua;// 克丘亚语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageGuarani;// 瓜拉尼语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageAymara;// 艾马拉语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageNahuatl;// 纳瓦特尔语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageMapudungun;// 马普切语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageQuechuaPeru; // 秘鲁克丘亚语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageGuaraniParaguay; // 巴拉圭瓜拉尼语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageCreoleHaitian; // 海地克里奥尔语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageGreenlandic; // 格陵兰语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageInuktitut; // 因纽特语

// 大洋洲语言
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageMaori;//毛利语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageHawaiian;//夏威夷语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageFijian;// 斐济语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageSamoan;// 萨摩亚语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageTongan; //汤加语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageMaoriNewZealand; // 新西兰毛利语
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageTokPisin; // 托克皮辛语（巴布亚新几内亚）
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageFijianHind; // 斐济印地语

// 未知语言
FOUNDATION_EXPORT GlobalLanguageType constGlobalLanguageUnknown;

/// 语言变更通知
FOUNDATION_EXPORT NSNotificationName const GlobalLanguageDidChangeNotification;

/// 全球语言模型
@interface GlobalLanguage : NSObject

@property (nonatomic, copy, readonly) GlobalLanguageType languageType;
@property (nonatomic, copy, readonly) NSString *displayName;
@property (nonatomic, copy, readonly) NSString *nativeName;
@property (nonatomic, strong, readonly) NSLocale *locale;
@property (nonatomic, copy, readonly) NSString *languageCode;
@property (nonatomic, copy, readonly) NSString *regionCode;

+ (instancetype)languageWithType:(GlobalLanguageType)type;
- (instancetype)initWithType:(GlobalLanguageType)type;

/// 获取所有支持的语言
+ (NSArray<GlobalLanguage *> *)allSupportedLanguages;

/// 按地区分组获取语言
+ (NSDictionary<NSString *, NSArray<GlobalLanguage *> *> *)languagesGroupedByRegion;

/// 获取系统首选语言
+ (GlobalLanguage *)systemPreferredLanguage;

/// 根据语言代码创建语言实例
+ (GlobalLanguage *)languageWithCode:(NSString *)languageCode;

/// 获取中文名称
/// - Parameter type: 中文语言名称
- (NSString *)displayNameForLanguageType:(GlobalLanguageType)type;

/// 获取语言显示名称
/// - Parameter type: 显示名称
- (NSString *)nativeNameForLanguageType:(GlobalLanguageType)type;

@end

NS_ASSUME_NONNULL_END
