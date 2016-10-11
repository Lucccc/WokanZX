//
//  LiveViewController.m
//  WokanZX
//
//  Created by Lucccc on 16/9/23.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "LiveViewController.h"
#import "fullScreenVC.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudIM.h>

@interface LiveViewController ()<AVIMClientDelegate,AVIMSignatureDataSource,AVSessionDelegate,AVSignatureDelegate>
@property(nonatomic ,copy)NSString *rtmp;
@property (nonatomic, strong) AVIMClient *client;
@property (nonatomic,strong )NSDictionary *dict;
@property (nonatomic,copy)NSString *openWitch;
@property (nonatomic,strong)AVIMSignature *sig;
@property (nonatomic, weak) NSTimer *holdplaytimer;

@end

@implementation LiveViewController



-(void)initwithRtmp:(NSString *)rtmp{
    
    self.rtmp = rtmp;
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    //直播playview
    PLPlayerOption *option = [PLPlayerOption defaultOption];
    [option setOptionValue:@15 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
    //rtmp://live.hkstv.hk.lxdns.com/live/hks
    //NSURL *url = [NSURL URLWithString:@"rtmp://live.hkstv.hk.lxdns.com/live/hks"];
    //NSURL *url = [NSURL URLWithString:@"rtmp://pili-publish.reiniot.shangjinxin.net/reiniot/test00000000001"];
//    NSString *rtmp = [USERDEFAULT objectForKey:@"ORIGIN"];
    NSURL *url = [NSURL URLWithString:self.rtmp];
    self.player = [PLPlayer playerWithURL:url option:option];
    self.player.delegate = self;
    
    //背景view
    WS();
    UIView *playView = [[UIView alloc]init];
    playView.tag = 888;
    
    
    playView.backgroundColor = BColor;
    [self.view addSubview:playView];
    
    [playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.edges.mas_offset(UIEdgeInsetsMake(80, 10, 350, 10));
    }];
    
    [playView addSubview:self.player.playerView];
    
    [self.player.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(playView);
        make.edges.mas_offset(UIEdgeInsetsMake(3, 3, 3, 3));
    }];
    
    //播放
    [self.player play];
    [self holdplay];
    
  
    
    
    
    

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
    
    
    UIButton *button =[[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"onlive_fullscreen"] forState:UIControlStateNormal];
    [btnView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.right.mas_equalTo(btnView.mas_right);
    }];
    [button addTarget:self action:@selector(fullscreen) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *playBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [playBtn setImage:[UIImage imageNamed:@"onlive_smallscreen_play"] forState:UIControlStateNormal];
    [btnView addSubview:playBtn];
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.mas_equalTo(btnView.mas_left);
    }];
    [playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lab25 = [[UILabel alloc]init];
    lab25.text = @"25FPS";
    lab25.textColor = [UIColor whiteColor];
    lab25.font = [UIFont systemFontOfSize:12];
    [btnView addSubview:lab25];
    [lab25 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.mas_equalTo(playBtn.mas_right).offset(10);
    }];
    
    
    
    UIButton *voiceBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [voiceBtn setImage:[UIImage imageNamed:@"onlive_smallscreen_voice"] forState:UIControlStateNormal];
    [btnView addSubview:voiceBtn];
    [voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.mas_equalTo(lab25.mas_right).offset(10);
    }];
    [voiceBtn addTarget:self action:@selector(voiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

-(void)player:(PLPlayer *)player statusDidChange:(PLPlayerStatus)state{
    if(PLPlayerStatusPlaying){
        if (_holdplaytimer) {
            [_holdplaytimer invalidate];
            _holdplaytimer = nil;
        }
        _holdplaytimer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(holdplay) userInfo:nil repeats:YES];
    }
    
}

-(void)holdplay{
    NSDictionary *dic = @{@"type":@"1"};
    [self Httplogin:dic];
}

-(void)fullscreen{
    fullScreenVC *vc = [[fullScreenVC alloc]init];
    [vc initwithRtmp:self.rtmp];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)playBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        [self.player pause];
        [btn setImage:[UIImage imageNamed:@"onlive_smallscreen_pause"] forState:UIControlStateNormal];
        
    }else{
        [self.player play];
        [btn setImage:[UIImage imageNamed:@"onlive_smallscreen_play"] forState:UIControlStateNormal];
        
    }
    
    
}


-(void)voiceBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.player setVolume:0];
        [btn setImage:[UIImage imageNamed:@"onlive_smallscreen_novoice"] forState:UIControlStateNormal];
    }else{
        [self.player setVolume:1];
        [btn setImage:[UIImage imageNamed:@"onlive_smallscreen_voice"] forState:UIControlStateNormal];
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
                
                
            }
            
            
        }];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败%@",error);
        
    }];
    
    
    //NSLog(@"%@",self.sig);
    
    
    
}

-(AVIMSignature *)signatureWithClientId:(NSString *)clientId conversationId:(NSString *)conversationId action:(NSString *)action actionOnClientIds:(NSArray *)clientIds{
    
    return self.sig;
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"直播";
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:BColor,NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    self.navigationController.navigationBarHidden = NO;
     [self.player play];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.player stop];
    if (_holdplaytimer) {
        [_holdplaytimer invalidate];
        _holdplaytimer = nil;
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
