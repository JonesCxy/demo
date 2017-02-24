//
//  UIImage+Cxy.m
//  空间点赞效果
//
//  Created by 华美赛佳 on 2017/2/23.
//  Copyright © 2017年 崔心月. All rights reserved.
//

#import "UIImage+Cxy.h"

@implementation UIImage (Cxy)


-(UIImage *)imageWithColor:(UIColor *)color{

    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(ctx, 0, self.size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(ctx, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(ctx, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsGetCurrentContext();
    
    return newImage;
    
}

@end
