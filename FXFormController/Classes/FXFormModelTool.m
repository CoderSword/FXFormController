//
//  ISModelTool.m
//  InvasiveSpecies
//
//  Created by 杨健 on 2020/4/10.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXFormModelTool.h"

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
@end
