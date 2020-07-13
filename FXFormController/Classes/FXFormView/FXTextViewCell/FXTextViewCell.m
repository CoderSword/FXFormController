//
//  FXTextViewCell.m
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/15.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXTextViewCell.h"

#define kInputMaxNum 200

@interface FXTextViewCell ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UILabel *placeHolderLabel;
@property(nonatomic,strong)UILabel *textNumLabel;
@end

@implementation FXTextViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.placeHolderLabel];
        [self.contentView addSubview:self.textNumLabel];
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.cellMargin);
            make.right.mas_equalTo(-self.cellMargin);
            make.top.equalTo(self.iconBtn.mas_bottom).offset(10);
            make.bottom.mas_equalTo(-self.cellMargin);
        }];
        
        [self.placeHolderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.textView.mas_left).offset(5);
            make.top.equalTo(self.textView.mas_top).offset(7);
        }];
        
        [self.textNumLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.textView.mas_left);
            make.right.equalTo(self.textView.mas_right);
            make.top.equalTo(self.textView.mas_bottom);
            make.height.mas_equalTo(self.cellMargin);
        }];
    }
    return self;
}


-(void)initWithModel:(FXFormModel *)model parentVC:(FXFormViewController *)parentVC{
    [super initWithModel:model parentVC:parentVC];
    self.placeHolderLabel.text = [NSString stringWithFormat:@"请输入%@",model.name];
    self.textView.userInteractionEnabled = !self.model.showInfo;
    self.textView.text = self.model.text;
}

- (void)textViewDidChange:(UITextView *)textView{
    self.placeHolderLabel.hidden = textView.text.length;
    NSInteger length = textView.text.length;
    if (length >= kInputMaxNum) {
        textView.text = [textView.text substringWithRange:NSMakeRange(0, kInputMaxNum)];;
        self.textNumLabel.text = [NSString stringWithFormat:@"%d/%d",kInputMaxNum,kInputMaxNum];
    }else{
        [self.textNumLabel setText:[NSString stringWithFormat:@"%ld/%d",(long)length,kInputMaxNum]];
    }
    self.model.text = textView.text;
}


-(void)textViewDidEndEditing:(UITextView *)textView{
    self.parentVC.uploadDict[self.model.key] = textView.text;
}



-(UILabel *)placeHolderLabel{
    if (_placeHolderLabel == nil) {
        _placeHolderLabel = [[UILabel alloc]init];
        _placeHolderLabel.font = self.textFont;
        _placeHolderLabel.textColor = [UIColor lightGrayColor];
    }
    return _placeHolderLabel;
}

-(UILabel *)textNumLabel{
    if (_textNumLabel == nil) {
        _textNumLabel = [[UILabel alloc]init];
        _textNumLabel.font = self.textFont;
        _textNumLabel.textAlignment = NSTextAlignmentRight;
        _textNumLabel.text = [NSString stringWithFormat:@"0/%d",kInputMaxNum];
        _textNumLabel.textColor = [UIColor lightGrayColor];
        _textNumLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _textNumLabel;
}

-(UITextView *)textView{
    if (_textView == nil) {
        _textView = [[UITextView alloc]init];
        _textView.font = self.textFont;
        _textView.textColor = self.textClor;
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _textView;
}

@end

