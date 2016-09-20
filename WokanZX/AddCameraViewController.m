//
//  AddCameraViewController.m
//  WokanZX
//
//  Created by Lucccc on 16/9/18.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "AddCameraViewController.h"
#import "LXDScanView.h"
#import "LXDScanCodeController.h"
#import <AVFoundation/AVFoundation.h>

@interface AddCameraViewController ()<LXDScanCodeControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *NumTextField;
@property (weak, nonatomic) IBOutlet UITextField *PwdTextField;
@property (nonatomic, strong) LXDScanView * scanView;

@end

@implementation AddCameraViewController


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear: animated];
    [self.scanView stop];
}

- (void)dealloc
{
    [self.scanView stop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加摄像头";
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:BColor,NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ScanBtn:(id)sender {
    //扫描二维码
    [self.scanView removeFromSuperview];
    LXDScanCodeController * scanCodeController = [LXDScanCodeController scanCodeController];
    scanCodeController.scanDelegate = self;
    [self.navigationController pushViewController: scanCodeController animated: YES];
    
}
- (IBAction)cancelView:(id)sender {
    //取消
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submit:(id)sender {
    //提交页面
    
}


#pragma mark - getter
/**
 *  懒加载扫描view
 */
- (LXDScanView *)scanView
{
    if (!_scanView) {
        _scanView = [LXDScanView scanViewShowInController: self];
    }
    return _scanView;
}


//#pragma mark - LXDScanViewDelegate
///**
// *  返回扫描结果
// */
//- (void)scanView:(LXDScanView *)scanView codeInfo:(NSString *)codeInfo
//{
//    NSURL * url = [NSURL URLWithString: codeInfo];
//    if ([[UIApplication sharedApplication] canOpenURL: url]) {
//        [[UIApplication sharedApplication] openURL: url];
//    } else {
//        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"警告" message: [NSString stringWithFormat: @"%@:%@", @"无法解析的二维码", codeInfo] delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
//        [alertView show];
//    }
//}
//

#pragma mark - LXDScanCodeControllerDelegate
- (void)scanCodeController:(LXDScanCodeController *)scanCodeController codeInfo:(NSString *)codeInfo
{
    
    self.NumTextField.text = codeInfo;

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
