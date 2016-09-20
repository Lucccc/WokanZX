//
//  GLtextField.m
//  WokanZX
//
//  Created by Lucccc on 16/9/18.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLtextField.h"



@implementation GLtextField 




-(void)setup{
    self.delegate = self;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])) {
        [self setup];
        
    }
    return self;
}

-(void)awakeFromNib{
    [self setup];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
   
    //当用户按下ruturn，把焦点从textField移开那么键盘就会消失了
    [textField resignFirstResponder];
    
    return YES;
}
@end
