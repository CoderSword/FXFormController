//
//  FXFiledModel.h
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/15.
//  Copyright © 2020 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
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

@interface FXFormModel : NSObject
@property(nonatomic,copy)NSString *icon;             //左边的图片名称
@property(nonatomic,copy)NSString *name;             //左边的名称
@property(nonatomic,assign)FXCellType cellType;      //每行模型对应的cell样式
@property(nonatomic,copy)NSString *key;              //上传到服务器的key
@property(nonatomic,copy)NSString *cellID;           //每个模型对应的cellID
@property(nonatomic,copy)NSString *text;             //最终的输入选择的数据
@property(nonatomic,assign)NSInteger keyBordType;    //输入框对应的键盘样式
@property(nonatomic,strong)NSArray *texts;           //里面存放的是文本数组
@property(nonatomic,strong)NSArray *items;           //里面存放的是FXBoxItem对象
@property(nonatomic,strong)NSMutableArray *medias;   //里面存放的是媒体数据(图片视频之类)
@property(nonatomic,assign)BOOL showInfo;            //是否是显示详情数据
@property(nonatomic,assign)BOOL mustFill;            //模型所在这一行的cell数据是否是必填
@property(nonatomic,assign)CGFloat height;           //模型所在这一行的cell高度
@end

NS_ASSUME_NONNULL_END
