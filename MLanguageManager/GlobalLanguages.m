//
//  APPLanguage.m
//  WIFI_LED
//
//  Created by Parker on 2025/11/25.
//  Copyright © 2025 Parker. All rights reserved.
//

 #import "GlobalLanguages.h"

// 亚洲语言
GlobalLanguageType const GlobalLanguageChineseSimplified = @"zh-Hans";
GlobalLanguageType const GlobalLanguageChineseTraditional = @"zh-Hant";
GlobalLanguageType const GlobalLanguageJapanese = @"ja";
GlobalLanguageType const GlobalLanguageKorean = @"ko";
GlobalLanguageType const GlobalLanguageHindi = @"hi";
GlobalLanguageType const GlobalLanguageArabic = @"ar";
GlobalLanguageType const GlobalLanguageHebrew = @"he";
GlobalLanguageType const GlobalLanguageThai = @"th";
GlobalLanguageType const GlobalLanguageVietnamese = @"vi";
GlobalLanguageType const GlobalLanguageIndonesian = @"id";
GlobalLanguageType const GlobalLanguageMalay = @"ms";
GlobalLanguageType const GlobalLanguageFilipino = @"fil";
GlobalLanguageType const GlobalLanguageBurmese = @"my";
GlobalLanguageType const GlobalLanguageKhmer = @"km";
GlobalLanguageType const GlobalLanguageLao = @"lo";
GlobalLanguageType const GlobalLanguageMongolian = @"mn";
GlobalLanguageType const GlobalLanguageNepali = @"ne";
GlobalLanguageType const GlobalLanguageSinhala = @"si";
GlobalLanguageType const GlobalLanguageTamil = @"ta";
GlobalLanguageType const GlobalLanguageTelugu = @"te";
GlobalLanguageType const GlobalLanguageUrdu = @"ur";
GlobalLanguageType const GlobalLanguageBengali = @"bn";
GlobalLanguageType const GlobalLanguagePersian = @"fa";
GlobalLanguageType const GlobalLanguagePashto = @"ps";
GlobalLanguageType const GlobalLanguageKurdish = @"ku";
GlobalLanguageType const GlobalLanguageUighur = @"ug";
GlobalLanguageType const GlobalLanguageKazakh = @"kk";
GlobalLanguageType const GlobalLanguageUzbek = @"uz";

// 欧洲语言
GlobalLanguageType const GlobalLanguageEnglish = @"en";
GlobalLanguageType const GlobalLanguageSpanish = @"es";
GlobalLanguageType const GlobalLanguageFrench = @"fr";
GlobalLanguageType const GlobalLanguageGerman = @"de";
GlobalLanguageType const GlobalLanguageItalian = @"it";
GlobalLanguageType const GlobalLanguagePortuguese = @"pt";
GlobalLanguageType const GlobalLanguageRussian = @"ru";
GlobalLanguageType const GlobalLanguageDutch = @"nl";
GlobalLanguageType const GlobalLanguagePolish = @"pl";
GlobalLanguageType const GlobalLanguageUkrainian = @"uk";
GlobalLanguageType const GlobalLanguageRomanian = @"ro";
GlobalLanguageType const GlobalLanguageGreek = @"el";
GlobalLanguageType const GlobalLanguageCzech = @"cs";
GlobalLanguageType const GlobalLanguageSwedish = @"sv";
GlobalLanguageType const GlobalLanguageNorwegian = @"no";
GlobalLanguageType const GlobalLanguageDanish = @"da";
GlobalLanguageType const GlobalLanguageFinnish = @"fi";
GlobalLanguageType const GlobalLanguageHungarian = @"hu";
GlobalLanguageType const GlobalLanguageBulgarian = @"bg";
GlobalLanguageType const GlobalLanguageCroatian = @"hr";
GlobalLanguageType const GlobalLanguageSlovak = @"sk";
GlobalLanguageType const GlobalLanguageSlovenian = @"sl";
GlobalLanguageType const GlobalLanguageSerbian = @"sr";
GlobalLanguageType const GlobalLanguageBelarusian = @"be";
GlobalLanguageType const GlobalLanguageLithuanian = @"lt";
GlobalLanguageType const GlobalLanguageLatvian = @"lv";
GlobalLanguageType const GlobalLanguageEstonian = @"et";
GlobalLanguageType const GlobalLanguageIcelandic = @"is";
GlobalLanguageType const GlobalLanguageAlbanian = @"sq";
GlobalLanguageType const GlobalLanguageMacedonian = @"mk";
GlobalLanguageType const GlobalLanguageMaltese = @"mt";
GlobalLanguageType const GlobalLanguageBosnian = @"bs";
GlobalLanguageType const GlobalLanguageMontenegrin = @"cnr";

