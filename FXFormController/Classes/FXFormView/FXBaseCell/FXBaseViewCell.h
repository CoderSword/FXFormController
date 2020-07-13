//
//  FXBaseTableViewCell.h
//  WaterPollution
//
//  Created by 杨健 on 2020/5/14.
//  Copyright © 2020 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "FXFormModel.h"
#import "FXFormViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface FXBaseViewCell : UITableViewCell
@property(nonatomic,strong)UIButton *iconBtn;
@property(nonatomic,strong)FXFormModel *model;
@property(nonatomic,assign)CGFloat iconBtnImageWidth;
@property(nonatomic,assign)CGFloat iconBtnImageHeight;
@property(nonatomic,assign)CGFloat cellMargin;
@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,strong)UIColor *textClor;
@property(nonatomic,strong)UIFont *textFont;
@property(nonatomic,strong)FXFormViewController *parentVC;

-(void)initWithModel:(FXFormModel *)model parentVC:(FXFormViewController *)parentVC;
-(void)doSomething;
@end

NS_ASSUME_NONNULL_END
