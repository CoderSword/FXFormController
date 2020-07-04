//
//  ISModelTool.h
//  InvasiveSpecies
//
//  Created by 杨健 on 2020/4/10.
//  Copyright © 2020 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXFormModel.h"
#import "FXMediaItem.h"
NS_ASSUME_NONNULL_BEGIN


static NSString *const FXTextFieldCellID = @"FXTextFieldCell";
static NSString *const FXArrowCellID = @"FXArrowCell";
static NSString *const FXLabelCellID = @"FXLabelCell";
static NSString *const FXSwitchCellID = @"FXSwitchCell";
static NSString *const FXTextViewCellID = @"FXTextViewCell";
static NSString *const FXRadioBoxCellID = @"FXRadioBoxCell";
static NSString *const FXCheckBoxCellID = @"FXCheckBoxCell";
static NSString *const FXMediaViewCellID = @"FXMediaViewCell";


@interface FXFormModelTool : NSObject

+(void)handeModelCellType:(FXFormModel *)model;


@end


NS_ASSUME_NONNULL_END
