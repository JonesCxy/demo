//
//  UIImage+ImageEffects.h
//  搜索Demo
//
//  Created by 华美赛佳 on 2017/2/24.
//  Copyright © 2017年 JonesCxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageEffects)


-(UIImage *)applyLightEffect;
-(UIImage *)applyExtraLightEffect;
-(UIImage *)applyDarkEffect;
-(UIImage *)applyTintEffectWithColor:(UIColor *)tinkColor;


-(UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end
