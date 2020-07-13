//
//  FXBoxItemCell.m
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/16.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXBoxItemCell.h"
@implementation FXBoxItemCell

-(UIButton *)boxButton{
    if (_boxButton == nil) {
        _boxButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _boxButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _boxButton.userInteractionEnabled = NO;
        [_boxButton setTitleColor:[UIColor colorWithRed:123.0/255.0 green:131.0/255.0 blue:135.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
    return _boxButton;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.boxButton];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.boxButton.frame = self.bounds;
}


- (void)setBoxItem:(FXBoxItem *)boxItem{
    _boxItem = boxItem;
    
    self.boxButton.selected = boxItem.selected;
    [self.boxButton setImage:[UIImage imageNamed:boxItem.icon] forState:UIControlStateNormal];
    [self.boxButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-sel",boxItem.icon]] forState:UIControlStateSelected];
    [self.boxButton setTitle:boxItem.name forState:UIControlStateNormal];
}


@end
