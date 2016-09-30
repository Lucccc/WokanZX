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
#import "Device.h"
#import "DeviceResult.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,btnClickedDelegate>

@property(nonatomic,assign)NSInteger index;
@property(nonatomic,weak)UITableView *tableview;

@property(nonatomic,strong)DeviceResult *deviceResult;

@end

@implementation HomeViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD dismiss];
    
    //[self setupRefresh];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_logotittle"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_set_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_addcamera_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(addCamera)];
    

    
    UITableView *tableview = [[UITableView alloc]init];
   
    [tableview registerNib:[UINib nibWithNibName:@"CameraTableViewCell" bundle:nil] forCellReuseIdentifier:@"aqw"];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.rowHeight = 300;
    tableview.scrollEnabled =YES;
    //tabelView.delaysContentTouches = NO;
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [tableview.mj_footer beginRefreshing];
        [self loadMoreComments];
    }];
    
    
    [self.view addSubview:tableview];
    
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
   
    self.tableview  = tableview;
    
    [self setupRefresh];
    
//    PLPlayerOption *option = [PLPlayerOption defaultOption];
//    [option setOptionValue:@15 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
//    NSURL *url = [NSURL URLWithString:@"rtmp://pili-live-rtmp.reiniot.shangjinxin.net/reiniot/test00000000001"];
//    self.player = [PLPlayer playerWithURL:url option:option];
//    self.player.delegate = self;
//    
//    [self.view addSubview:self.player.playerView];
//    
//    [self.player play];

    
    
}

/**
 * 更新视图.
 */

-(void)setupRefresh{
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    [self.tableview.mj_header beginRefreshing];
}

-(void)loadMoreComments{
    
    AFHTTPSessionManager * manager =[AFHTTPSessionManager manager];
    NSString *code = [USERDEFAULT objectForKey:@"persistence_code"];
    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:code,@"persistence_code", nil];
    
    
    
    [manager POST:@"http://reiniot.shangjinxin.net/api/user/devices" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.deviceResult = [DeviceResult mj_objectWithKeyValues:responseObject];
        
        
        [self.tableview reloadData];
        [self.tableview.mj_footer endRefreshing];
        [self.tableview.mj_header endRefreshing];
      
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // NSLog(@"失败%@",error);
        [self.tableview.mj_footer endRefreshing];
        [self.tableview.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:failTipe];
    }];
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.deviceResult.devices.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reid = @"aaaa";
    
    
    CameraTVC *cell = [tableView dequeueReusableCellWithIdentifier:reid];
    
    if(cell == nil){
        cell= [[CameraTVC alloc]initWithIntNum:indexPath.section row:indexPath.row];
        cell.device = self.deviceResult.devices[indexPath.row];
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
    
    
    if ([USERDEFAULT objectForKey:@"ORIGIN"] != nil) {
        NSLog(@"%s",__func__);
        NSLog(@"第%ld块%ld行被点击",section,row);
        LiveViewController *liveVC = [[LiveViewController alloc]init];
        UIBarButtonItem *bbt = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.backBarButtonItem = bbt;
        [self.navigationController pushViewController:liveVC animated:YES];
    }else{
        AFHTTPSessionManager * manager =[AFHTTPSessionManager manager];
        NSString *code = [USERDEFAULT objectForKey:@"persistence_code"];
        NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:@"test00000000001",@"imei",code,@"persistence_code", nil];
        [manager POST:@"http://reiniot.shangjinxin.net/api/user/pull-info" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *resdict =(NSDictionary *)responseObject;
            
            [USERDEFAULT setObject:[resdict objectForKey:@"ORIGIN"] forKey:@"ORIGIN"];
            NSLog(@"%s",__func__);
            NSLog(@"第%ld块%ld行被点击",section,row);
            LiveViewController *liveVC = [[LiveViewController alloc]init];
            UIBarButtonItem *bbt = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
            self.navigationItem.backBarButtonItem = bbt;
            [self.navigationController pushViewController:liveVC animated:YES];
            
            // NSLog(@"发送成功%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // NSLog(@"失败%@",error);
            [SVProgressHUD showErrorWithStatus:failTipe];
        }];
    }
    
    

    
    
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
