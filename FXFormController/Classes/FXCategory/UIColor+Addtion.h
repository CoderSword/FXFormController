//
//  UIColor+Addtion.h
//  InvasiveSpecies
//
//  Created by 杨健 on 2020/4/14.
//  Copyright © 2020 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Addtion)

//声明直接输入颜色代码以字符串形式传入的方法，单参形式
+(UIColor *)colorWithHexString:(NSString *)colorString;

//声明直接输入颜色代码以字符串形式传入和透明度以CGFloat形式传入的方法，两个输出参数
+(UIColor *)colorWithHexString:(NSString *)colorString Alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
