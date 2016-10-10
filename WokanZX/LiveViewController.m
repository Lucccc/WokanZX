//
//  LiveViewController.m
//  WokanZX
//
//  Created by Lucccc on 16/9/23.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "LiveViewController.h"
#import "fullScreenVC.h"

@interface LiveViewController ()
@property(nonatomic ,copy)NSString *rtmp;

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
    
    
    
}


-(void)fullscreen{
    fullScreenVC *vc = [[fullScreenVC alloc]init];
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
