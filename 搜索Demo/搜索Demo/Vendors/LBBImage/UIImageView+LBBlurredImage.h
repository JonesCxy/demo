//
//  UIImageView+LBBlurredImage.h
//  搜索Demo
//
//  Created by 华美赛佳 on 2017/2/27.
//  Copyright © 2017年 JonesCxy. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^LBBlurredImageCompletionBlock)(void);

extern CGFloat const kLBBlurredImageDefaultBlurRadius;

@interface UIImageView (LBBlurredImage)

-(void)setImageToBlur:(UIImage *)image
           blurRadius:(CGFloat)blurRadius
      completionBlock:(LBBlurredImageCompletionBlock)completion;


-(void)setImageToBlur:(UIImage *)image
      completionBlock:(LBBlurredImageCompletionBlock)completion;


-(void)setViewContext:(UIView *)view rectInView:(CGRect)rect blurRadius:(CGFloat)blurRadius completionBlock:(LBBlurredImageCompletionBlock)completion;


@end
