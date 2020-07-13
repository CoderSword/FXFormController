//
//  FXMediaItemCell.m
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/18.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXMediaItemCell.h"
#import <Sdwebimage/UIImageView+WebCache.h>
@interface FXMediaItemCell ()
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation FXMediaItemCell

-(UIButton *)deletedBtn{
    if (_deletedBtn == nil) {
        _deletedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deletedBtn.bounds = CGRectMake(0, 0, 20, 20);
        [_deletedBtn addTarget:self action:@selector(deletedAction) forControlEvents:UIControlEventTouchUpInside];
        [_deletedBtn setBackgroundImage:[UIImage imageNamed:@"del"] forState:UIControlStateNormal];
    }
    return _deletedBtn;
}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.deletedBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, self.bounds.size.width - 5, self.bounds.size.height);
    self.deletedBtn.frame = CGRectMake(self.bounds.size.width - self.deletedBtn.bounds.size.width, - 5, self.deletedBtn.bounds.size.width, self.deletedBtn.bounds.size.height);
}

-(void)setMedia:(FXMediaItem *)media{
    _media = media;
    self.imageView.contentMode = media.isAddImage ? UIViewContentModeScaleToFill : UIViewContentModeScaleAspectFill;
    self.imageView.layer.masksToBounds = !media.isAddImage;
    if (media.imageData) {
        self.imageView.image = [UIImage imageWithData:media.imageData];
    }else if (media.url){
        [self setImageViewContentModel];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:media.url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    self.deletedBtn.hidden = !media.isEdit;
}

-(void)setImageViewContentModel{
    
}

-(void)deletedAction{
    if ([self.delegate respondsToSelector:@selector(mediaItemCellDeleted:)]) {
        [self.delegate mediaItemCellDeleted:self];
    }
}


@end
