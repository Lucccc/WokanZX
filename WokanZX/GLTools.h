//
//  GLTools.h
//  WokanZX
//
//  Created by Lucccc on 16/9/30.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLTools : NSObject

//md5加密
+(NSString *)md5:(NSString *)str;

//获取当前时间戳

+(NSString *)timestamp;

//字典转json
+(NSString*)dictionaryToJson:(NSDictionary *)dic;


//json转字典
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