// 非洲语言
GlobalLanguageType const GlobalLanguageSwahili = @"sw";
GlobalLanguageType const GlobalLanguageAmharic = @"am";
GlobalLanguageType const GlobalLanguageAfrikaans = @"af";
GlobalLanguageType const GlobalLanguageYoruba = @"yo";
GlobalLanguageType const GlobalLanguageIgbo = @"ig";
GlobalLanguageType const GlobalLanguageHausa = @"ha";
GlobalLanguageType const GlobalLanguageSomali = @"so";
GlobalLanguageType const GlobalLanguageZulu = @"zu";
GlobalLanguageType const GlobalLanguageXhosa = @"xh";
GlobalLanguageType const GlobalLanguageShona = @"sn";
GlobalLanguageType const GlobalLanguageOromo = @"om";
GlobalLanguageType const GlobalLanguageMalagasy = @"mg";
GlobalLanguageType const GlobalLanguageKinyarwanda = @"rw";
GlobalLanguageType const GlobalLanguageKirundi = @"rn";
GlobalLanguageType const GlobalLanguageTigrinya = @"ti";
GlobalLanguageType const GlobalLanguageWolof = @"wo";
GlobalLanguageType const GlobalLanguageFulah = @"ff";
GlobalLanguageType const GlobalLanguageBambara = @"bm";

// 美洲语言
GlobalLanguageType const GlobalLanguagePortugueseBrazil = @"pt-BR";
GlobalLanguageType const GlobalLanguageSpanishLatinAmerica = @"es-419";
GlobalLanguageType const GlobalLanguageFrenchCanadian = @"fr-CA";
GlobalLanguageType const GlobalLanguageQuechua = @"qu";
GlobalLanguageType const GlobalLanguageGuarani = @"gn";
GlobalLanguageType const GlobalLanguageAymara = @"ay";
GlobalLanguageType const GlobalLanguageNahuatl = @"nah";
GlobalLanguageType const GlobalLanguageMapudungun = @"arn";

// 大洋洲语言
GlobalLanguageType const GlobalLanguageMaori = @"mi";
GlobalLanguageType const GlobalLanguageHawaiian = @"haw";
GlobalLanguageType const GlobalLanguageFijian = @"fj";
GlobalLanguageType const GlobalLanguageSamoan = @"sm";
GlobalLanguageType const GlobalLanguageTongan = @"to";

// 通知定义
NSNotificationName const GlobalLanguageDidChangeNotification = @"GlobalLanguageDidChangeNotification";

@implementation GlobalLanguage

- (instancetype)initWithType:(GlobalLanguageType)type {
    self = [super init];
    if (self) {
        _languageType = [type copy];
        _locale = [NSLocale localeWithLocaleIdentifier:type];
        
        // 解析语言代码和地区代码
        NSArray *components = [type componentsSeparatedByString:@"-"];
        _languageCode = components.firstObject;
        if (components.count > 1) {
            _regionCode = components[1];
        }
        
        _displayName = [self displayNameForLanguageType:type];
        _nativeName = [self nativeNameForLanguageType:type];
    }
    return self;
}

+ (instancetype)languageWithType:(GlobalLanguageType)type {
    return [[self alloc] initWithType:type];
}

+ (GlobalLanguage *)languageWithCode:(NSString *)languageCode {
    return [[self alloc] initWithType:languageCode];
}

