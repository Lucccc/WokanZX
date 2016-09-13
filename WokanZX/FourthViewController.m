//
//  FourthViewController.m
//  WokanZX
//
//  Created by Lucccc on 16/9/6.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    self.title = @"关于";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_set_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];

}
- (void)showMenu{
    [self.sideMenuViewController presentLeftMenuViewController];
}
- (IBAction)updateSoft:(id)sender {
    //软件更新
    NSLog(@"update");
    
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
