//
//  NSArray+Addition.m
//  NeiHan
//
//  Created by Charles on 16/5/9.
//  Copyright © 2016年 Com.Charles. All rights reserved.
//

#import "NSArray+Addition.h"


@implementation NSArray (Addition)

- (instancetype)noRepeatArray { 
    return [self newArrayWithArray:self.mutableCopy];
}

- (NSMutableArray *)newArrayWithArray:(NSMutableArray *)array {
    
    NSMutableArray *newArray = [NSMutableArray new];
    
    for (unsigned i = 0; i < [array count]; i++) {
        if (![newArray containsObject:array[i]]) {
            [newArray addObject:array[i]];
        }
    }
    return newArray;
}
+ (NSArray *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}


- (NSString *)toJSONString {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                     error:nil];
     
    if (data == nil) {
        return nil;
    }
     
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    NSMutableString *mutabStr = [NSMutableString stringWithString:string];
    [mutabStr stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return string;
}
 
- (NSString *)toReadableJSONString {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
     
    if (data == nil) {
        return nil;
    }
     
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    return string;
}
 
- (NSData *)toJSONData {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
     
    return data;
}


@end
 
