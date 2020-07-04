//
//  FXBaseCollectionCell.m
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/19.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXBaseCollectionCell.h"

@implementation FXBaseCollectionCell

-(UICollectionViewLeftAlignedLayout *)layout{
    if (_layout == nil) {
        _layout = [[UICollectionViewLeftAlignedLayout alloc] init];
        _layout.minimumLineSpacing = 9;
        _layout.minimumInteritemSpacing = 9;
        _layout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
    }
    return _layout;
}

-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return [[UICollectionViewCell alloc]init];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    return self.model.items.count;
}

@end
