//
//  FXFormHeaderView.m
//  FXFieldController
//
//  Created by 杨健 on 2020/7/8.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXFormHeaderView.h"
#include <Masonry/Masonry.h>
@interface FXFormHeaderView ()
@property(nonatomic,strong)UIButton *iconBtn;
@end

@implementation FXFormHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconBtn];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //计算iconBtn的总宽度：图片宽度+文字宽度+空隙的宽度
    CGFloat nameWidth = [self widthWithFont:self.textFont constrainedToHeight:self.iconBtnImageHeight text:self.model.name] + self.iconBtnImageWidth + 2 * 5;
    
    [self.iconBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(nameWidth);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(self.iconBtnImageHeight);
    }];
}

-(void)setModel:(FXFormModel *)model{
    _model = model;
    UIImage *iconImage = model.icon.length ? [UIImage imageNamed:model.icon] : nil;
    [self.iconBtn setImage:iconImage forState:UIControlStateNormal];
    [self.iconBtn setTitle:model.name forState:UIControlStateNormal];
}

-(UIColor *)textClor{
    return [UIColor colorWithRed:123.0/255.0 green:131.0/255.0 blue:135.0/255.0 alpha:1.0];
}

-(UIFont *)textFont{
    return [UIFont systemFontOfSize:15.0f];
}

-(CGFloat)iconBtnImageWidth{
    return self.iconBtn.currentImage.size.width;
}

-(CGFloat)iconBtnImageHeight{
    return self.iconBtn.currentImage.size.height;
}

-(CGFloat)cellMargin{
    return 15.0f;
}


-(UIButton *)iconBtn{
    if (_iconBtn == nil) {
        _iconBtn = [[UIButton alloc]init];
        _iconBtn.titleLabel.font = self.textFont;
        _iconBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        _iconBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_iconBtn setTitleColor:self.textClor forState:UIControlStateNormal];
    }
    return _iconBtn;
}

- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height text:(NSString *)text{
    CGSize size = CGSizeMake(MAXFLOAT, height);
     NSDictionary *attr = @{NSFontAttributeName : font};
     CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
     return rect.size.width;
}


@end

