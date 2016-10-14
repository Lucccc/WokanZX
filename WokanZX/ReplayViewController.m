//
//  ReplayViewController.m
//  WokanZX
//
//  Created by Lucccc on 16/10/10.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "ReplayViewController.h"
#import "RepalyfullScreenViewController.h"
#import "ZVScrollSlider.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudIM.h>




@interface ReplayViewController ()<ZVScrollSliderDelegate,AVIMClientDelegate,AVIMSignatureDataSource,AVSessionDelegate,AVSignatureDelegate>
@property(nonatomic ,copy)NSString *rtmp;
@property(nonatomic, copy)NSString *timeText;
@property(nonatomic, assign)int time;
@property(nonatomic, assign)NSDate *date;
@property (nonatomic, strong) AVIMClient *client;
@property (nonatomic,strong )NSDictionary *dict;
@property (nonatomic,copy)NSString *openWitch;
@property (nonatomic,strong)AVIMSignature *sig;
@property(nonatomic, strong)NSDate *minDate;
@property(nonatomic, strong)NSDate *maxDate;
@property(nonatomic, strong)UIDatePicker *datepicker;

@end

@implementation ReplayViewController

-(void)initwithRtmp:(NSString *)rtmp{
    
    self.rtmp = rtmp;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //发送观看消息
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    //直播playview
    PLPlayerOption *option = [PLPlayerOption defaultOption];
    [option setOptionValue:@15 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
    //rtmp://live.hkstv.hk.lxdns.com/live/hks
    NSURL *url = [NSURL URLWithString:@"rtmp://live.hkstv.hk.lxdns.com/live/hks"];
    // NSURL *url = [NSURL URLWithString:@"rtmp://pili-live-rtmp.reiniot.shangjinxin.net/reiniot/imei?key=50cf452b9d872f58"];
    //    NSString *rtmp = [USERDEFAULT objectForKey:@"ORIGIN"];
    //NSURL *url = [NSURL URLWithString:self.rtmp];
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
    
    
    _datepicker = [[UIDatePicker alloc]init];
    _datepicker.datePickerMode = UIDatePickerModeDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:_datepicker.date];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    // components.nanosecond = 0 not available in iOS
    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
    _date = [NSDate dateWithTimeIntervalSince1970:ts];
    [self.view addSubview:_datepicker];
    [_datepicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    [_datepicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 80));
        make.centerX.equalTo(self.view.mas_centerX);
         make.top.equalTo(playView.mas_bottom).offset(30);
    }];
    
   
    
    UIImageView *ruler = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"矩形-3-拷贝-3"]];
    ruler.userInteractionEnabled = YES;
    [self.view addSubview:ruler];
    [ruler mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width, 54));
        make.top.equalTo(playView.mas_bottom).offset(150);
    }];
    
    
   // CGFloat rulery = playView.mas_height + 20 + 150;
    
    CGFloat sliderHeight = [ZVScrollSlider heightWithBoundingWidth:self.view.bounds.size.width Title:nil];
    ZVScrollSlider *productSlider  = [[ZVScrollSlider alloc]initWithFrame:CGRectMake(0, -68, self.view.bounds.size.width, sliderHeight)
                                                                    Title:nil
                                                                 MinValue:0
                                                                 MaxValue:144
                                                                     Step:1
                                                                     Unit:@"点"
                                                             HasDeleteBtn:NO];
    productSlider.alpha = 0.7;
    productSlider.delegate = self;
    [ruler addSubview:productSlider];
  
    
    
    
    
    
    UIImageView *line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"su"]];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(13, 57));
        make.top.equalTo(ruler);
    }];
    
}

//datepicker响应
-(void)dateChanged:(id)sender{
    UIDatePicker *control = (UIDatePicker*)sender;
    _date = control.date;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:_date];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    // components.nanosecond = 0 not available in iOS
    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
    _date = [NSDate dateWithTimeIntervalSince1970:ts];
    
    //时区设置
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate:_date];
//    _date = [_date dateByAddingTimeInterval:interval];
    NSLog(@"%@",_date);
}

-(void)fullscreen{
    RepalyfullScreenViewController *vc = [[RepalyfullScreenViewController alloc]init];
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
        [btn setImage:[UIImage imageNamed:@"onlive_smallscreen_voice"] forState:UIControlStateNormal];
    }else{
        [self.player setVolume:1];
        [btn setImage:[UIImage imageNamed:@"onlive_smallscreen_novoice"] forState:UIControlStateNormal];
    }
    
    
}

-(void)ZVScrollSlider:(ZVScrollSlider *)slider ValueChange:(int)value{
    
    self.time = value;
    self.timeText = [NSString stringWithFormat:@"%d:%d0",value/6%24,value%6];
    NSLog(@"%@",_timeText);
    NSDate *datetime =[_date initWithTimeInterval:self.time*600 sinceDate:_date];
    NSTimeInterval interval = [datetime timeIntervalSince1970];
    NSLog(@"%@",_date);
    NSLog(@"%f",interval);
    NSString *timestamp = [NSString stringWithFormat:@"%.0f",interval];
    NSDictionary *dic = @{@"type":@"3",@"data":@"2",@"content":timestamp};
    [self Httplogin:dic];
    
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
//                UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"聊天不可用！" message:[error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                //[view show];
                [SVProgressHUD showErrorWithStatus:@"聊天不可用"];
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
            
                [conversation sendMessage:[AVIMTextMessage messageWithText:msgjson attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        NSLog(@"发送成功！");
                        
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"聊天不可用"];
                    }
                }];
                
            
            
            
        }];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败%@",error);
        
    }];
    
    
    //NSLog(@"%@",self.sig);
    
    
    
}

-(AVIMSignature *)signatureWithClientId:(NSString *)clientId conversationId:(NSString *)conversationId action:(NSString *)action actionOnClientIds:(NSArray *)clientIds{
    
    return self.sig;
    
}

// 接收消息的回调函数
-(void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message{
    NSLog(@"xiaoxi---------------------%@", message.text);
    
    if([message.text isEqualToString:@"收到消息"]){
        
    }else{
        NSMutableString *responseString = [NSMutableString stringWithString:message.text];
        //    NSString *character = nil;
        //    for (int i = 0; i < responseString.length; i ++) {
        //        character = [responseString substringWithRange:NSMakeRange(i, 1)];
        //        if ([character isEqualToString:@"\\"])
        //            [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
        //    }
        [responseString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        //NSLog(@"%@",responseString);
        NSDictionary *dic =[GLTools dictionaryWithJsonString:responseString];
        NSDictionary *msg = [dic objectForKey:@"msg"];
        NSString *startime = [msg objectForKey:@"starttime"];
        NSString *endtime = [msg objectForKey:@"endtime"];
        
        NSInteger start = [startime integerValue]/1000;
        NSInteger end = [endtime integerValue]/1000;
        _minDate = [NSDate dateWithTimeIntervalSince1970:start];
        _maxDate = [NSDate dateWithTimeIntervalSince1970:end];
        _datepicker.minimumDate = _minDate;
        _datepicker.maximumDate = _maxDate;
        
    }
    

    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSDictionary *dic = @{@"type":@"3",@"data":@"1"};
    [self Httplogin:dic];
    self.title = @"回放";
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:BColor,NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    self.navigationController.navigationBarHidden = NO;
    [self.player play];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.player stop];
    
    
    
    
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
