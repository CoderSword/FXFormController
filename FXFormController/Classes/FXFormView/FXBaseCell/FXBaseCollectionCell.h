//
//  FXBaseCollectionCell.h
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/19.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXBaseViewCell.h"
#import "UICollectionViewLeftAlignedLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface FXBaseCollectionCell : FXBaseViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UICollectionViewLeftAlignedLayout *layout;
@end

NS_ASSUME_NONNULL_END