- (NSString *)displayNameForLanguageType:(GlobalLanguageType)type {
    NSDictionary *displayNames = @{
        // 亚洲语言
        GlobalLanguageChineseSimplified: @"简体中文",
        GlobalLanguageChineseTraditional: @"繁體中文",
        GlobalLanguageJapanese: @"日语",
        GlobalLanguageKorean: @"韩语",
        GlobalLanguageHindi: @"印地语",
        GlobalLanguageArabic: @"阿拉伯语",
        GlobalLanguageHebrew: @"希伯来语",
        GlobalLanguageThai: @"泰语",
        GlobalLanguageVietnamese: @"越南语",
        GlobalLanguageIndonesian: @"印尼语",
        GlobalLanguageMalay: @"马来语",
        GlobalLanguageFilipino: @"菲律宾语",
        GlobalLanguageBurmese: @"缅甸语",
        GlobalLanguageKhmer: @"高棉语",
        GlobalLanguageLao: @"老挝语",
        GlobalLanguageMongolian: @"蒙古语",
        GlobalLanguageNepali: @"尼泊尔语",
        GlobalLanguageSinhala: @"僧伽罗语",
        GlobalLanguageTamil: @"泰米尔语",
        GlobalLanguageTelugu: @"泰卢固语",
        GlobalLanguageUrdu: @"乌尔都语",
        GlobalLanguageBengali: @"孟加拉语",
        GlobalLanguagePersian: @"波斯语",
        GlobalLanguagePashto: @"普什图语",
        GlobalLanguageKurdish: @"库尔德语",
        GlobalLanguageUighur: @"维吾尔语",
        GlobalLanguageKazakh: @"哈萨克语",
        GlobalLanguageUzbek: @"乌兹别克语",
        
        // 欧洲语言
        GlobalLanguageEnglish: @"英语",
        GlobalLanguageSpanish: @"西班牙语",
        GlobalLanguageFrench: @"法语",
        GlobalLanguageGerman: @"德语",
        GlobalLanguageItalian: @"意大利语",
        GlobalLanguagePortuguese: @"葡萄牙语",
        GlobalLanguageRussian: @"俄语",
        GlobalLanguageDutch: @"荷兰语",
        GlobalLanguagePolish: @"波兰语",
        GlobalLanguageUkrainian: @"乌克兰语",
        GlobalLanguageRomanian: @"罗马尼亚语",
        GlobalLanguageGreek: @"希腊语",
        GlobalLanguageCzech: @"捷克语",
        GlobalLanguageSwedish: @"瑞典语",
        GlobalLanguageNorwegian: @"挪威语",
        GlobalLanguageDanish: @"丹麦语",
        GlobalLanguageFinnish: @"芬兰语",
        GlobalLanguageHungarian: @"匈牙利语",
        GlobalLanguageBulgarian: @"保加利亚语",
        GlobalLanguageCroatian: @"克罗地亚语",
        GlobalLanguageSlovak: @"斯洛伐克语",
        GlobalLanguageSlovenian: @"斯洛文尼亚语",
        GlobalLanguageSerbian: @"塞尔维亚语",
        GlobalLanguageBelarusian: @"白俄罗斯语",
        GlobalLanguageLithuanian: @"立陶宛语",
        GlobalLanguageLatvian: @"拉脱维亚语",
        GlobalLanguageEstonian: @"爱沙尼亚语",
        GlobalLanguageIcelandic: @"冰岛语",
        GlobalLanguageAlbanian: @"阿尔巴尼亚语",
        GlobalLanguageMacedonian: @"马其顿语",
        GlobalLanguageMaltese: @"马耳他语",
        GlobalLanguageBosnian: @"波斯尼亚语",
        GlobalLanguageMontenegrin: @"黑山语",
        
        // 非洲语言
        GlobalLanguageSwahili: @"斯瓦希里语",
        GlobalLanguageAmharic: @"阿姆哈拉语",
        GlobalLanguageAfrikaans: @"南非荷兰语",
        GlobalLanguageYoruba: @"约鲁巴语",
        GlobalLanguageIgbo: @"伊博语",
        GlobalLanguageHausa: @"豪萨语",
        GlobalLanguageSomali: @"索马里语",
        GlobalLanguageZulu: @"祖鲁语",
        GlobalLanguageXhosa: @"科萨语",
        GlobalLanguageShona: @"绍纳语",
        GlobalLanguageOromo: @"奥罗莫语",
        GlobalLanguageMalagasy: @"马尔加什语",
        GlobalLanguageKinyarwanda: @"卢旺达语",
        GlobalLanguageKirundi: @"隆迪语",
        GlobalLanguageTigrinya: @"提格里尼亚语",
        GlobalLanguageWolof: @"沃洛夫语",
        GlobalLanguageFulah: @"富拉语",
        GlobalLanguageBambara: @"班巴拉语",
        
        // 美洲语言
        GlobalLanguagePortugueseBrazil: @"巴西葡萄牙语",
        GlobalLanguageSpanishLatinAmerica: @"拉丁美洲西班牙语",
        GlobalLanguageFrenchCanadian: @"加拿大法语",
        GlobalLanguageQuechua: @"克丘亚语",
        GlobalLanguageGuarani: @"瓜拉尼语",
        GlobalLanguageAymara: @"艾马拉语",
        GlobalLanguageNahuatl: @"纳瓦特尔语",
        GlobalLanguageMapudungun: @"马普切语",
        
        // 大洋洲语言
        GlobalLanguageMaori: @"毛利语",
        GlobalLanguageHawaiian: @"夏威夷语",
        GlobalLanguageFijian: @"斐济语",
        GlobalLanguageSamoan: @"萨摩亚语",
        GlobalLanguageTongan: @"汤加语"
    };
    
    return displayNames[type] ?: type;
}

