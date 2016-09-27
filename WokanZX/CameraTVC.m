//
//  CameraTVC.m
//  WokanZX
//
//  Created by Lucccc on 16/9/23.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "CameraTVC.h"
#import "GLButton.h"


@implementation CameraTVC


-(instancetype)initWithIntNum:(NSInteger)section row:(NSInteger)row{
    if (self == [super init]) {
        //        NSLog(@"%d",section);
        //        NSLog(@"%d",row);
       
        WS();
        
        UIImageView *CameraImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_1"]];
        [self.contentView addSubview:CameraImg];
        
        UIView *btnView = [[UIView alloc]init];
        btnView.backgroundColor = [UIColor clearColor];
    
        
        [self.contentView addSubview:btnView];
        
        [CameraImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf.contentView);
            make.edges.mas_offset(UIEdgeInsetsMake(10, 10, 40, 10));
        }];
        
        [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(CameraImg);
            make.bottom.equalTo(CameraImg.mas_bottom);
            make.height.mas_equalTo(70);
            make.centerX.equalTo(CameraImg.mas_centerX);
        }];
        
        
        GLButton *livebtn = [[GLButton alloc]init];
        livebtn.alpha = 0.7;
        [livebtn setTitle:@"直播" forState:UIControlStateNormal];
       // livebtn.tag = section *100+row+1;
        livebtn.tag = section *300+row+1;
                [livebtn addTarget:self action:@selector(livebtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:livebtn];
        
        
        GLButton *replaybtn = [[GLButton alloc]init];
        replaybtn.alpha = 0.7;
        [replaybtn setTitle:@"回放" forState:UIControlStateNormal];
        replaybtn.tag = section *200+row+1;
        
        [replaybtn addTarget:self action:@selector(replaybtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:replaybtn];
    
        
        GLButton *setbtn = [[GLButton alloc]init];
        setbtn.alpha = 0.7;
        [setbtn setTitle:@"设置" forState:UIControlStateNormal];
        setbtn.tag = section *300+row+1;
        [setbtn addTarget:self action:@selector(setbtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:setbtn];
        
        [replaybtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(btnView);
            make.bottom.equalTo(CameraImg).offset(-15);
            make.size.mas_equalTo(CGSizeMake(80, 27));
            
        }];
        
        [livebtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(replaybtn.mas_centerY);
            make.bottom.equalTo(CameraImg).offset(-15);
            make.size.mas_equalTo(CGSizeMake(80, 27));
            make.trailing.equalTo(replaybtn.mas_leading).offset(-10);
            
        }];
        
        [setbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(replaybtn.mas_centerY);
            make.bottom.equalTo(CameraImg).offset(-15);
            make.size.mas_equalTo(CGSizeMake(80, 27));
            make.leading.equalTo(replaybtn.mas_trailing).offset(10);
            
        }];

        self.btnView = btnView;
        btnView.hidden = YES;
    }
    
    return self;
}


//cell中的点击事件，调用协议中的方法
-(void)livebtnClicked:(UIButton *)btn{
    NSInteger tag = btn.tag;
    NSInteger section = tag/100;
    NSInteger row = tag%100;
    //    让viewController遵循协议，在viewController中具体实现该方法
    if (_btnDelegate !=nil &&[_btnDelegate respondsToSelector:@selector(liveBtnClicked:row:)]) {
        [self.btnDelegate liveBtnClicked:section row:row];
    }
    
    

}

-(void)replaybtnClicked:(UIButton *)btn{
    NSInteger tag = btn.tag;
    NSInteger section = tag/200;
    NSInteger row = tag%200;
    //    让viewController遵循协议，在viewController中具体实现该方法
    if (_btnDelegate !=nil &&[_btnDelegate respondsToSelector:@selector(replayBtnClicked:row:)]) {
        [self.btnDelegate replayBtnClicked:section row:row];
    }
    
    
    
}

-(void)setbtnClicked:(UIButton *)btn{
    NSInteger tag = btn.tag;
    NSInteger section = tag/100;
    NSInteger row = tag%200;
    //    让viewController遵循协议，在viewController中具体实现该方法
       if (_btnDelegate !=nil &&[_btnDelegate respondsToSelector:@selector(setBtnClicked:row:)]) {
           [self.btnDelegate setBtnClicked:section row:row];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
