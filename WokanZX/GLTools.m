//
//  GLTools.m
//  WokanZX
//
//  Created by Lucccc on 16/9/30.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLTools.h"
#import "CommonCrypto/CommonDigest.h"


@implementation GLTools

+(NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    
    unsigned char result[16];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    
    return [NSString stringWithFormat:
            
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],result[1],result[2],result[3],
            result[4],result[5],result[6],result[7],
            result[8],result[9],result[10],result[11],
            result[12],result[13],result[14],result[15]];
}


+(NSString *)timestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    
    return timeString;
    
    
}

+(NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    //NSJSONWritingPrettyPrinted
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}





@end
