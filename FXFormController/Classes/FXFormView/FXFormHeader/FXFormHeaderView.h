//
//  FXFormHeaderView.h
//  FXFieldController
//
//  Created by 杨健 on 2020/7/8.
//  Copyright © 2020 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXFormModel.h"
NS_ASSUME_NONNULL_BEGIN

static NSString *const FXFormHeaderViewID = @"FXFormHeaderView";

@interface FXFormHeaderView : UITableViewHeaderFooterView
@property(nonatomic,strong)UIColor *textClor;
@property(nonatomic,strong)UIFont *textFont;
@property (nonatomic,strong)FXFormModel *model;
@property(nonatomic,assign)CGFloat iconBtnImageWidth;
@property(nonatomic,assign)CGFloat iconBtnImageHeight;
@property(nonatomic,assign)CGFloat cellMargin;
@end

NS_ASSUME_NONNULL_END
