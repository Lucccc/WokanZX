//
//  CameraTableViewCell.m
//  WokanZX
//
//  Created by Lucccc on 16/9/21.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "CameraTableViewCell.h"

@implementation CameraTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    super.userInteractionEnabled = YES;
   
}
- (void)handlerButtonAction:(BlockButton)block
{
    self.button = block;
}

- (IBAction)replayBtn:(id)sender {
    if (self.button) {
        self.button(@"123");
    }
    if (_delegate != nil &&[_delegate respondsToSelector:@selector(pushview)]) {
        [_delegate pushview];
        NSLog(@"zhibobtn");
    }
}


- (IBAction)zbBtnClick:(UIButton *)sender {
    
    if (_delegate != nil &&[_delegate respondsToSelector:@selector(pushview)]) {
        [_delegate pushview];
        NSLog(@"zhibobtn");
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
