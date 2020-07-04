//
//  FXMediaItemCell.h
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/18.
//  Copyright © 2020 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXMediaItem.h"
@class FXMediaItemCell;
NS_ASSUME_NONNULL_BEGIN

@protocol FXMediaItemCellDelegate <NSObject>

-(void)mediaItemCellDeleted:(FXMediaItemCell *_Nullable)itemCell;

@end

@interface FXMediaItemCell : UICollectionViewCell
@property(nonatomic,strong)FXMediaItem *media;
@property (nonatomic,assign)id<FXMediaItemCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