- (NSString *)nativeNameForLanguageType:(GlobalLanguageType)type {
    NSDictionary *nativeNames = @{
        // 亚洲语言
        GlobalLanguageChineseSimplified: @"简体中文",
        GlobalLanguageChineseTraditional: @"繁體中文",
        GlobalLanguageJapanese: @"日本語",
        GlobalLanguageKorean: @"한국어",
        GlobalLanguageHindi: @"हिन्दी",
        GlobalLanguageArabic: @"العربية",
        GlobalLanguageHebrew: @"עברית",
        GlobalLanguageThai: @"ไทย",
        GlobalLanguageVietnamese: @"Tiếng Việt",
        GlobalLanguageIndonesian: @"Bahasa Indonesia",
        GlobalLanguageMalay: @"Bahasa Melayu",
        GlobalLanguageFilipino: @"Filipino",
        GlobalLanguageBurmese: @"မြန်မာစာ",
        GlobalLanguageKhmer: @"ភាសាខ្មែរ",
        GlobalLanguageLao: @"ພາສາລາວ",
        GlobalLanguageMongolian: @"Монгол хэл",
        GlobalLanguageNepali: @"नेपाली",
        GlobalLanguageSinhala: @"සිංහල",
        GlobalLanguageTamil: @"தமிழ்",
        GlobalLanguageTelugu: @"తెలుగు",
        GlobalLanguageUrdu: @"اردو",
        GlobalLanguageBengali: @"বাংলা",
        GlobalLanguagePersian: @"فارسی",
        GlobalLanguagePashto: @"پښتو",
        GlobalLanguageKurdish: @"Kurdî",
        GlobalLanguageUighur: @"ئۇيغۇرچە",
        GlobalLanguageKazakh: @"Қазақ тілі",
        GlobalLanguageUzbek: @"Oʻzbekcha",
        
        // 欧洲语言
        GlobalLanguageEnglish: @"English",
        GlobalLanguageSpanish: @"Español",
        GlobalLanguageFrench: @"Français",
        GlobalLanguageGerman: @"Deutsch",
        GlobalLanguageItalian: @"Italiano",
        GlobalLanguagePortuguese: @"Português",
        GlobalLanguageRussian: @"Русский",
        GlobalLanguageDutch: @"Nederlands",
        GlobalLanguagePolish: @"Polski",
        GlobalLanguageUkrainian: @"Українська",
        GlobalLanguageRomanian: @"Română",
        GlobalLanguageGreek: @"Ελληνικά",
        GlobalLanguageCzech: @"Čeština",
        GlobalLanguageSwedish: @"Svenska",
        GlobalLanguageNorwegian: @"Norsk",
        GlobalLanguageDanish: @"Dansk",
        GlobalLanguageFinnish: @"Suomi",
        GlobalLanguageHungarian: @"Magyar",
        GlobalLanguageBulgarian: @"Български",
        GlobalLanguageCroatian: @"Hrvatski",
        GlobalLanguageSlovak: @"Slovenčina",
        GlobalLanguageSlovenian: @"Slovenščina",
        GlobalLanguageSerbian: @"Српски",
        GlobalLanguageBelarusian: @"Беларуская",
        GlobalLanguageLithuanian: @"Lietuvių",
        GlobalLanguageLatvian: @"Latviešu",
        GlobalLanguageEstonian: @"Eesti",
        GlobalLanguageIcelandic: @"Íslenska",
        GlobalLanguageAlbanian: @"Shqip",
        GlobalLanguageMacedonian: @"Македонски",
        GlobalLanguageMaltese: @"Malti",
        GlobalLanguageBosnian: @"Bosanski",
        GlobalLanguageMontenegrin: @"Crnogorski",
        
        // 非洲语言
        GlobalLanguageSwahili: @"Kiswahili",
        GlobalLanguageAmharic: @"አማርኛ",
        GlobalLanguageAfrikaans: @"Afrikaans",
        GlobalLanguageYoruba: @"Yorùbá",
        GlobalLanguageIgbo: @"Igbo",
        GlobalLanguageHausa: @"Hausa",
        GlobalLanguageSomali: @"Soomaali",
        GlobalLanguageZulu: @"isiZulu",
        GlobalLanguageXhosa: @"isiXhosa",
        GlobalLanguageShona: @"chiShona",
        GlobalLanguageOromo: @"Oromoo",
        GlobalLanguageMalagasy: @"Malagasy",
        GlobalLanguageKinyarwanda: @"Kinyarwanda",
        GlobalLanguageKirundi: @"Ikirundi",
        GlobalLanguageTigrinya: @"ትግርኛ",
        GlobalLanguageWolof: @"Wolof",
        GlobalLanguageFulah: @"Pulaar",
        GlobalLanguageBambara: @"Bamanankan",
        
        // 美洲语言
        GlobalLanguagePortugueseBrazil: @"Português Brasileiro",
        GlobalLanguageSpanishLatinAmerica: @"Español Latinoamericano",
        GlobalLanguageFrenchCanadian: @"Français Canadien",
        GlobalLanguageQuechua: @"Runa Simi",
        GlobalLanguageGuarani: @"Avañe'ẽ",
        GlobalLanguageAymara: @"Aymar aru",
        GlobalLanguageNahuatl: @"Nāhuatl",
        GlobalLanguageMapudungun: @"Mapudungun",
        
        // 大洋洲语言
        GlobalLanguageMaori: @"Māori",
        GlobalLanguageHawaiian: @"ʻŌlelo Hawaiʻi",
        GlobalLanguageFijian: @"Na Vosa Vakaviti",
        GlobalLanguageSamoan: @"Gagana Samoa",
        GlobalLanguageTongan: @"Lea Faka-Tonga"
    };
    
    return nativeNames[type] ?: type;
}

