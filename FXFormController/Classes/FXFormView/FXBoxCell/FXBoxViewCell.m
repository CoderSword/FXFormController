//
//  FXBoxCell.m
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/16.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXBoxViewCell.h"
static NSString *const FXBoxItemCellID = @"FXBoxItemCell";

@interface FXBoxViewCell ()

@end

@implementation FXBoxViewCell

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    FXBoxItem *item = self.model.items[indexPath.item];
    return CGSizeMake(item.width, kItemHeight);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FXBoxItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FXBoxItemCellID forIndexPath:indexPath];
    cell.boxItem = self.model.items[indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.items.count;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.collectionView registerClass:[FXBoxItemCell class] forCellWithReuseIdentifier:FXBoxItemCellID];
        self.collectionView.userInteractionEnabled = !self.model.showInfo;
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}

-(void)initWithModel:(FXFormModel *)model parentVC:(FXFormViewController *)parentVC{
    [super initWithModel:model parentVC:parentVC];
    for (FXBoxItem *item in self.model.items) {
        if (!item.width) {
            item.width = [UIImage imageNamed:item.icon].size.width + [self widthWithFont:self.textFont constrainedToHeight:kItemHeight text:item.name];
        }
    }
}

- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height text:(NSString *)text{
    CGSize size = CGSizeMake(MAXFLOAT, height);
     NSDictionary *attr = @{NSFontAttributeName : font};
     CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
     return rect.size.width;
}


@end
