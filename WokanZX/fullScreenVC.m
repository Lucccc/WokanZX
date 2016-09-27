//
//  fullScreenVC.m
//  WokanZX
//
//  Created by Lucccc on 16/9/23.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "fullScreenVC.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudIM.h>



@interface fullScreenVC ()<AVIMClientDelegate,AVIMSignatureDataSource,AVSessionDelegate,AVSignatureDelegate>

@property (nonatomic, strong) AVIMClient *client;
@property (nonatomic,strong )NSDictionary *dict;

@end

@implementation fullScreenVC

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
    
    //语音按钮
    UIButton *talkBtn =[[UIButton alloc]init];
    [talkBtn setImage:[UIImage imageNamed:@"onlive_fullscree_talkback"] forState:UIControlStateNormal];
    [btnView addSubview:talkBtn];
    [talkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.right.mas_equalTo(cutScreenBtn.mas_left).offset(-10);
    }];
    [talkBtn addTarget:self action:@selector(talkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    [voiceBtn setImage:[UIImage imageNamed:@"onlive_fullscree_novoice"] forState:UIControlStateNormal];
    [btnView addSubview:voiceBtn];
    [voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.mas_equalTo(lab25.mas_right).offset(10);
    }];
    [voiceBtn addTarget:self action:@selector(voiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //箭头放大view
    UIView *arrView = [[UIView alloc]init];
    arrView.backgroundColor = [UIColor clearColor];
    [self.player.playerView addSubview:arrView];
    [arrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.player.playerView.frame.size.width, self.player.playerView.frame.size.height-btnView.frame.size.height));
        make.bottom.equalTo(btnView.mas_top);
        make.left.equalTo(btnView.mas_left);
        make.right.equalTo(btnView.mas_right);
        make.top.equalTo(self.player.playerView.mas_top);
    }];
    
    //上箭头
    UIButton *toparr =[UIButton buttonWithType:UIButtonTypeCustom];
    [toparr setImage:[UIImage imageNamed:@"onlive_fullscree_up-arry"] forState:UIControlStateNormal];
    [arrView addSubview:toparr];
    [toparr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(arrView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.top.mas_equalTo(arrView.mas_top);
    }];
    [toparr addTarget:self action:@selector(topArrBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //底部箭头
    UIButton *botarr =[UIButton buttonWithType:UIButtonTypeCustom];
    [botarr setImage:[UIImage imageNamed:@"onlive_fullscree_down-arry"] forState:UIControlStateNormal];
    [arrView addSubview:botarr];
    [botarr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(arrView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.bottom.mas_equalTo(arrView.mas_bottom);
    }];
    [botarr addTarget:self action:@selector(botArrBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //左边箭头
    UIButton *leftarr =[UIButton buttonWithType:UIButtonTypeCustom];
    [leftarr setImage:[UIImage imageNamed:@"onlive_fullscree_left-arry"] forState:UIControlStateNormal];
    [arrView addSubview:leftarr];
    [leftarr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(arrView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.mas_equalTo(arrView.mas_left);
    }];
    [leftarr addTarget:self action:@selector(leftArrBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //右边按钮
    UIButton *rightarr =[UIButton buttonWithType:UIButtonTypeCustom];
    [rightarr setImage:[UIImage imageNamed:@"onlive_fullscree_right-arry"] forState:UIControlStateNormal];
    [arrView addSubview:rightarr];
    [rightarr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(arrView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.right.mas_equalTo(arrView.mas_right);
    }];
    [rightarr addTarget:self action:@selector(rightArrBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //缩小按钮
    UIButton *smallBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [smallBtn setImage:[UIImage imageNamed:@"onlive_fullscreen_smaller"] forState:UIControlStateNormal];
    [arrView addSubview:smallBtn];
    [smallBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(toparr);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.right.mas_equalTo(arrView.mas_right);
    }];
    [smallBtn addTarget:self action:@selector(smallBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //放大按钮
    UIButton *bigBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [bigBtn setImage:[UIImage imageNamed:@"onlive_fullscree_bigger"] forState:UIControlStateNormal];
    [arrView addSubview:bigBtn];
    [bigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(toparr);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.right.mas_equalTo(smallBtn.mas_left).offset(-10);
    }];
    [bigBtn addTarget:self action:@selector(bigBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //返回按钮
    UIButton *backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    [arrView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(toparr);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.mas_equalTo(arrView.mas_left);
    }];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
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
        [btn setImage:[UIImage imageNamed:@"onlive_fullscree_voice"] forState:UIControlStateNormal];
    }else{
        [self.player setVolume:1];
        [btn setImage:[UIImage imageNamed:@"onlive_fullscree_novoice"] forState:UIControlStateNormal];
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

- (id)conversationSignWithSelfId:(NSString *)clientId conversationId:(NSString *)conversationId targetIds:(NSArray *)targetIds action:(NSString *)action {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:clientId forKey:@"self_id"];
    if (conversationId) {
        [dict setObject:conversationId forKey:@"convid"];
    }
    if (targetIds) {
        [dict setObject:targetIds forKey:@"targetIds"];
    }
    if (action) {
        [dict setObject:action forKey:@"action"];
    }
    //这里是从云代码获取签名，也可以从你的服务器获取
    AFHTTPSessionManager * manager =[AFHTTPSessionManager manager];
    NSString *aaa = @"http://reiniot.shangjinxin.net/api/user/sign-im-login?persistence_code=mZ8hMrVwAyqUOH0MfaA95Rw7qgeZuLVf";
    [manager POST:aaa parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dict =(NSDictionary *)responseObject;
        NSLog(@"%@",self.dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // NSLog(@"失败%@",error);
        
    }];
    
    return self.dict;
}

- (AVIMSignature *)getAVSignatureWithParams:(NSDictionary *)fields peerIds:(NSArray *)peerIds {
    AVIMSignature *avSignature = [[AVIMSignature alloc] init];
    NSNumber *timestampNum = [fields objectForKey:@"timestamp"];
    long timestamp = [timestampNum longValue];
    NSString *nonce = [fields objectForKey:@"nonce"];
    NSString *signature = [fields objectForKey:@"signature"];
    
    [avSignature setTimestamp:timestamp];
    [avSignature setNonce:nonce];
    [avSignature setSignature:signature];
    return avSignature;
}

-(AVIMSignature *)signatureWithClientId:(NSString *)clientId conversationId:(NSString *)conversationId action:(NSString *)action actionOnClientIds:(NSArray *)clientIds{
    
    
    do {
        if ([action isEqualToString:@"open"] || [action isEqualToString:@"start"]) {
            action = nil;
            break;
        }
        if ([action isEqualToString:@"remove"]) {
            action = @"kick";
            break;
        }
        if ([action isEqualToString:@"add"]) {
            action = @"invite";
            break;
        }
    } while (0);
    NSDictionary *dict = [self conversationSignWithSelfId:clientId conversationId:conversationId targetIds:clientIds action:action];
    if (self.dict != nil) {
        return [self getAVSignatureWithParams:dict peerIds:clientIds];
    } else {
        return nil;
    }
    
}


-(void)talkBtnClick{
    NSLog(@"talk");
    // Tom 创建了一个 client，用自己的名字作为 clientId
    self.client = [[AVIMClient alloc] initWithClientId:@"user_4"];
    self.client.delegate = self;
    self.client.signatureDataSource = self;
    
    // Tom 打开 client
    [self.client openWithCallback:^(BOOL succeeded, NSError *error) {
        if (error) {
            // 出错了，可能是网络问题无法连接 LeanCloud 云端，请检查网络之后重试。
            // 此时聊天服务不可用。
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"聊天不可用！" message:[error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [view show];
        } else {
            // 成功登录，可以开始进行聊天了。
            NSLog(@"登录成功");
        }
    }];
    [self.client createConversationWithName:@"你妹啊" clientIds:@[@"user_4",@"aaa"] callback:^(AVIMConversation *conversation, NSError *error) {
        [conversation sendMessage:[AVIMTextMessage messageWithText:@"耗子，起床！" attributes:nil] callback:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"发送成功！");
            }
        }];
    }];
    
}

-(void)topArrBtnClick{
    NSLog(@"toparr");
}

-(void)botArrBtnClick{
    NSLog(@"botarr");
}

-(void)leftArrBtnClick{
    NSLog(@"leftarr");
}

-(void)rightArrBtnClick{
    NSLog(@"rightarr");
}

-(void)smallBtnClick{
    NSLog(@"small");
}

-(void)bigBtnClick{
    NSLog(@"big");
}

-(void)backBtnClick{
    [self cancelfullscreen];
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
