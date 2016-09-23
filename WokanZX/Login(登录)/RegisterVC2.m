//
//  RegisterVC2.m
//  WokanZX
//
//  Created by Lucccc on 16/9/20.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "RegisterVC2.h"
#import "GLButton.h"
#import "GLtextField.h"

@interface RegisterVC2 ()
{
    int timeCount;
    NSTimer*timer;
}
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet GLButton *codeButton;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet GLtextField *codeTextField;
@property (weak, nonatomic) IBOutlet GLtextField *pwdTextField;

@end

@implementation RegisterVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = FaColor;
    [self readSecond];
    // Do any additional setup after loading the view from its nib.
    
    
    //验证提交之后的跑秒提示防止用户的重复提交数据有效时间60秒
    timeCount = 60;
    self.tipLabel.textAlignment=NSTextAlignmentCenter;
    self.tipLabel.text=[[NSString alloc]initWithFormat:@"%ds",timeCount];
    self.tipLabel.textColor=[UIColor whiteColor];
    self.tipLabel.layer.cornerRadius=3;
    self.tipLabel.clipsToBounds=YES;
    self.tipLabel.backgroundColor=[UIColor lightGrayColor];
    self.tipLabel.font=[UIFont systemFontOfSize:14];
    
    
    
}

#pragma mark-->读秒开始
-(void)readSecond{
    self.codeButton.hidden=YES;
    
    self.tipLabel.hidden=NO;
    
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dealTimer) userInfo:nil repeats:YES];
    timer.fireDate=[NSDate distantPast];
}

#pragma mark-->跑秒操作
-(void)dealTimer{
    
    self.tipLabel.text=[[NSString alloc]initWithFormat:@"剩余%ds",timeCount];
    timeCount=timeCount - 1;
    if(timeCount== 0){
        timer.fireDate=[NSDate distantFuture];
        timeCount= 60;
        self.tipLabel.hidden=YES;
        self.codeButton.hidden=NO;
    }
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.pwdTextField endEditing:YES];
    [self.codeTextField endEditing:YES];
    
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


- (IBAction)recode:(id)sender {
    //重获验证码
    [self readSecond];
    
    
    
}

- (IBAction)finalRegist:(id)sender {
    //完成注册
    
    
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
