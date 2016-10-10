//
//  RepalyfullScreenViewController.m
//  WokanZX
//
//  Created by Lucccc on 16/10/10.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "RepalyfullScreenViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudIM.h>



@interface RepalyfullScreenViewController ()<AVIMClientDelegate,AVIMSignatureDataSource,AVSessionDelegate,AVSignatureDelegate>

@property (nonatomic, strong) AVIMClient *client;
@property (nonatomic,strong )NSDictionary *dict;
@property (nonatomic,copy)NSString *openWitch;
@property (nonatomic,strong)AVIMSignature *sig;


@end

@implementation RepalyfullScreenViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    PLPlayerOption *option = [PLPlayerOption defaultOption];
    [option setOptionValue:@15 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
    
    //rtmp://live.hkstv.hk.lxdns.com/live/hks
    NSURL *url = [NSURL URLWithString:@"rtmp://live.hkstv.hk.lxdns.com/live/hks"];
    
    //NSURL *url = [NSURL URLWithString:@"rtmp://pili-live-rtmp.reiniot.shangjinxin.net/reiniot/test00000000001"];
    self.player = [PLPlayer playerWithURL:url option:option];
    self.player.delegate = self;
    
    WS();
    UIView *playView = [[UIView alloc]init];
    playView.tag = 888;
    
    
    playView.backgroundColor = BColor;
    [self.view addSubview:playView];
    
    [playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [playView addSubview:self.player.playerView];
    
    [self.player.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(playView);
        make.edges.mas_offset(UIEdgeInsetsMake(3, 3, 3, 3));
    }];
    
    [self.player play];
    [self holdplay];
    
    //下部按钮view
    UIView *btnView = [[UIView alloc]init];
    btnView.backgroundColor = [UIColor darkGrayColor];
    btnView.alpha = 0.7;
    [self.player.playerView addSubview:btnView];
    
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(playView);
        make.bottom.equalTo(playView.mas_bottom);
        make.height.mas_equalTo(50);
        make.centerX.mas_equalTo(playView.mas_centerX);
    }];
    
    //缩小屏幕按钮
    UIButton *button =[[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"onlive_fullscree_small_screen"] forState:UIControlStateNormal];
    [btnView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.right.mas_equalTo(btnView.mas_right);
    }];
    [button addTarget:self action:@selector(cancelfullscreen) forControlEvents:UIControlEventTouchUpInside];
    
    
    //截屏按钮
    UIButton *cutScreenBtn =[[UIButton alloc]init];
    [cutScreenBtn setImage:[UIImage imageNamed:@"onlive_fullscree_screenshots"] forState:UIControlStateNormal];
    [btnView addSubview:cutScreenBtn];
    [cutScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.right.mas_equalTo(button.mas_left).offset(-10);
    }];
    [cutScreenBtn addTarget:self action:@selector(cutscreenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    //播放暂停
    UIButton *playBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [playBtn setImage:[UIImage imageNamed:@"onlive_fullscree_play"] forState:UIControlStateNormal];
    [btnView addSubview:playBtn];
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.mas_equalTo(btnView.mas_left);
    }];
    [playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //25fpslabel
    UILabel *lab25 = [[UILabel alloc]init];
    lab25.text = @"25FPS";
    lab25.textColor = [UIColor whiteColor];
    lab25.font = [UIFont systemFontOfSize:14];
    [btnView addSubview:lab25];
    [lab25 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.mas_equalTo(playBtn.mas_right).offset(10);
    }];
    
    
    //静音按钮
    UIButton *voiceBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [voiceBtn setImage:[UIImage imageNamed:@"onlive_fullscree_voice"] forState:UIControlStateNormal];
    [btnView addSubview:voiceBtn];
    [voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.mas_equalTo(lab25.mas_right).offset(10);
    }];
    [voiceBtn addTarget:self action:@selector(voiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)holdplay{
    NSDictionary *dic = @{@"type":@"1"};
    [self Httplogin:dic];
}

-(void)cancelfullscreen{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)playBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        [self.player pause];
        [btn setImage:[UIImage imageNamed:@"onlive_fullscree_pause"] forState:UIControlStateNormal];
        
    }else{
        [self.player play];
        [btn setImage:[UIImage imageNamed:@"onlive_fullscree_play"] forState:UIControlStateNormal];
        
    }
    
    
}


-(void)voiceBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.player setVolume:0];
        [btn setImage:[UIImage imageNamed:@"onlive_fullscree_novoice"] forState:UIControlStateNormal];
    }else{
        [self.player setVolume:1];
        [btn setImage:[UIImage imageNamed:@"onlive_fullscree_voice"] forState:UIControlStateNormal];
    }
    
    
}

