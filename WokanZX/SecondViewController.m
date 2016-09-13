//
//  SecondViewController.m
//  WokanZX
//
//  Created by Lucccc on 16/9/6.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "SecondViewController.h"



@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *Segment;


@end

@implementation SecondViewController

- (void)viewDidLoad {
    NSLog(@"sdafdsafsa");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"切换清晰度";
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:BColor,NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];

   
    //self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"playback_click_left_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    
    //设置segment属性
    NSUserDefaults *mySettingDatar = [NSUserDefaults standardUserDefaults];
    
    self.Segment.selectedSegmentIndex = [mySettingDatar integerForKey:@"segmentIndex"];
    self.Segment.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.Segment.layer.borderWidth = 1;
    //self.Segment.tintColor = [UIColor whiteColor];
    //self.Segment.backgroundColor = [UIColor clearColor];
    self.Segment.layer.cornerRadius = 10.0f;
    self.Segment.layer.masksToBounds = YES;
    
    [self.Segment addTarget:self action:@selector(segementDidChange:) forControlEvents:UIControlEventValueChanged];
}

//seg事件
-(void)segementDidChange:(UISegmentedControl *)seg{
    NSInteger index = seg.selectedSegmentIndex;
    NSUserDefaults *mySettingData = [NSUserDefaults standardUserDefaults];

    switch (index) {
        case 0:
            NSLog(@"1");
            [mySettingData setInteger:index forKey:@"segmentIndex"];
            [mySettingData synchronize];
            
            break;
        case 1:
            NSLog(@"2");
            [mySettingData setInteger:index forKey:@"segmentIndex"];
            [mySettingData synchronize];
            
        default:
            break;
    }
    
    
}

- (void)showMenu{
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
