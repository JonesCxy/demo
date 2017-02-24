//
//  CxyThumbButton.m
//  空间点赞效果
//
//  Created by  on 2017/2/23.
//  Copyright © 2017年 崔心月. All rights reserved.
//

#import "CxyThumbButton.h"

#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define randomCor RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

@interface ZanImageView ()

@end

@implementation ZanImageView

-(instancetype)init{

    self = [super init];
    if (self) {
        
        self.image = [UIImage imageNamed:@"ZanFiger0"];
        UIImage *newImage = [self.image imageWithColor:randomCor];
        self.image = newImage;
    }
    return self;
}

@end


#define kZanWH 25.f
#define kXOffSet 30.f
#define kYOffSet 80.f
#define kButtonH 25.f
#define kThumbImgWH kButtonH/2
#define kNumLabelH kButtonH/2
#define kNumFont [UIFont systemFontOfSize:13.f]

@interface CxyThumbButton (){

    UIImage *_defImage; // 点赞前默认图片
    UIImage *_selImage; // 点赞后图片
    NSInteger _defCount; // 初始化时显示的点赞数
    NSInteger _count; // 已经点赞个数
    NSInteger _numLength; // 总点赞数长度

}


// 允许最大点赞数
@property(assign,nonatomic)NSInteger maxFingers;
// 点赞按钮左边手势
@property(nonatomic,strong)UIImageView *thumbImgView;
// 点赞按钮 赞数量
@property(nonatomic,strong)UILabel *numLabel;
// 动画显示那个点赞手势
@property(nonatomic,strong)ZanImageView *zanImgView;

@end

@implementation CxyThumbButton

-(instancetype)initWithOrigin:(CGPoint)origin defImage:(UIImage *)defImage selImage:(UIImage *)selImage defCount:(NSInteger)defCount maxFingers:(NSInteger)maxFingers{


    NSString *num = [NSString stringWithFormat:@"%ld",defCount];
    CGSize size = [num sizeWithFont:kNumFont maxSize:CGSizeMake(100.f, 20.f)];
    CGRect frame = CGRectMake(origin.x, origin.y, kThumbImgWH + size.width + 40.f, kButtonH);
    
    if (self = [super initWithFrame:frame]) {
        
        _count = 0;
        _defImage = defImage;
        _selImage = selImage;
        _defCount = defCount;
        _numLength = num.length;
        _maxFingers = maxFingers;
        [self setupSubViews];
    }

    return self;

}


-(UIImageView *)thumbImgView{

    if (!_thumbImgView) {
        
        _thumbImgView = [[UIImageView alloc]init];
        _thumbImgView.frame = CGRectMake(10.f+5.f, kButtonH / 4, kThumbImgWH, kThumbImgWH);
        _thumbImgView.image = _defImage;
        _thumbImgView.contentMode = UIViewContentModeCenter;
    }
    return _thumbImgView;
}


-(UILabel *)numLabel{

    if (!_numLabel) {
        _numLabel = [[UILabel alloc]init];
        _numLabel.font = kNumFont;
        NSString *num = [NSString stringWithFormat:@"%ld",_defCount];
        _numLabel.textColor = [UIColor whiteColor];
        _numLabel.text = num;
        CGSize size = [num sizeWithFont:kNumFont maxSize:CGSizeMake(100.f, 20.f)];
        _numLabel.frame = CGRectMake(10.f+kThumbImgWH+15.f, kButtonH / 4, size.width, kNumLabelH);
    }
    return _numLabel;
}


-(void)setupSubViews{

    [self addSubview:self.thumbImgView];
    [self addSubview:self.numLabel];
    
    self.layer.cornerRadius = 12.5f;
    self.layer.borderColor = [UIColor colorWithWhite:0.900 alpha:0.600].CGColor;
    self.layer.borderWidth = 0.5f;
    self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(thumbButtonClick)];
    
    [self addGestureRecognizer:tap];

}

