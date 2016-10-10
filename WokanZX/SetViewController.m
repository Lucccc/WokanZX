//
//  SetViewController.m
//  WokanZX
//
//  Created by Lucccc on 16/10/1.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()
@property(nonatomic, strong)Device *device;
@end

@implementation SetViewController

-(void)initwithRtmp:(Device *)device{
    
    self.device = device;
    
}

- (IBAction)nobindBtnClick:(id)sender {
    //提交页面
    AFHTTPSessionManager * manager =[AFHTTPSessionManager manager];
    NSString *code = [USERDEFAULT objectForKey:@"persistence_code"];
    NSLog(@"%@",code);
    NSString *imei = self.device.imei;
    NSString *pwd = @"123456";
    //获取当前时间戳
    NSString *timestamp = [GLTools timestamp];
    NSLog(@"%@",timestamp);
    //md5加密
    NSString *encryped_password = [GLTools md5:[pwd stringByAppendingString:timestamp]];
    
    
    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:code,@"persistence_code",imei,@"imei",encryped_password,@"encryped_password",@"unbind",@"action",timestamp,@"timestamp",nil];

    [manager POST:@"http://reiniot.shangjinxin.net/api/user/bind-device" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *res = (NSDictionary *)responseObject;
        if([res objectForKey:@"device"] != nil){
            [SVProgressHUD showSuccessWithStatus:@"解除绑定成功"];
            [self dissmis];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [SVProgressHUD showSuccessWithStatus:@"解除绑定失败"];
            [self dissmis];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // NSLog(@"失败%@",error);
        
        [SVProgressHUD showErrorWithStatus:failTipe];
    }];
    
    
}
-(void)dissmis{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = FaColor;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:BColor,NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];

    // Do any additional setup after loading the view from its nib.
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
