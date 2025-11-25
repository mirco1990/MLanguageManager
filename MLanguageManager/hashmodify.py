#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import json
from datetime import datetime

# 简化的语言列表
LANGUAGES = {
    # 亚洲语言
    "zh-Hans": "简体中文",
    "zh-Hant": "繁體中文",
    "ja": "日语",
    "ko": "韩语",
    "hi": "印地语",
    "ar": "阿拉伯语",
    "he": "希伯来语",
    "th": "泰语",
    "vi": "越南语",
    "id": "印尼语",
    "ms": "马来语",
    "fil": "菲律宾语",
    "my": "缅甸语",
    "km": "高棉语",
    "lo": "老挝语",
    "mn": "蒙古语",
    "ne": "尼泊尔语",
    "si": "僧伽罗语",
    "ta": "泰米尔语",
    "te": "泰卢固语",
    "ur": "乌尔都语",
    "bn": "孟加拉语",
    "fa": "波斯语",
    "ps": "普什图语",
    "ku": "库尔德语",
    "ug": "维吾尔语",
    "kk": "哈萨克语",
    "uz": "乌兹别克语",
    
    # 欧洲语言
    "en": "英语",
    "es": "西班牙语",
    "fr": "法语",
    "de": "德语",
    "it": "意大利语",
    "pt": "葡萄牙语",
    "ru": "俄语",
    "nl": "荷兰语",
    "pl": "波兰语",
    "uk": "乌克兰语",
    "ro": "罗马尼亚语",
    "el": "希腊语",
    "cs": "捷克语",
    "sv": "瑞典语",
    "no": "挪威语",
    "da": "丹麦语",
    "fi": "芬兰语",
    "hu": "匈牙利语",
    "bg": "保加利亚语",
    "hr": "克罗地亚语",
    "sk": "斯洛伐克语",
    "sl": "斯洛文尼亚语",
    "sr": "塞尔维亚语",
    "be": "白俄罗斯语",
    "lt": "立陶宛语",
    "lv": "拉脱维亚语",
    "et": "爱沙尼亚语",
    "is": "冰岛语",
    "sq": "阿尔巴尼亚语",
    "mk": "马其顿语",
    "mt": "马耳他语",
    "bs": "波斯尼亚语",
    "cnr": "黑山语",
    
    # 非洲语言
    "sw": "斯瓦希里语",
    "am": "阿姆哈拉语",
    "af": "南非荷兰语",
    "yo": "约鲁巴语",
    "ig": "伊博语",
    "ha": "豪萨语",
    "so": "索马里语",
    "zu": "祖鲁语",
    "xh": "科萨语",
    "sn": "绍纳语",
    "om": "奥罗莫语",
    "mg": "马尔加什语",
    "rw": "卢旺达语",
    "rn": "隆迪语",
    "ti": "提格里尼亚语",
    "wo": "沃洛夫语",
    "ff": "富拉语",
    "bm": "班巴拉语",
    
    # 美洲语言
    "pt-BR": "巴西葡萄牙语",
    "es-419": "拉丁美洲西班牙语",
    "fr-CA": "加拿大法语",
    "qu": "克丘亚语",
    "gn": "瓜拉尼语",
    "ay": "艾马拉语",
    "nah": "纳瓦特尔语",
    "arn": "马普切语",
    
    # 大洋洲语言
    "mi": "毛利语",
    "haw": "夏威夷语",
    "fj": "斐济语",
    "sm": "萨摩亚语",
    "to": "汤加语"
}

BASE_TRANSLATIONS = {
    "welcome": "欢迎",
    "hello": "你好，{0}！", 
    "settings": "设置",
    "language": "语言",
    "save": "保存",
    "cancel": "取消",
    "error": "错误",
    "success": "成功"
}

def generate_language_files(output_dir="./language_files"):
    """生成语言文件的主函数"""
    
    # 创建输出目录
    os.makedirs(output_dir, exist_ok=True)
    
    print(f"开始生成语言文件到: {output_dir}")
    
    for lang_code, lang_name in LANGUAGES.items():
        # 生成翻译内容
        translations = {}
        for key, value in BASE_TRANSLATIONS.items():
            translations[key] = f"[{lang_name}] {value}"
        
        # 创建文件内容
        file_content = {
            "_metadata": {
                "language_code": lang_code,
                "language_name": lang_name,
                "generated_date": datetime.now().isoformat()
            },
            "translations": translations
        }
        
        # 写入文件
        filename = f"{lang_code}.json"
        filepath = os.path.join(output_dir, filename)
        
        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump(file_content, f, ensure_ascii=False, indent=2)
        
        print(f"生成: {filename} - {lang_name}")
    
    print(f"完成! 生成了 {len(LANGUAGES)} 个语言文件")

if __name__ == "__main__":
    generate_language_files()
