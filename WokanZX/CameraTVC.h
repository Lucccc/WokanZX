//
//  CameraTVC.h
//  WokanZX
//
//  Created by Lucccc on 16/9/23.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol btnClickedDelegate <NSObject>
//  cell中的button的点击事件方法，在协议中定义，在viewController中
-(void)liveBtnClicked:(NSInteger)section row:(NSInteger)row;
-(void)replayBtnClicked:(NSInteger)section row:(NSInteger)row;
-(void)setBtnClicked:(NSInteger)section row:(NSInteger)row;


@end

@class Device;
@interface CameraTVC : UITableViewCell
//  声明一个delegate的变量，用来引用btnClickedDelegate中的方法
@property (nonatomic,weak) id<btnClickedDelegate>  btnDelegate;
@property(nonatomic,strong)UIView *btnView;
@property(nonatomic,strong)Device *device;

-(instancetype)initWithIntNum:(NSInteger)section row:(NSInteger)row;
@end
