//
//  LoginVC.m
//  WokanZX
//
//  Created by Lucccc on 16/9/19.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "LoginVC.h"
#import "HomeViewController.h"
#import "RegisterVC.h"
#import "ForgetPwdVC.h"
#import "LeftMenuViewController.h"

@interface LoginVC ()<RESideMenuDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@end

@implementation LoginVC


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"登录";
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:BColor,NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)loginBtnClick:(id)sender {
    //登录
    /**登录成功要完成的任务*/
    
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
    
    //    NSString *userName =[FormValidator checkMobile:_phoneTextField.text];
    //    NSString *passWord=[FormValidator checkPassword:_passwordText.text];
    //    if ([_phoneTextField.text isEqualToString:@""]||_phoneTextField.text == nil||[_passwordText.text isEqualToString:@""]||_passwordText.text == nil) {
    //        [FormValidator showAlertWithStr:@"用户名或密码不能为空"];
    //        return;
    //    }else{
    //        if (userName) {
    //            [FormValidator showAlertWithStr:userName];
    //            return;
    //        }
    //        if (passWord) {
    //            [FormValidator showAlertWithStr:passWord];
    //            return;
    //        }
    //    }
        [self loginAccountInter];

    
    
}

//登陆接口
-(void)loginAccountInter
{
    [self.view endEditing:YES];
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
//    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:self.phoneTextField.text,@"number",self.pwdTextField.text,@"password",nil];
    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:@"test00000000001",@"imei",nil];
    [manager POST:loginAccount parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
//        if ([[dic  objectForKey:@"id"] isEqualToString:@"false"]) {
//            [FormValidator showAlertWithStr:@"用户名或者密码错误"];
//        }else{
//            //用户名密码输入正确后，登录后需要跳转的页面
//        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
        [FormValidator showAlertWithStr:failTipe];
    }];
    
    
}

//点击空白结束输入
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.phoneTextField endEditing:YES];
    [self.pwdTextField endEditing:YES];
    
}

- (IBAction)registerBtnClick:(id)sender {
    //注册
    RegisterVC *regist=[[RegisterVC alloc]init];
   // [self presentViewController:regist animated:YES completion:nil];
    UIBarButtonItem *bbt = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = bbt;
    self.navigationController.navigationBar.hidden = NO;
    
    [self.navigationController pushViewController:regist animated:YES];
    
}

- (IBAction)forgetPwdBtnClick:(id)sender {
    //忘记密码
    
    ForgetPwdVC *forgetVC=[[ForgetPwdVC alloc]init];
    //[self presentViewController:regist animated:YES completion:nil];
    
    //设置返回barbutton
    UIBarButtonItem *bbt = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = bbt;
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:forgetVC animated:YES];
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
