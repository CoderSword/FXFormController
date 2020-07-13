//
//  FXBoxItemCell.h
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/16.
//  Copyright © 2020 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXBoxItem.h"
NS_ASSUME_NONNULL_BEGIN

#define kItemHeight 40

@interface FXBoxItemCell : UICollectionViewCell
@property(nonatomic,strong)UIButton *boxButton;
@property(nonatomic,strong)FXBoxItem *boxItem;
@end

NS_ASSUME_NONNULL_END
