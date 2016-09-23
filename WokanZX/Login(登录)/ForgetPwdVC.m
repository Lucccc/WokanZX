//
//  ForgetPwdVC.m
//  WokanZX
//
//  Created by Lucccc on 16/9/19.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "ForgetPwdVC.h"
#import "GLtextField.h"
#import "ForgetPwdVC2.h"


@interface ForgetPwdVC ()
@property (weak, nonatomic) IBOutlet GLtextField *phoneTextField;

@end

@implementation ForgetPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = FaColor;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.title = @"忘记密码";
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:BColor,NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}
- (IBAction)getCode:(id)sender {
    //获取验证码
    
    //验证手机号
    if ([_phoneTextField.text isEqualToString:@""]||_phoneTextField.text == nil) {
        [FormValidator showAlertWithStr:@"请输入手机号"];
        
    }else{
        AFHTTPSessionManager * manager =[AFHTTPSessionManager manager];
        NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:_phoneTextField.text,@"userPhoneNumber", nil];
        [manager POST:validate parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic =(NSDictionary *)responseObject;
            NSLog(@"%@",dic);
            // [self readSecond];
            //self.registStr = [dic objectForKey:@"yanzheng"];
            // NSLog(@"发送成功%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // NSLog(@"失败%@",error);
        }];
        
        
    }
    
    ForgetPwdVC2 *forgetVC=[[ForgetPwdVC2 alloc]init];
    // [self presentViewController:regist animated:YES completion:nil];
    UIBarButtonItem *bbt = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = bbt;
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:forgetVC animated:YES];
    
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
