//
//  UITextField+Extension.h
//  登录注册找回密码
//
//  Created by beijingduanluo on 16/1/5.
//  Copyright © 2016年 beijingduanluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)
+(UITextField *)addTextFieldWithFrame:(CGRect)frame AndStr:(NSString *)placeholder AndFont:(CGFloat)font AndTextColor:(UIColor *)color;
@end
