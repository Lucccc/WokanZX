//
//  GLWhiteButton.m
//  WokanZX
//
//  Created by Lucccc on 16/9/18.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLWhiteButton.h"

@implementation GLWhiteButton

-(void)setup{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//    self.backgroundColor = BColor;
//    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.layer.borderColor = BColor.CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])) {
        [self setup];
        
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

@end
