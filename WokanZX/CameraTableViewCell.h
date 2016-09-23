//
//  CameraTableViewCell.h
//  WokanZX
//
//  Created by Lucccc on 16/9/21.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TermCellDelegate <NSObject>

- (void)pushview;

@end
typedef void(^BlockButton)(NSString *str);
@interface CameraTableViewCell : UITableViewCell

@property (assign, nonatomic) id<TermCellDelegate> delegate;
@property (nonatomic, copy) BlockButton button;

- (void)handlerButtonAction:(BlockButton)block;
@end