-(void)thumbButtonClick{

    if (_count >= self.maxFingers && _maxFingers != 0) {
        
        // 点赞失败
        if (self.delegate && [self.delegate respondsToSelector:@selector(cxy_thumbFail)]) {
            [self.delegate cxy_thumbFail];
        }
        
        else if (self.cxy_thumbFailBlock){
        
            self.cxy_thumbFailBlock(YES);
        }else{
        
            NSLog(@"未设置代理或者回调,如果要获取点赞结果请设置");
        }
        return;
        
    }
    
    else{
    
        NSString *oriNum = self.numLabel.text;
        NSString *newNum = [NSString stringWithFormat:@"%d",[oriNum intValue]+1];
        self.numLabel.text = newNum;
        
        CGSize size = [newNum sizeWithFont:kNumFont maxSize:CGSizeMake(100.f, 20.f)];
        _numLabel.frame = CGRectMake(10.f+kThumbImgWH + 15.f, kButtonH / 4, size.width, kNumLabelH);
        
        if (newNum.length > _numLength) { // 如果点赞数长度发生变化，重新计算button的frame
            
            self.w = kThumbImgWH + 20.f + size.width + 10.f + 10.f;
            _numLength = newNum.length;
            [self setNeedsLayout];
        }
        
        self.thumbImgView.image = _selImage;
        
        NSInteger zans = [self.numLabel.text integerValue];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(cxy_thumbBtClick:)]) {
            
            [self.delegate cxy_thumbBtClick:zans];
        }else if (self.cxy_thumbClickBlock){
        
            self.cxy_thumbClickBlock(zans);
        }else{
        
            NSLog(@"未设置代理或者回调,如果要获取点赞结果请设置");
            
        }
        _count++;
        
    }
    
    
#pragma mark -- 动画
    CGPoint center = CGPointMake(self.w/2, self.h/2);
    UIImageView *zanImgView = [[ZanImageView alloc] init];
    zanImgView.center = center;
    zanImgView.alpha = 0.9f;
    zanImgView.bounds = CGRectMake(0.f, 0.f, 0.f, 0.f);
    
    // 向上移动
    NSInteger i = arc4random_uniform(2);
    NSInteger direction = 1 - (2*i);
    
    UIBezierPath *bezPath = [UIBezierPath bezierPath];
    [bezPath moveToPoint:center];
    CGPoint endPoint = CGPointMake(center.x, center.y-200.f);
    
    CGPoint cPoint1 = CGPointMake(center.x - kXOffSet*direction, -kYOffSet);
    CGPoint cPoint2 = CGPointMake(center.x + kXOffSet*direction, -kYOffSet);
    
    [bezPath addCurveToPoint:endPoint controlPoint1:cPoint1 controlPoint2:cPoint2];
    
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani.path = bezPath.CGPath;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    ani.duration = 2.f;
    ani.removedOnCompletion = YES;
    [zanImgView.layer addAnimation:ani forKey:nil];
    
    // 先向上移动一小段距离
    [UIView animateWithDuration:0.1f animations:^{
        zanImgView.transform = CGAffineTransformMakeTranslation(0.f, -20.f);
    }];
    
    // 弹簧效果弹出
    [UIView animateWithDuration:0.2f delay:0.1f usingSpringWithDamping:0.5f initialSpringVelocity:50.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        zanImgView.bounds = CGRectMake(0, 0, kZanWH, kZanWH);
    } completion:NULL];
    
    // 渐隐消失
    [UIView animateKeyframesWithDuration:2.f delay:0.f options:0.f animations:^{
        [self addSubview:zanImgView];
        [UIView addKeyframeWithRelativeStartTime:3/4.f relativeDuration:1/4.f animations:^{
            zanImgView.alpha = 0.f;
        }];
    } completion:^(BOOL finished) {
        [zanImgView removeFromSuperview];
    }];

    

}


@end
