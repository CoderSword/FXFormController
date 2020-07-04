//
//  FXLabelViewCell.m
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/15.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXLabelCell.h"

@interface FXLabelCell ()
@property(nonatomic,strong)UILabel *label;
@end

@implementation FXLabelCell

-(UILabel *)label{
    if (_label == nil) {
        _label = [[UILabel alloc]init];
        _label.font = self.textFont;
        _label.textColor = self.textClor;
        _label.textAlignment = NSTextAlignmentRight;
    }
    return _label;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-self.cellMargin);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(self.cellHeight - 20);
        }];
    }
    return self;
}

-(void)initWithModel:(FXFormModel *)model parentVC:(FXFormViewController *)parentVC{
    [super initWithModel:model parentVC:parentVC];
    self.label.text = self.model.text;
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconBtn.mas_right).offset(10);
    }];
}

@end
