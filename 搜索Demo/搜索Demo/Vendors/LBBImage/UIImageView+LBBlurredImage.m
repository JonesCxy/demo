//
//  UIImageView+LBBlurredImage.m
//  搜索Demo
//
//  Created by 华美赛佳 on 2017/2/27.
//  Copyright © 2017年 JonesCxy. All rights reserved.
//

#import "UIImageView+LBBlurredImage.h"
#import "UIImage+ImageEffects.h"

CGFloat const kLBBlurredImageDefaultBlurRadius            = 20.0;
CGFloat const kLBBlurredImageDefaultSaturationDeltaFactor = 1.8;

@implementation UIImageView (LBBlurredImage)

-(void)setImageToBlur:(UIImage *)image completionBlock:(LBBlurredImageCompletionBlock)completion{
    
    [self setImageToBlur:image blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:completion];
    
}


-(void)setImageToBlur:(UIImage *)image blurRadius:(CGFloat)blurRadius completionBlock:(LBBlurredImageCompletionBlock)completion{
    
    NSParameterAssert(image);
    NSParameterAssert(blurRadius >= 0);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *blurredImage = [image applyBlurWithRadius:blurRadius tintColor:nil saturationDeltaFactor:kLBBlurredImageDefaultSaturationDeltaFactor maskImage:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.image = blurredImage;
            if (completion) {
                completion();
            }
        });
        
    });
    
}


- (void)setViewContext:(UIView *)view rectInView:(CGRect)rect blurRadius:(CGFloat)blurRadius completionBlock:(LBBlurredImageCompletionBlock)completion{
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGRect tempRect = CGRectMake(rect.origin.x, rect.origin.x + 144, rect.size.width, rect.size.height);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, tempRect);
    //    UIImage *resultImage = [UIImage imageWithCGImage:imageRef scale:2.0 orientation:(UIImageOrientationUp)];
    
    
    CGImageRelease(imageRef);
    
    [self setImageToBlur:image blurRadius:blurRadius completionBlock:completion];
    
    
}


@end
