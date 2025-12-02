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
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageChineseSimplified;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageChineseTraditional;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageJapanese;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageKorean;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageHindi;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageArabic;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageHebrew;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageThai;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageVietnamese;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageIndonesian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageMalay;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageFilipino;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageBurmese;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageKhmer;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageLao;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageMongolian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageNepali;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageSinhala;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageTamil;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageTelugu;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageUrdu;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageBengali;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguagePersian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguagePashto;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageKurdish;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageKazakh;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageUzbek;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageTurkish; // 土耳其语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageAzerbaijani; // 阿塞拜疆语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageGeorgian; // 格鲁吉亚语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageArmenian; // 亚美尼亚语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageTurkmen; // 土库曼语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageTajik; // 塔吉克语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageKyrgyz; // 吉尔吉斯语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageDari; // 达里语（阿富汗波斯语）
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageKashmiri; // 克什米尔语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageSindhi; // 信德语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageMarathi; // 马拉地语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageGujarati; // 古吉拉特语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageKannada; // 卡纳达语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageMalayalam; // 马拉雅拉姆语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageOdia; // 奥里亚语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguagePunjabi; // 旁遮普语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageAssamese; // 阿萨姆语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageMaithili; // 迈蒂利语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageSantali; // 桑塔利语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageKashubian; // 卡舒比语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageTibetan; // 藏语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageUyghur; // 维吾尔语（修正拼写）
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageDzongkha; // 宗卡语（不丹）

// 欧洲语言
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageEnglish;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageSpanish;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageFrench;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageGerman;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageItalian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguagePortuguese;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageRussian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageDutch;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguagePolish;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageUkrainian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageRomanian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageGreek;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageCzech;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageSwedish;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageNorwegian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageDanish;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageFinnish;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageHungarian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageBulgarian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageCroatian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageSlovak;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageSlovenian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageSerbian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageBelarusian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageLithuanian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageLatvian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageEstonian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageIcelandic;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageAlbanian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageMacedonian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageMaltese;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageBosnian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageMontenegrin;
// 补充
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageCatalan; // 加泰罗尼亚语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageBasque ; // 巴斯克语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageGalician; // 加利西亚语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageWelsh; // 威尔士语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageIrish; // 爱尔兰语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageScottishGaelic; // 苏格兰盖尔语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageBreton; // 布列塔尼语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageLuxembourgish; // 卢森堡语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageFaroese; // 法罗语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageSami; // 萨米语

// 非洲语言
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageSwahili;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageAmharic;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageAfrikaans;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageYoruba;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageIgbo;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageHausa;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageSomali;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageZulu;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageXhosa;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageShona;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageOromo;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageMalagasy;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageKinyarwanda;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageKirundi;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageTigrinya;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageWolof;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageFulah;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageBambara;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageAfar; // 阿法尔语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageBemba; // 本巴语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageChichewa; // 齐切瓦语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageKikuyu; // 基库尤语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageKongo; // 刚果语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageLingala; // 林加拉语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageLuganda; // 卢干达语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageNdebele; // 恩德贝勒语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageSesotho; // 塞索托语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageSetswana; // 茨瓦纳语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageSwati; // 斯瓦特语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageTsonga; // 聪加语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageVenda; // 文达语

// 美洲语言
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguagePortugueseBrazil;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageSpanishLatinAmerica;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageFrenchCanadian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageQuechua;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageGuarani;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageAymara;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageNahuatl;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageMapudungun;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageQuechuaPeru; // 秘鲁克丘亚语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageGuaraniParaguay; // 巴拉圭瓜拉尼语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageCreoleHaitian; // 海地克里奥尔语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageGreenlandic; // 格陵兰语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageInuktitut; // 因纽特语

// 大洋洲语言
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageMaori;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageHawaiian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageFijian;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageSamoan;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageTongan;
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageMaoriNewZealand; // 新西兰毛利语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageTokPisin; // 托克皮辛语（巴布亚新几内亚）
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageFijianHindi; // 斐济印地语
FOUNDATION_EXPORT GlobalLanguageType const GlobalLanguageUnknown;
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
