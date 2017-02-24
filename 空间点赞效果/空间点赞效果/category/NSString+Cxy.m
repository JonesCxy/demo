//
//  NSString+Cxy.m
//  空间点赞效果
//
//  Created by 华美赛佳 on 2017/2/23.
//  Copyright © 2017年 崔心月. All rights reserved.
//

#import "NSString+Cxy.h"

@implementation NSString (Cxy)

-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize{

    NSDictionary *attribute = @{NSFontAttributeName : font};
    
    return [self boundingRectWithSize:maxSize
                              options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:attribute
                              context:nil].size;

}


@end
