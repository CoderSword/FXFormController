//
//  FXSwitchViewCell.m
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/15.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXSwitchCell.h"

@interface FXSwitchCell ()
@property(nonatomic,strong)UISwitch *switchView;
@end

@implementation FXSwitchCell

-(UISwitch *)switchView{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc]init];
        [_switchView addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.switchView];
        [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-self.cellMargin);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
    return self;
}

-(void)initWithModel:(FXFormModel *)model parentVC:(FXFormViewController *)parentVC{
    [super initWithModel:model parentVC:parentVC];
    [self.switchView setOn:[self.model.text intValue]];
    [self changeValue:self.switchView];
}

-(void)changeValue:(UISwitch *)switchView{
    self.model.text = [NSString stringWithFormat:@"%d",switchView.on];
}
@end
