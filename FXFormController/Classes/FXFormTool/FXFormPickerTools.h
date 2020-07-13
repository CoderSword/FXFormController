//
//  BRPickerViewTools.h
//  Enterprise
//
//  Created by 杨健 on 2019/12/6.
//  Copyright © 2019 com.sofn.lky.enterprise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BRPickerView/BRPickerView.h>
NS_ASSUME_NONNULL_BEGIN

@interface FXFormPickerTools : NSObject

+(void)showStringWithTitle:(NSString *)title dataSourceArr:(NSArray *)subtitles handler:(void (^)(BRResultModel *resultModel))handler;

+(void)showAddressWithTitle:(NSString *)title hander:(void(^)(NSString *selectedValue))handler;
+(void)showDateWithTitle:(NSString *)title handler:(void (^)(NSString *selectedValue))handler;
@end


NS_ASSUME_NONNULL_END
