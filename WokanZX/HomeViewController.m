//
//  HomeViewController.m
//  WokanZX
//
//  Created by Lucccc on 16/9/11.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "HomeViewController.h"
#import "AddCameraViewController.h"
#import "CameraTVC.h"
#import "LiveViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,btnClickedDelegate>

@property(nonatomic,assign)NSInteger index;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_logotittle"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_set_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_addcamera_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(addCamera)];
    

    
    UITableView *tabelView = [[UITableView alloc]init];
    [tabelView registerNib:[UINib nibWithNibName:@"CameraTableViewCell" bundle:nil] forCellReuseIdentifier:@"aqw"];
    tabelView.delegate = self;
    tabelView.dataSource = self;
    tabelView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1000);
    tabelView.rowHeight = 300;
    tabelView.scrollEnabled =YES;
    //tabelView.delaysContentTouches = NO;
    [self.view addSubview:tabelView];
    
    
//    PLPlayerOption *option = [PLPlayerOption defaultOption];
//    [option setOptionValue:@15 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
//    NSURL *url = [NSURL URLWithString:@"rtmp://pili-live-rtmp.reiniot.shangjinxin.net/reiniot/test00000000001"];
//    self.player = [PLPlayer playerWithURL:url option:option];
//    self.player.delegate = self;
//    
//    [self.view addSubview:self.player.playerView];
//    
//    [self.player play];

    
    
    // Do any additional setup after loading the view from its nib.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reid = @"aaaa";
    
    
    CameraTVC *cell = [tableView dequeueReusableCellWithIdentifier:reid];
    
    if(cell == nil){
         cell= [[CameraTVC alloc]initWithIntNum:indexPath.section row:indexPath.row];;
    }
    
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    cell.btnDelegate = self;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CameraTVC *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.index = indexPath.row;
    
    cell.btnView.hidden = !cell.btnView.hidden;
    
    
}


-(void)liveBtnClicked:(NSInteger)section row:(NSInteger)row{
    NSLog(@"%s",__func__);
    NSLog(@"第%ld块%ld行被点击",section,row);
    LiveViewController *liveVC = [[LiveViewController alloc]init];
    UIBarButtonItem *bbt = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = bbt;
    [self.navigationController pushViewController:liveVC animated:YES];
    
}

-(void)replayBtnClicked:(NSInteger)section row:(NSInteger)row{
    NSLog(@"%s",__func__);
    NSLog(@"第%ld块%ld行被点击",section,row);
    
}

-(void)setBtnClicked:(NSInteger)section row:(NSInteger)row{
    NSLog(@"%s",__func__);
    NSLog(@"第%ld块%ld行被点击",section,row);
}
- (void)showMenu
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (void)addCamera
{
    NSLog(@"add camera");
    AddCameraViewController *addVC = [[AddCameraViewController alloc]init];
    UIBarButtonItem *bbt = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = bbt;
    [self.navigationController pushViewController:addVC animated:YES];
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
