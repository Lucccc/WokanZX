//
//  GLButton.m
//  WokanZX
//
//  Created by Lucccc on 16/9/13.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLButton.h"

@implementation GLButton

-(void)setup{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.backgroundColor = BColor;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