+ (NSArray<GlobalLanguage *> *)allSupportedLanguages {
    static NSArray<GlobalLanguage *> *allLanguages = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray<GlobalLanguageType> *types = @[
            // 亚洲语言
            GlobalLanguageChineseSimplified,
            GlobalLanguageChineseTraditional,
            GlobalLanguageJapanese,
            GlobalLanguageKorean,
            GlobalLanguageHindi,
            GlobalLanguageArabic,
            GlobalLanguageHebrew,
            GlobalLanguageThai,
            GlobalLanguageVietnamese,
            GlobalLanguageIndonesian,
            GlobalLanguageMalay,
            GlobalLanguageFilipino,
            GlobalLanguageBurmese,
            GlobalLanguageKhmer,
            GlobalLanguageLao,
            GlobalLanguageMongolian,
            GlobalLanguageNepali,
            GlobalLanguageSinhala,
            GlobalLanguageTamil,
            GlobalLanguageTelugu,
            GlobalLanguageUrdu,
            GlobalLanguageBengali,
            GlobalLanguagePersian,
            GlobalLanguagePashto,
            GlobalLanguageKurdish,
            GlobalLanguageUighur,
            GlobalLanguageKazakh,
            GlobalLanguageUzbek,
            
            // 欧洲语言
            GlobalLanguageEnglish,
            GlobalLanguageSpanish,
            GlobalLanguageFrench,
            GlobalLanguageGerman,
            GlobalLanguageItalian,
            GlobalLanguagePortuguese,
            GlobalLanguageRussian,
            GlobalLanguageDutch,
            GlobalLanguagePolish,
            GlobalLanguageUkrainian,
            GlobalLanguageRomanian,
            GlobalLanguageGreek,
            GlobalLanguageCzech,
            GlobalLanguageSwedish,
            GlobalLanguageNorwegian,
            GlobalLanguageDanish,
            GlobalLanguageFinnish,
            GlobalLanguageHungarian,
            GlobalLanguageBulgarian,
            GlobalLanguageCroatian,
            GlobalLanguageSlovak,
            GlobalLanguageSlovenian,
            GlobalLanguageSerbian,
            GlobalLanguageBelarusian,
            GlobalLanguageLithuanian,
            GlobalLanguageLatvian,
            GlobalLanguageEstonian,
            GlobalLanguageIcelandic,
            GlobalLanguageAlbanian,
            GlobalLanguageMacedonian,
            GlobalLanguageMaltese,
            GlobalLanguageBosnian,
            GlobalLanguageMontenegrin,
            
            // 非洲语言
            GlobalLanguageSwahili,
            GlobalLanguageAmharic,
            GlobalLanguageAfrikaans,
            GlobalLanguageYoruba,
            GlobalLanguageIgbo,
            GlobalLanguageHausa,
            GlobalLanguageSomali,
            GlobalLanguageZulu,
            GlobalLanguageXhosa,
            GlobalLanguageShona,
            GlobalLanguageOromo,
            GlobalLanguageMalagasy,
            GlobalLanguageKinyarwanda,
            GlobalLanguageKirundi,
            GlobalLanguageTigrinya,
            GlobalLanguageWolof,
            GlobalLanguageFulah,
            GlobalLanguageBambara,
            
            // 美洲语言
            GlobalLanguagePortugueseBrazil,
            GlobalLanguageSpanishLatinAmerica,
            GlobalLanguageFrenchCanadian,
            GlobalLanguageQuechua,
            GlobalLanguageGuarani,
            GlobalLanguageAymara,
            GlobalLanguageNahuatl,
            GlobalLanguageMapudungun,
            
            // 大洋洲语言
            GlobalLanguageMaori,
            GlobalLanguageHawaiian,
            GlobalLanguageFijian,
            GlobalLanguageSamoan,
            GlobalLanguageTongan
        ];
        
        NSMutableArray *languages = [NSMutableArray array];
        for (GlobalLanguageType type in types) {
            [languages addObject:[GlobalLanguage languageWithType:type]];
        }
        allLanguages = [languages copy];
    });
    return allLanguages;
}

