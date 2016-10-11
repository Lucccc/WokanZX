//
//  fullScreenVC.h
//  WokanZX
//
//  Created by Lucccc on 16/9/23.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PLPlayerKit/PLPlayerKit.h>


@interface fullScreenVC : UIViewController<PLPlayerDelegate>

@property (nonatomic,copy)void(^LiveVCBlock)(fullScreenVC *);
@property (nonatomic, strong) PLPlayer  *player;


-(void)initwithRtmp:(NSString *)rtmp;
@end
