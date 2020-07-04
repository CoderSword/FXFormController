//
//  NSArray+Addition.h
//  NeiHan
//
//  Created by Charles on 16/5/9.
//  Copyright © 2016年 Com.Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Addition)

/**
 *  数组去重 
 */
- (instancetype)noRepeatArray;


+ (NSArray *)readLocalFileWithName:(NSString *)name;


/**
 *  转换成JSON串字符串（没有可读性）
 *
 *  @return JSON字符串
 */
- (NSString *)toJSONString;
 
/**
 *  转换成JSON串字符串（有可读性）
 *
 *  @return JSON字符串
 */
- (NSString *)toReadableJSONString;
 
/**
 *  转换成JSON数据
 *
 *  @return JSON数据
 */
- (NSData *)toJSONData;

@end 
