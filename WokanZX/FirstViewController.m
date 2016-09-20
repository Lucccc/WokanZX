//
//  FirstViewController.m
//  WokanZX
//
//  Created by Lucccc on 16/9/6.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "FirstViewController.h"
#import "LaunchViewController.h"



@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UILabel *Labeltext;
@property (weak, nonatomic) IBOutlet UIButton *ChangeNumBtn;
@property (weak, nonatomic) IBOutlet UIButton *ChangePwdBtn;
@property (weak, nonatomic) IBOutlet UIButton *SignoutBtn;
@property (weak, nonatomic) IBOutlet UITextField *NumtextFild;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    
    self.title = @"账号设置";
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:BColor,NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    
   
    self.view.backgroundColor = FaColor;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.image = [UIImage imageNamed:@"Balloon"];
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ChangePwd:(id)sender {
    NSLog(@"change pwd");
    
}
- (IBAction)ChangeNum:(id)sender {
    NSLog(@"change num");
    
}
- (IBAction)SignOut:(id)sender {
    LaunchViewController *vc = [[LaunchViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)showMenu
{
    [self.sideMenuViewController presentLeftMenuViewController];
    

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
