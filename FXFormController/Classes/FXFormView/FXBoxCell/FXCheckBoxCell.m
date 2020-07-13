//
//  FXCheckBoxCell.m
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/16.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXCheckBoxCell.h"

@interface FXCheckBoxCell ()
@property(nonatomic,strong)NSMutableArray *selectedItemNames;
@end

@implementation FXCheckBoxCell

-(NSMutableArray *)selectedItemNames{
    if (_selectedItemNames == nil) {
        _selectedItemNames = [NSMutableArray array];
    }
    return _selectedItemNames;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.layout.minimumLineSpacing = 2;
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.cellMargin);
            make.right.mas_equalTo(-self.cellMargin);
            make.top.equalTo(self.iconBtn.mas_bottom).offset(0);
        }];
    }
    return self;
}

-(void)initWithModel:(FXFormModel *)model parentVC:(FXFormViewController *)parentVC{
    [super initWithModel:model parentVC:parentVC];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([self getCollectionViewHeight]);
    }];
    [self.collectionView reloadData];
}


#pragma mark --获取FXCheckBoxCollectionView的高度
-(CGFloat)getCollectionViewHeight{
    NSMutableArray *itemWidths = [self.model.items valueForKeyPath:@"width"];
    int row = 1;
    CGFloat width = self.cellMargin * 2 + (itemWidths.count - 1) * self.layout.minimumInteritemSpacing;
    for (NSNumber *number in itemWidths) {
        CGFloat itemWidth = [number floatValue];
        if ((width + itemWidth) > [UIScreen mainScreen].bounds.size.width) {
            row += 1;
            width = itemWidth;
        }else{
            width += itemWidth;
        }
    }
    CGFloat totalHeight = (row - 1) * self.layout.minimumLineSpacing + row * kItemHeight + self.layout.sectionInset.top + self.layout.sectionInset.bottom;
    self.model.height = totalHeight + self.cellHeight * 0.5 + self.iconBtnImageHeight * 0.5 ;
    return totalHeight;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FXBoxItem *selectedItem = self.model.items[indexPath.item];
    selectedItem.selected = !selectedItem.selected;
    [self.collectionView reloadData];
    
    if (selectedItem.selected) {
       [self.selectedItemNames addObject:selectedItem.name];
    }else if ([self.selectedItemNames containsObject:selectedItem.name]){
        [self.selectedItemNames removeObject:selectedItem.name];
    }
    
    self.model.text = [self.selectedItemNames componentsJoinedByString:@","];
}

@end