//截屏方法
-(void)cutscreenBtnClick{
    
    [self.player getScreenShotWithCompletionHandler:^(UIImage * _Nullable image) {
        UIImage *viewImage = image;
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(viewImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [FormValidator showAlertWithStr:@"截图失败"];
    }else{
        [FormValidator showAlertWithStr:@"已截屏"];
    }
}

-(void)Httplogin:(NSDictionary *)msg{
    
    
    AFHTTPSessionManager * manager1 =[AFHTTPSessionManager manager];
    NSString *aaa1 =@"http://reiniot.shangjinxin.net/api/user/sign-im-login";
    NSDictionary *dic1 = @{@"persistence_code":[USERDEFAULT objectForKey:@"persistence_code"]
                           };
    [manager1 POST:aaa1 parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"aadsfadsfadsfasdf");
        self.dict  = (NSDictionary *)responseObject;
        AVIMSignature *avSignature = [[AVIMSignature alloc] init];
        NSNumber *timestampNum = [_dict objectForKey:@"timestamp"];
        long timestamp = [timestampNum longValue];
        NSString *nonce = [_dict objectForKey:@"nonce"];
        NSString *signature = [_dict objectForKey:@"signature"];
        [avSignature setTimestamp:timestamp];
        [avSignature setNonce:nonce];
        [avSignature setSignature:signature];
        
        self.sig = avSignature;
        
        NSLog(@"talk");
        // Tom 创建了一个 client，用自己的名字作为 clientId
        
        self.client = [[AVIMClient alloc] initWithClientId:[_dict objectForKey:@"client_id"]];
        self.client.delegate = self;
        self.client.signatureDataSource = self;
        
        [self.client openWithCallback:^(BOOL succeeded, NSError *error) {
            if (error) {
                // 出错了，可能是网络问题无法连接 LeanCloud 云端，请检查网络之后重试。
                // 此时聊天服务不可用。
                UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"聊天不可用！" message:[error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [view show];
            } else {
                // 成功登录，可以开始进行聊天了。
                NSLog(@"登录成功");
                [self Httpcreat:msg];
                
                
            }
        }];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败%@",error);
        
    }];
    
    
}

-(void)Httpcreat:(NSDictionary *)msg{
    AFHTTPSessionManager * manager =[AFHTTPSessionManager manager];
    NSString *aaa =@"http://reiniot.shangjinxin.net/api/user/sign-im-conversation";
    NSDictionary *dic = @{@"persistence_code":[USERDEFAULT objectForKey:@"persistence_code"],
                          @"imei":@"test00000000001"};
    [manager POST:aaa parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.dict  = (NSDictionary *)responseObject;
        AVIMSignature *avSignature = [[AVIMSignature alloc] init];
        NSNumber *timestampNum = [_dict objectForKey:@"timestamp"];
        long timestamp = [timestampNum longValue];
        NSString *nonce = [_dict objectForKey:@"nonce"];
        NSString *signature = [_dict objectForKey:@"signature"];
        [avSignature setTimestamp:timestamp];
        [avSignature setNonce:nonce];
        [avSignature setSignature:signature];
        
        self.sig = avSignature;
        
        [self.client createConversationWithName: [_dict objectForKey:@"conversation_name"] clientIds:[_dict objectForKey:@"members"] callback:^(AVIMConversation *conversation, NSError *error) {
            
            NSString *msgjson = [GLTools dictionaryToJson:msg];
            
            if ([[msg objectForKey:@"type"] isEqualToString:@"1"]) {
                
                [conversation sendMessage:[AVIMTextMessage messageWithText:msgjson attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        NSLog(@"发送成功！");
                        
                    }
                }];
                
                
            }else{
                [conversation sendMessage:[AVIMTextMessage messageWithText:msgjson attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        NSLog(@"发送成功！");
                        
                    }
                }];
            }
            
            
        }];
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败%@",error);
        
    }];
    
    
    //NSLog(@"%@",self.sig);
    
    
    
}

-(BOOL)isFileExistAtPath:(NSString*)fileFullPath {
    BOOL isExist = NO;
    isExist = [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath];
    return isExist;
}

-(void)topArrBtnClick{
    //    NSLog(@"toparr");
    //    NSLog(@"%@",[USERDEFAULT objectForKey:@"persistence_code"]);
    //    NSLog(@"%@",self.openWitch);
    //responseObj *obj =[[responseObj alloc]init];
    NSDictionary *dic = @{@"type":@"2",@"data":@"1"};
    
    
    [self Httplogin:dic];
    
    
    
    
    
}

-(AVIMSignature *)signatureWithClientId:(NSString *)clientId conversationId:(NSString *)conversationId action:(NSString *)action actionOnClientIds:(NSArray *)clientIds{
    
    return self.sig;
    
}


-(void)backBtnClick{
    [self cancelfullscreen];
}


#pragma mark - AVIMClientDelegate

// 接收消息的回调函数
-(void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message{
    NSLog(@"xiaoxi---------------------%@", message.text);
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    self.navigationController.navigationBarHidden = YES;
    
    if([[UIDevice currentDevice]respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeLeft;//横屏
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
        
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
    if([[UIDevice currentDevice]respondsToSelector:@selector(setOrientation:)]) {
        
        
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationPortrait;//横屏
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    
    
    
    
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
