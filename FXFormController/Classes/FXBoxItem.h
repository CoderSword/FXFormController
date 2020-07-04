//
//  FXRadioItem.h
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/15.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FXBoxItem : FXBaseModel
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)BOOL selected;
@end

NS_ASSUME_NONNULL_END
