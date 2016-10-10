//
//  LeftMenuViewController.m
//  WokanZX
//
//  Created by Lucccc on 16/9/6.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "HomeViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"


@interface LeftMenuViewController ()
@property (strong, readwrite, nonatomic) UITableView *tableView;

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"侧边栏bg"]];
    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.edges.mas_offset(UIEdgeInsetsMake(10, 0, 300, 0));
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.height.mas_equalTo(300);
        make.top.mas_equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
    UIImageView *logView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"start_tittle"]];
    [self.view addSubview:logView];
    [logView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(180, 35));
        make.left.equalTo(self.view.mas_left).offset(20);
    }];
    
    
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 5) / 1.0f, self.view.frame.size.width, 54 * 5) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor blueColor];
        
        tableView.backgroundView = nil;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        
        case 0:
            self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
            self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:[[FirstViewController alloc] init]];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 2:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[SecondViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 3:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ThirdViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 4:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[FourthViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = BColor;
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    NSArray *titles = @[@"Home", @" 账号设置", @"切换清晰度", @"观看演示", @" 关于"];
    NSArray *images = @[@"121", @"home_userset", @"home_switch", @"home_view", @"home_about"];
    cell.textLabel.text = titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
