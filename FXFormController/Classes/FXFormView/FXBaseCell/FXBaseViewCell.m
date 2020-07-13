//
//  FXBaseTableViewCell.m
//  WaterPollution
//
//  Created by 杨健 on 2020/5/14.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXBaseViewCell.h"

#define kTitleMarginToImage 5

@implementation FXBaseViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.iconBtn];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    //计算iconBtn的总宽度：图片宽度+文字宽度+空隙的宽度
    CGFloat nameWidth =  [self widthWithFont:self.textFont constrainedToHeight:self.iconBtnImageHeight text:self.model.name] + self.iconBtnImageWidth + 2 * kTitleMarginToImage;
    [self.iconBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cellMargin);
        make.width.mas_equalTo(nameWidth);
        make.top.mas_equalTo(self.cellHeight * 0.5 - self.iconBtnImageHeight * 0.5);
        make.height.mas_equalTo(self.iconBtnImageHeight);
    }];
}

-(void)initWithModel:(FXFormModel *)model parentVC:(FXFormViewController *)parentVC{
    self.model = model;
    self.parentVC = parentVC;
    
    [self.iconBtn setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
    [self.iconBtn setTitle:model.name forState:UIControlStateNormal];
}

-(void)doSomething{
    
}


-(CGFloat)cellMargin{
    return 15.0f;
}

-(CGFloat)cellHeight{
    return 60.0f;
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

-(UIButton *)iconBtn{
    if (_iconBtn == nil) {
        _iconBtn = [[UIButton alloc]init];
        _iconBtn.titleLabel.font = self.textFont;
        _iconBtn.titleEdgeInsets = UIEdgeInsetsMake(0, kTitleMarginToImage, 0, 0);
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
