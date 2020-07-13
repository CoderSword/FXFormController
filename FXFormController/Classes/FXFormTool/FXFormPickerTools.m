//
//  BRPickerViewTools.m
//  Enterprise
//
//  Created by 杨健 on 2019/12/6.
//  Copyright © 2019 com.sofn.lky.enterprise. All rights reserved.
//

#import "FXFormPickerTools.h"

@implementation FXFormPickerTools

+(void )showStringWithTitle:(NSString *)title dataSourceArr:(NSArray *)subtitles handler:(void (^)(BRResultModel *resultModel))handler{
    BRStringPickerView *stringPickerView = [[BRStringPickerView alloc]initWithPickerMode:BRStringPickerComponentSingle];
    stringPickerView.title = title;
    stringPickerView.dataSourceArr = subtitles;
    stringPickerView.selectIndex = 0;
    stringPickerView.resultModelBlock = ^(BRResultModel *resultModel) {
        handler(resultModel);
    };
    [stringPickerView show];
}

+(void)showAddressWithTitle:(NSString *)title hander:(void (^)(NSString * _Nonnull))handler{
    
    BRAddressPickerView *addressPickerView = [[BRAddressPickerView alloc]initWithPickerMode:BRAddressPickerModeArea];
    addressPickerView.resultBlock = ^(BRProvinceModel * _Nullable province, BRCityModel * _Nullable city, BRAreaModel * _Nullable area) {
        NSString *selectedValue = [NSString stringWithFormat:@"%@%@%@",province.name,city.name,area.name];
        handler(selectedValue);
    };
    [addressPickerView show];
}

+(void )showDateWithTitle:(NSString *)title handler:(void (^)(NSString *selectedValue))handler{
    BRDatePickerView *datePickerView = [[BRDatePickerView alloc]initWithPickerMode:BRDatePickerModeYMD];
    datePickerView.title = title;
    datePickerView.minDate = [NSDate br_setYear:1949 month:3 day:12];
    
     NSDate *  date=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy"];
    NSString *thisYearString=[dateformatter stringFromDate:date];
    NSInteger theyear = [thisYearString integerValue] + 5;
    
    [dateformatter setDateFormat:@"MM"];
    NSInteger currentMonth=[[dateformatter stringFromDate:date]integerValue];
    [dateformatter setDateFormat:@"dd"];
    NSInteger currentDay=[[dateformatter stringFromDate:date] integerValue];
    
   datePickerView.maxDate = [NSDate br_setYear:theyear month:currentMonth day:currentDay];
    
    datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
        handler(selectValue);
    };
    [datePickerView show];
}


@end
