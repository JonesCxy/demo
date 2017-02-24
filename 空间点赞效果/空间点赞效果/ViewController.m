//
//  ViewController.m
//  空间点赞效果
//
//  Created by 华美赛佳 on 2017/2/23.
//  Copyright © 2017年 崔心月. All rights reserved.
//

#import "ViewController.h"
#import "CxyThumbButton.h"
@interface ViewController ()<CxyThumbBtDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGPoint origin = CGPointMake(150, 300);
    
    CxyThumbButton *button = [[CxyThumbButton alloc]initWithOrigin:origin defImage:[UIImage imageNamed:@"usersummary_header_zan"] selImage:[UIImage imageNamed:@"usersummary_header_zan_sel"] defCount:90 maxFingers:30];
    
//    button.delegate = self;
    [self.view addSubview:button];
    
    // 实现回调
    button.cxy_thumbFailBlock = ^(BOOL isFail){
    
    
        NSLog(@"点赞失败block,超过最大允许点赞数");
    };
    
    button.cxy_thumbClickBlock = ^(NSInteger zans){
    
        NSLog(@"---点赞成功block,当前赞数:%ld",zans);
    };
    
}

-(void)cxy_thumbFail{

    NSLog(@"点赞失败");

}
-(void)cxy_thumbBtClick:(NSInteger)zans{

    NSLog(@"--点赞成功,当前点赞数:%ld",zans);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
