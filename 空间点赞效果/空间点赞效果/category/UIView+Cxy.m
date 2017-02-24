//
//  UIView+Cxy.m
//  空间点赞效果
//
//  Created by 华美赛佳 on 2017/2/23.
//  Copyright © 2017年 崔心月. All rights reserved.
//

#import "UIView+Cxy.h"

@implementation UIView (Cxy)


-(void)setX:(CGFloat)x{

    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


-(CGFloat)x{

    return self.frame.origin.x;

}

-(void)setY:(CGFloat)y{

    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGFloat)y{

    return self.frame.origin.y;
}

-(void)setW:(CGFloat)w{

    CGRect frame = self.frame;
    frame.size.width = w;
    self.frame = frame;
}

-(CGFloat)w{

    return self.frame.size.width;

}


-(void)setH:(CGFloat)h{

    CGRect frame = self.frame;
    frame.size.height = h;
    self.frame = frame;
    
}
-(CGFloat)h{

    return self.frame.size.height;
}

-(CGFloat)centerX{

    return self.center.x;
}

-(CGFloat)centerY{

    return self.center.y;
}


-(UIViewController *)viewController{

    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}



@end
