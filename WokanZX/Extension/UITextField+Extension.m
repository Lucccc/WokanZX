//
//  UITextField+Extension.m
//  登录注册找回密码
//
//  Created by beijingduanluo on 16/1/5.
//  Copyright © 2016年 beijingduanluo. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)
+(UITextField *)addTextFieldWithFrame:(CGRect)frame AndStr:(NSString *)placeholder AndFont:(CGFloat)font AndTextColor:(UIColor *)color
{
    UITextField *textF=[[UITextField alloc]initWithFrame:frame];
    textF.userInteractionEnabled = YES;
    textF.textColor = color;
    textF.font =[UIFont systemFontOfSize:font*Width];
    textF.placeholder=placeholder;
    return textF;
}
@end
