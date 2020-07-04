//
//  UIColor+Addtion.m
//  InvasiveSpecies
//
//  Created by 杨健 on 2020/4/14.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "UIColor+Addtion.h"

@implementation UIColor (Addtion)

+(UIColor *)colorWithHexString:(NSString *)colorString{
    return [self colorWithHexString:colorString Alpha:1.0f];
}
+(UIColor *)colorWithHexString:(NSString *)colorString Alpha:(CGFloat)alpha{
//    转化传进来的字符串，去除空格
    NSString *tranString = [[colorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
//    如果直接输入6位颜色码也可以让处理
    if (tranString.length < 6) {
//        小于6位的为 非法的颜色代码
        return [UIColor whiteColor];
    }else if (tranString.length == 6){
        return [self colorWithRGB:tranString Alpha:alpha];
    }else{
        //    判断字符串格式的问题--从计算机的数值表示上讲，0x开头的其实并不是所谓颜色代码的表示方法，而是16进制数的标准写法。譬如0xA就是十进制的10。
        //    而#开头的六（或三）位十六进制数是在设计领域（如CSS以及一些绘图软件）中颜色代码的表示方法。
        if ([tranString hasPrefix:@"0X"]||[tranString hasPrefix:@"0x"]) {
            tranString = [tranString substringWithRange:NSMakeRange(2, tranString.length-2)];
        }else if ([tranString hasPrefix:@"#"]) {
            tranString = [tranString substringWithRange:NSMakeRange(1, tranString.length-1)];
        }else{
            return [UIColor whiteColor];
        }
    }
//    返回所设置的颜色
    return [self colorWithRGB:tranString Alpha:alpha];
}

+(UIColor *)colorWithRGB:(NSString *)rgbString Alpha:(CGFloat)alpha{
    NSRange range;
    range.length = 2;
//    R
    range.location = 0;
    NSString *rString = [rgbString substringWithRange:range];
//    G
    range.location = 2;
    NSString *gString = [rgbString substringWithRange:range];
//    B
    range.location = 4;
    NSString *bString = [rgbString substringWithRange:range];
    
//    NSScanner是一个类，用于在字符串中扫描指定的字符，尤其是把它们翻译/转换为数字和别的字符串。可以在创建NSScaner时指定它的string属性，然后scanner会按照你的要求从头到尾地扫描这个字符串的每个字符
    unsigned int R, G ,B;
    [[NSScanner scannerWithString:rString] scanHexInt:&R];
    [[NSScanner scannerWithString:gString] scanHexInt:&G];
    [[NSScanner scannerWithString:bString] scanHexInt:&B];
    
    return [UIColor colorWithRed:((float) R/255.f) green:((float) G/255.f) blue:((float) B/255.f) alpha:alpha];
}

@end
