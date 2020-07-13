//
//  FXFiledModel.m
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/15.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXFormModel.h"

@implementation FXFormModel

-(NSMutableArray *)medias{
    if (_medias == nil) {
        _medias = [NSMutableArray array];
    }
    return _medias;
}

+(NSDictionary *)mj_objectClassInArray{
    return @{@"items" : @"FXBoxItem"};
}

@end
