//
//  HomeViewController.h
//  WokanZX
//
//  Created by Lucccc on 16/9/11.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import <PLPlayerKit/PLPlayerKit.h>

@interface HomeViewController : UIViewController <PLPlayerDelegate>

@property (nonatomic, strong) PLPlayer  *player;


@end
