//
//  ReplayViewController.h
//  WokanZX
//
//  Created by Lucccc on 16/10/10.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PLPlayerKit/PLPlayerKit.h>

@interface ReplayViewController : UIViewController<PLPlayerDelegate>

@property (nonatomic, strong) PLPlayer  *player;

-(void)initwithRtmp:(NSString *)rtmp;

@end
