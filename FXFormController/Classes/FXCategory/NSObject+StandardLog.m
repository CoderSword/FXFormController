#ifdef DEBUG

#import "NSObject+StandardLog.h"
#import <objc/runtime.h>

@implementation NSObject (StandardLog)

/**
 将对象转化成json字符串
 */
-(NSString *)convertToJsonString{
    
    //判断能不能转化 不能转化返回nil
    if (![NSJSONSerialization isValidJSONObject:self]) {
        return nil;
    }
    NSError *error = nil;
    
    //NSJSONWritingOptions的值有两种情况
    //NSJSONWritingPrettyPrinted是将生成的json数据格式化输出
    //NSJSONWritingSortedKeys是将生成的json数据不尽兴格式化输出 在一行上显示
    
    NSJSONWritingOptions jsonOptions = NSJSONWritingPrettyPrinted;
    if (@available(iOS 11.0, *)) {
        //11.0之后，可以将JSON按照key排列后输出，看起来会更舒服
        jsonOptions = NSJSONWritingPrettyPrinted | NSJSONWritingSortedKeys;
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    
    if (error || !jsonData) {
        return nil;
    }
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}


@end



/**
 方法交换
 */
static inline void lgj_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL addMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (addMethod) {
        class_replaceMethod(class, swizzledSelector,method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}



@implementation NSDictionary (LGJStandardLog)

/**
 改方法是在代码控制打印的时候调用
 */
-(NSString *)standardlog_descriptionWithLocale:(id)locale{
    
    NSString *result = [self convertToJsonString];
    if (!result) {
        
        //在此有些同学会一脸懵逼 这不是在掉自己么 呵呵呵呵。。。。。。因为在load方法执行的z时候已经执行了方法的交换 此时调用standardlog_descriptionWithLocale方法相当于调用系统的descriptionWithLocale
        result = [self standardlog_descriptionWithLocale:locale];
        return result;
    }
    return  result;
}

/**
 改方法是在代码控制打印的时候调用
 */
-(NSString *)standardlog_descriptionWithLocale:(id)locale indent:(NSUInteger)level{
    
    NSString *result = [self convertToJsonString];
    if (!result) {
        result = [self standardlog_descriptionWithLocale:locale indent:level];
        return result;
    }
    return  result;
    
}

/**
 改方法是在控制太po命令打印的时候调用
 */
-(NSString *)standardlog_debugDescription{
    
    NSString *result = [self convertToJsonString];
    if (!result) {
        result = [self standardlog_debugDescription];
        return result;
    }
    return  result;
    
}


/**
 方法交换的实现
 */
+(void)load{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        lgj_swizzleSelector(class, @selector(debugDescription), @selector(standardlog_debugDescription));
        lgj_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(standardlog_descriptionWithLocale:indent:));
        lgj_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(standardlog_descriptionWithLocale:));
    });
}

@end


@implementation NSArray (LGJStandardLog)

-(NSString *)standardlog_descriptionWithLocale:(id)locale{
    
    NSString *result = [self convertToJsonString];
    if (!result) {
        result = [self standardlog_descriptionWithLocale:locale];
        return result;
    }
    return  result;
}

-(NSString *)standardlog_descriptionWithLocale:(id)locale indent:(NSUInteger)level{
    
    NSString *result = [self convertToJsonString];
    if (!result) {
        result = [self standardlog_descriptionWithLocale:locale indent:level];
        return result;
    }
    return  result;
}

-(NSString *)standardlog_debugDescription{
    
    NSString *result = [self convertToJsonString];
    if (!result) {
        result = [self standardlog_debugDescription];
        return result;
    }
    return  result;
}

/**
 方法交换的实现
 */
+(void)load{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        lgj_swizzleSelector(class, @selector(debugDescription), @selector(standardlog_debugDescription));
        lgj_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(standardlog_descriptionWithLocale:indent:));
        lgj_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(standardlog_descriptionWithLocale:));
    });
}
@end


#endif
