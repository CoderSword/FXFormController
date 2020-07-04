//
//  FXRadioBoxCell.m
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/16.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXRadioBoxCell.h"
#import "FXBoxItem.h"
@interface FXRadioBoxCell ()
@property(nonatomic,strong)FXBoxItem *tempRadioItem;
@end

@implementation FXRadioBoxCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.tempRadioItem = [[FXBoxItem alloc]init];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-self.cellMargin);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(self.cellHeight);
        }];
    }
    return self;
}

-(void)initWithModel:(FXFormModel *)model parentVC:(FXFormViewController *)parentVC{
    [super initWithModel:model parentVC:parentVC];
    for (FXBoxItem *item in self.model.items) {
        if (item.selected) {
            self.tempRadioItem = item;
            self.model.text = item.name;
        }
    }
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([self getCollectionViewWidth]);
    }];
    [self.collectionView reloadData];
}

#pragma mark --获取FXRadioBoxCollectionView的宽度
-(CGFloat)getCollectionViewWidth{
    CGFloat interitemSpacings = (self.model.items.count - 1) * self.layout.minimumInteritemSpacing;
    CGFloat totalItemWidth = 0.1;
    for (FXBoxItem *item in self.model.items) {
        totalItemWidth += item.width;
    }
    return interitemSpacings + totalItemWidth;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FXBoxItem *selectedItem = self.model.items[indexPath.item];
    if (selectedItem.selected) {
        return;
    }
    self.tempRadioItem.selected = NO;
    selectedItem.selected = !selectedItem.selected;
    self.model.text = selectedItem.name;
    self.tempRadioItem = selectedItem;
    [self.collectionView reloadData];
}

@end
