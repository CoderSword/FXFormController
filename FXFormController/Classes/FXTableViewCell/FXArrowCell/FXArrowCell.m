//
//  FXArrowViewCell.m
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/15.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXArrowCell.h"
#import "FXRightButton.h"
#import "BRPickerViewTools.h"

@interface FXArrowCell ()
@property(nonatomic,strong)FXRightButton *arrowButton;
@end

@implementation FXArrowCell

-(FXRightButton *)arrowButton{
    if (_arrowButton == nil) {
        _arrowButton = [FXRightButton buttonWithfont:self.textFont titleColor:self.textClor imageName:@"arrow_right"];
    }
    return _arrowButton;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.arrowButton];
        [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-self.cellMargin);
            make.left.equalTo(self.iconBtn.mas_right).offset(10);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(self.cellHeight - 20);
        }];
    }
    return self;
}

-(void)initWithModel:(FXFormModel *)model parentVC:(FXFormViewController *)parentVC{
    [super initWithModel:model parentVC:parentVC];
    [self.arrowButton setTitle:self.model.text.length ? self.model.text : [self showTitleName] forState:UIControlStateNormal];
    [self.arrowButton setTitleColor:self.model.text.length ? self.textClor :[UIColor lightGrayColor] forState:UIControlStateNormal];
}

-(void)doSomething{
    if ([self.model.name containsString:@"日期"]) {
        [BRPickerViewTools showDateWithTitle:[self showTitleName] handler:^(NSString * _Nonnull selectValue) {
            [self setArrowCellTextWith:selectValue];
        }];
    }else if ([self.model.name containsString:@"区域"]){
        [BRPickerViewTools showAddressWithTitle:[self showTitleName] hander:^(NSString * _Nonnull selectedValue) {
            [self setArrowCellTextWith:selectedValue];
        }];
    }else if ([self.model.name containsString:@"收入"]){
        [BRPickerViewTools showStringWithTitle:[self showTitleName] dataSourceArr:self.model.texts handler:^(BRResultModel * _Nonnull resultModel) {
            [self setArrowCellTextWith:resultModel.value];
        }];
    }
}

-(void)setArrowCellTextWith:(NSString *)text{
    [self.arrowButton setTitle:text forState:UIControlStateNormal];
    [self.arrowButton setTitleColor:self.textClor forState:UIControlStateNormal];
    self.model.text = text;
}

-(NSString *)showTitleName{
    return [NSString stringWithFormat:@"请选择%@",self.model.name];
}

@end
