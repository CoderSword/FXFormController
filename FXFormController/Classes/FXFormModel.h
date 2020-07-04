//
//  FXFormModel.h
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/15.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FXCellType) {
    FXCellTypeTextField = 0,                         // no button type
    FXCellTypeArrow,
    FXCellTypeLabel,
    FXCellTypeSwitch,
    FXCellTypeTextView,
    FXCellTypeRadioBox,
    FXCellTypeCheckBox,
    FXCellTypeMeida
};

@interface FXFormModel : FXBaseModel
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)FXCellType cellType;
@property(nonatomic,copy)NSString *key;
@property(nonatomic,copy)NSString *cellID;
@property(nonatomic,copy)NSString *text; //最终的输入选择的数据
@property(nonatomic,assign)NSInteger keyBordType;
@property(nonatomic,strong)NSArray *texts;          //里面存放的是文本数组
@property(nonatomic,strong)NSArray *items;          //里面存放的是FXBoxItem对象
@property(nonatomic,strong)NSMutableArray *medias;  //里面存放的是媒体数据(图片视频之类)
@property(nonatomic,assign)BOOL showInfo;
@property(nonatomic,assign)BOOL isEdit;
@property(nonatomic,assign)NSInteger speciestype; // 物种类型1代表外来入侵物种  2代表伴生物种
@property(nonatomic,assign)NSInteger firstModel;  //外来入侵物种 和 伴生物种 需要分组 遇到第一个分
@property(nonatomic,assign)BOOL mustFill;
@property(nonatomic,assign)CGFloat height;
@end

NS_ASSUME_NONNULL_END