+ (NSDictionary<NSString *, NSArray<GlobalLanguage *> *> *)languagesGroupedByRegion {
    static NSDictionary *groupedLanguages = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary *groups = [NSMutableDictionary dictionary];
        
        for (GlobalLanguage *language in [self allSupportedLanguages]) {
            NSString *region = [self regionForLanguage:language];
            if (!groups[region]) {
                groups[region] = [NSMutableArray array];
            }
            [groups[region] addObject:language];
        }
        
        groupedLanguages = [groups copy];
    });
    return groupedLanguages;
}

+ (NSString *)regionForLanguage:(GlobalLanguage *)language {
    // 简化的地区分类
    if ([language.languageCode isEqualToString:@"zh"] || 
        [language.languageCode isEqualToString:@"ja"] ||
        [language.languageCode isEqualToString:@"ko"]) {
        return @"东亚";
    } else if ([language.languageCode isEqualToString:@"hi"] ||
               [language.languageCode isEqualToString:@"bn"] ||
               [language.languageCode isEqualToString:@"ta"] ||
               [language.languageCode isEqualToString:@"te"] ||
               [language.languageCode isEqualToString:@"ur"]) {
        return @"南亚";
    } else if ([language.languageCode isEqualToString:@"ar"] ||
               [language.languageCode isEqualToString:@"he"] ||
               [language.languageCode isEqualToString:@"fa"] ||
               [language.languageCode isEqualToString:@"ku"]) {
        return @"中东";
    } else if ([language.languageCode isEqualToString:@"th"] ||
               [language.languageCode isEqualToString:@"vi"] ||
               [language.languageCode isEqualToString:@"id"] ||
               [language.languageCode isEqualToString:@"ms"] ||
               [language.languageCode isEqualToString:@"fil"]) {
        return @"东南亚";
    } else if ([language.languageCode isEqualToString:@"en"] ||
               [language.languageCode isEqualToString:@"fr"] ||
               [language.languageCode isEqualToString:@"de"] ||
               [language.languageCode isEqualToString:@"it"] ||
               [language.languageCode isEqualToString:@"es"] ||
               [language.languageCode isEqualToString:@"pt"] ||
               [language.languageCode isEqualToString:@"ru"]) {
        return @"欧洲主要";
    } else if ([language.languageCode isEqualToString:@"pl"] ||
               [language.languageCode isEqualToString:@"uk"] ||
               [language.languageCode isEqualToString:@"ro"] ||
               [language.languageCode isEqualToString:@"hu"] ||
               [language.languageCode isEqualToString:@"cs"] ||
               [language.languageCode isEqualToString:@"sk"] ||
               [language.languageCode isEqualToString:@"bg"] ||
               [language.languageCode isEqualToString:@"hr"] ||
               [language.languageCode isEqualToString:@"sr"] ||
               [language.languageCode isEqualToString:@"sl"]) {
        return @"东欧";
    } else if ([language.languageCode isEqualToString:@"sv"] ||
               [language.languageCode isEqualToString:@"no"] ||
               [language.languageCode isEqualToString:@"da"] ||
               [language.languageCode isEqualToString:@"fi"] ||
               [language.languageCode isEqualToString:@"is"]) {
        return @"北欧";
    } else if ([language.languageCode isEqualToString:@"sw"] ||
               [language.languageCode isEqualToString:@"am"] ||
               [language.languageCode isEqualToString:@"af"] ||
               [language.languageCode isEqualToString:@"yo"] ||
               [language.languageCode isEqualToString:@"ig"] ||
               [language.languageCode isEqualToString:@"ha"] ||
               [language.languageCode isEqualToString:@"so"] ||
               [language.languageCode isEqualToString:@"zu"] ||
               [language.languageCode isEqualToString:@"xh"]) {
        return @"非洲";
    } else if ([language.languageCode isEqualToString:@"qu"] ||
               [language.languageCode isEqualToString:@"gn"] ||
               [language.languageCode isEqualToString:@"ay"] ||
               [language.languageCode isEqualToString:@"nah"] ||
               [language.languageCode isEqualToString:@"arn"]) {
        return @"美洲原住民";
    } else if ([language.languageCode isEqualToString:@"mi"] ||
               [language.languageCode isEqualToString:@"haw"] ||
               [language.languageCode isEqualToString:@"fj"] ||
               [language.languageCode isEqualToString:@"sm"] ||
               [language.languageCode isEqualToString:@"to"]) {
        return @"大洋洲";
    }
    
    return @"其他";
}

+ (GlobalLanguage *)systemPreferredLanguage {
    NSString *preferredLanguage = [NSLocale preferredLanguages].firstObject;
    
    // 特殊处理中文
    if ([preferredLanguage hasPrefix:@"zh-Hans"]) {
        return [GlobalLanguage languageWithType:GlobalLanguageChineseSimplified];
    } else if ([preferredLanguage hasPrefix:@"zh-Hant"] || 
               [preferredLanguage hasPrefix:@"zh-HK"] || 
               [preferredLanguage hasPrefix:@"zh-TW"]) {
        return [GlobalLanguage languageWithType:GlobalLanguageChineseTraditional];
    }
    
    // 匹配其他语言
    for (GlobalLanguage *language in [self allSupportedLanguages]) {
        if ([preferredLanguage hasPrefix:language.languageType]) {
            return language;
        }
        
        // 基础语言代码匹配
        if ([preferredLanguage hasPrefix:language.languageCode]) {
            return language;
        }
    }
    
    // 默认返回英语
    return [GlobalLanguage languageWithType:GlobalLanguageEnglish];
}

@end
