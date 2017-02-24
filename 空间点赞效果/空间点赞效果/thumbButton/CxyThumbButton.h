//
//  CxyThumbButton.h
//  空间点赞效果
//
//  Created by 华美赛佳 on 2017/2/23.
//  Copyright © 2017年 崔心月. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZanImageView : UIImageView

@end



@protocol CxyThumbBtDelegate <NSObject>

// 点击了点赞按钮时触发此方法(前提设置了delegate)
-(void)cxy_thumbBtClick:(NSInteger)zans;


// 点赞失败触发此方法(超过了最大允许的点赞数)(前提设置了delegate)
-(void)cxy_thumbFail;

@end

@interface CxyThumbButton : UIView


// 点击了点赞按钮时回调(zan:当前显示的点赞数)
@property(nonatomic,copy)void(^cxy_thumbClickBlock)(NSInteger zans);

// 点赞失败回调(超过了最大允许的点赞数)
@property(nonatomic,copy)void(^cxy_thumbFailBlock)(BOOL isFail);

// 如果使用代理方法回调 请设置delegate
@property(nonatomic,assign)id<CxyThumbBtDelegate>delegate;


// 回车直接敲,加上:就会对齐
// origin 按钮的(origin)(即x和y)
//
-(instancetype)initWithOrigin:(CGPoint)origin
                     defImage:(UIImage *)defImage // 按钮没点赞之前显示的默认图
                     selImage:(UIImage *)selImage // 点赞之后显示的图片
                     defCount:(NSInteger)defCount // 没点赞之前显示的点赞数
                   maxFingers:(NSInteger)maxFingers; // 可被点赞的最大次数 (如果没有点赞数限制,请务必将此参数设为0,此参数不能空!)


@end
