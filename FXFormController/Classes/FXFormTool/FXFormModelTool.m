//
//  ISModelTool.m
//  InvasiveSpecies
//
//  Created by 杨健 on 2020/4/10.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXFormModelTool.h"
#import "FXFormHeaderModel.h"
#import <MJExtension/MJExtension.h>

@implementation FXFormModelTool

+(void)handeModelCellType:(FXFormModel *)model{
    
    switch (model.cellType) {
        case FXCellTypeArrow:
            model.cellID = FXArrowCellID;
        break;
        case FXCellTypeLabel:
            model.cellID = FXLabelCellID;
        break;
        case FXCellTypeSwitch:
            model.cellID = FXSwitchCellID;
        break;
        case FXCellTypeTextView:
            model.cellID = FXTextViewCellID;
        break;
        case FXCellTypeRadioBox:
            model.cellID = FXRadioBoxCellID;
        break;
        case FXCellTypeCheckBox:
            model.cellID = FXCheckBoxCellID;
        break;
        case FXCellTypeMeida:
            model.cellID = FXMediaViewCellID;
        break;
        default:
            model.cellID = FXTextFieldCellID;
            break;
    }
}

+(NSArray *)getFieldModelsWithFileName:(NSString *)fileName{
    BOOL isPlistFile = [fileName containsString:@"plist"];
    BOOL isJsonFile = [fileName containsString:@"json"];
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    if (isPlistFile) {
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        return [self getModelsWithDatas:arr];
    }else if (isJsonFile){
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        return [self getModelsWithDatas:arr];
    }else{
        NSAssert((isPlistFile || isJsonFile) ,@"fileName必须是plist或者json文件");
    }
    return nil;
}


+(NSArray *)getModelsWithDatas:(NSArray *)arr{
    NSDictionary *dict = arr.firstObject;
    if ([dict.allKeys containsObject:@"header"]) {
        NSArray *datas = [FXFormHeaderModel mj_objectArrayWithKeyValuesArray:arr];
        for (FXFormHeaderModel *header in datas) {
            [self handeModelCellTypeWithModels:header.content];
        }
        return datas;
    }else{
        NSArray *modes = [FXFormModel mj_objectArrayWithKeyValuesArray:arr];
        [self handeModelCellTypeWithModels:modes];
        return modes;
    }
}

+(void)handeModelCellTypeWithModels:(NSArray *)models{
    for (FXFormModel *model in models) {
        [FXFormModelTool handeModelCellType:model];
    }
}

@end
