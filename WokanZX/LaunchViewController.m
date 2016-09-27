//
//  LaunchViewController.m
//  WokanZX
//
//  Created by Lucccc on 16/9/12.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "LaunchViewController.h"
#import "ZLScrolling.h"
#import "HomeViewController.h"
#import "LeftMenuViewController.h"




@interface LaunchViewController ()<ZLScrollingDelegate,RESideMenuDelegate>

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    /**
     *  net 方式获取图片
     */
//    NSArray *url = @[@"http://e.hiphotos.baidu.com/lvpics/h=800/sign=61e9995c972397ddc97995046983b216/35a85edf8db1cb134d859ca8db54564e93584b98.jpg", @"http://e.hiphotos.baidu.com/lvpics/h=800/sign=1d1cc1876a81800a71e5840e813533d6/5366d0160924ab185b6fd93f33fae6cd7b890bb8.jpg", @"http://f.hiphotos.baidu.com/lvpics/h=800/sign=8430a8305cee3d6d3dc68acb73176d41/9213b07eca806538d9da1f8492dda144ad348271.jpg", @"http://d.hiphotos.baidu.com/lvpics/w=1000/sign=81bf893e12dfa9ecfd2e521752e0f603/242dd42a2834349b705785a7caea15ce36d3bebb.jpg", @"http://f.hiphotos.baidu.com/lvpics/w=1000/sign=4d69c022ea24b899de3c7d385e361c95/f31fbe096b63f6240e31d3218444ebf81a4ca3a0.jpg"];
//    NSMutableArray *urlarr = [NSMutableArray array];
//    for (NSString *str in url) {
//        NSURL *imurl = [NSURL URLWithString:str];
//        [urlarr addObject:imurl];
//    }
//    UIImage *placeholder = [UIImage imageNamed:@"timeline_image_loading.png"];
    //    ZLScrolling *zl = [[ZLScrolling alloc] initWithCurrentController:self frame:CGRectMake(0, 0, 375, 200) photos:urlarr placeholderImage:placeholder];
    //    zl.timeInterval = 1;
    //    zl.pageControl.pageIndicatorTintColor = [UIColor redColor];
    //    zl.delegate= self;
    
    
    
    /**
     *  本地方式获取图片
     */
    UIImageView *imageView = [UIImageView addImgWithFrame:CGRectMake(SCREEN_WIDTH/2 -80, SCREEN_HEIGHT/4, 157, 118) AndImage:@"login_pic"];
    // UIButton *regBtn =[UIButton addBtnImage:@"注册" AndFrame:CGRectMake(50*Width,SCREEN_HEIGHT-20-200*Height, 300*Width, 200*Height) WithTarget:self action:@selector(registAccountButton)];
    
    

    
    
    NSArray *array = @[@"home_1",@"home_2",@"home_3",@"home_4"];

    ZLScrolling *zzzz = [[ZLScrolling alloc] initWithCurrentController:self frame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) photos:array placeholderImage:nil];
    zzzz.timeInterval = 5;
    zzzz.delegate = self;
    
    self.navigationController.navigationBarHidden = YES;
   
    UIButton *regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [regBtn setBackgroundImage:[UIImage imageNamed: @"注册"] forState:UIControlStateNormal];
    [regBtn addTarget:self action:@selector(registAccountButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regBtn];
    [regBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 45));
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.left.equalTo(self.view.mas_left).offset(25);
    }];
    
    // UIButton *loginBtn =[UIButton addBtnImage:@"登录" AndFrame:CGRectMake(80*Width-80+SCREEN_WIDTH/2,SCREEN_HEIGHT-20-200*Height, 300*Width, 200*Height) WithTarget:self action:@selector(loginAccountButton)];
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundImage:[UIImage imageNamed: @"登录"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginAccountButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(160, 45));
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.right.equalTo(self.view.mas_right).offset(-25);
    }];
    
    //[self.view addSubview:loginBtn];
    [self.view addSubview:imageView];
}

-(void)registAccountButton{
    NSLog(@"zhuce");
    RegisterVC *VC = [[RegisterVC alloc]init];
    UIBarButtonItem *bbt = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = bbt;
    //VC.view.backgroundColor = [UIColor redColor];
    UINavigationController *regNav = [[UINavigationController alloc]initWithRootViewController:VC];
    regNav.title = @"注册";
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)loginAccountButton{
    NSLog(@"denglu");
    [SVProgressHUD showInfoWithStatus:@"登录中"];
    if([USERDEFAULT objectForKey:@"persistence_code"] != nil){
        
        NSString *pcode = [USERDEFAULT objectForKey:@"persistence_code"];
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
        NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:pcode,@"code",nil];
        // NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:@"test00000000001",@"imei",nil];
        // NSLog(@"%@",dic);
        [manager POST:@"http://reiniot.shangjinxin.net/api/user/persist" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"%@",responseObject);
            NSDictionary *responseD = (NSDictionary *)responseObject;
            //用户名密码输入正确后，登录后需要跳转的页面
            /**登录成功要完成的任务*/
            
            [USERDEFAULT setObject:[responseD objectForKey:@"persistence_code"] forKey:@"persistence_code"];
            
            HomeViewController *home = [[HomeViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:home];
            LeftMenuViewController *leftMenuViewController = [[LeftMenuViewController alloc] init];
            
            
            RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController leftMenuViewController:leftMenuViewController rightMenuViewController:nil];
            sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
            sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
            
            sideMenuViewController.delegate = self;
            //sideMenuViewController.tempViewController = rightMenuViewController;
            //sideMenuViewController.tempViewController = nil;
            [self.navigationController pushViewController:sideMenuViewController animated:YES];
            /**登录成功要完成的任务 */
            
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [SVProgressHUD showErrorWithStatus:failTipe];
            
        }];
        
        
    }else{
        LoginVC *aaa = [[LoginVC alloc]init];
        UIBarButtonItem *bbt = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.backBarButtonItem = bbt;
        UINavigationController *loginNav = [[UINavigationController alloc]initWithRootViewController:aaa];
        loginNav.title = @"登录";
        self.navigationController.navigationBar.hidden = NO;
        [self.navigationController pushViewController:aaa animated:YES];
    }
    
    
    
}
- (void)zlScrolling:(ZLScrolling *)zlScrolling clickAtIndex:(NSInteger)index
{
    NSLog(@"点击到------%ld",index);
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
