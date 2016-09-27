//
//  RegisterVC.m
//  WokanZX
//
//  Created by Lucccc on 16/9/19.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "RegisterVC.h"
#import "RegisterVC2.h"
#import "GLtextField.h"

@interface RegisterVC ()
@property (weak, nonatomic) IBOutlet GLtextField *phoneTextField;

@end

@implementation RegisterVC

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
    self.title = @"注册";
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

- (IBAction)toRegister2VC:(id)sender {
    
    
    //验证手机号
    if ([_phoneTextField.text isEqualToString:@""]||_phoneTextField.text == nil) {
        [FormValidator showAlertWithStr:@"请输入手机号"];
        
    }else{
        AFHTTPSessionManager * manager =[AFHTTPSessionManager manager];
        NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:_phoneTextField.text,@"mobile", nil];
        [manager POST:validate parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dict =(NSDictionary *)responseObject;
                //NSLog(@"%@",dic);
             // [self readSecond];
            Boolean registStr = (Boolean)[dict objectForKey:@"success"];
            if(registStr){
               // [FormValidator showAlertWithStr:@"发送中"];
                [SVProgressHUD showSuccessWithStatus:@"发送中"];
                RegisterVC2 *regist=[[RegisterVC2 alloc]init];
                // [self presentViewController:regist animated:YES completion:nil];
                UIBarButtonItem *bbt = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
                self.navigationItem.backBarButtonItem = bbt;
                self.navigationController.navigationBar.hidden = NO;
                [self.navigationController pushViewController:regist animated:YES];
 
            }else{
            //[FormValidator showAlertWithStr:@"发送失败"];
                [SVProgressHUD showErrorWithStatus:@"发送失败"];
            }
            // NSLog(@"发送成功%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // NSLog(@"失败%@",error);
            [FormValidator showAlertWithStr:@"发送失败"];
            [SVProgressHUD showErrorWithStatus:@"发送失败"];
        }];
        
        
    }

    
    
    
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
