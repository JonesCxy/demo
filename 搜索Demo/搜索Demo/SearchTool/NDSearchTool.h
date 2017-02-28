//
//  NDSearchTool.h
//  搜索Demo
//
//  Created by 华美赛佳 on 2017/2/24.
//  Copyright © 2017年 JonesCxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDSearchTool : NSObject


/**
 创建实例对象

 @return 搜索对象
 */
+(NDSearchTool *)tool;



/**
 默认搜索

 @param fieldArray 搜索字段数组
 @param inputStr 输入文字
 @param array 搜索数据源
 @return 搜索结果
 */
-(NSArray *)searchWithFieldArray:(NSArray *)fieldArray
                     inputString:(NSString *)inputStr
                         inArray:(NSArray *)array;


/**
 分组搜索

 @param allFieldArray 字段数组集合
 @param inputString 输入文字
 @param allArray 搜索数组集合
 @return 搜索结果
 */
-(NSArray *)searchWithFieldArray:(NSArray *)allFieldArray
                     inputString:(NSString *)inputString
                      inAllArray:(NSArray *)allArray;



@end
