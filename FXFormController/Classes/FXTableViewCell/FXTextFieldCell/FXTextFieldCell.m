//
//  FXTextFieldViewCell.m
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/15.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXTextFieldCell.h"
#import "FXIDCardKeyboardView.h"

@interface FXTextFieldCell ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)FXIDCardKeyboardView *idCardView;
@end

@implementation FXTextFieldCell


-(UITextField *)textField{
    if (_textField == nil) {
        _textField = [[UITextField alloc]init];
        _textField.delegate = self;
        _textField.font = self.textFont;
        _textField.textColor = self.textClor;
        _textField.textAlignment = NSTextAlignmentRight;
    }
    return _textField;
}

-(FXIDCardKeyboardView *)idCardView{
    if (_idCardView == nil) {
        _idCardView = [[FXIDCardKeyboardView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 225)];
        [_idCardView setValue:self.textField forKeyPath:@"_currentTextField"];
    }
    return _idCardView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-self.cellMargin);
            make.left.equalTo(self.iconBtn.mas_right).offset(10);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(self.cellHeight - 20);
        }];
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.inputView = [self.model.name containsString:@"身份证"] ? self.idCardView : nil;
}

-(void)initWithModel:(FXFormModel *)model parentVC:(FXFormViewController *)parentVC{
    [super initWithModel:model parentVC:parentVC];
    self.textField.keyboardType = model.keyBordType ? model.keyBordType : UIKeyboardTypeDefault;
    self.textField.placeholder = [NSString stringWithFormat:@"请输入%@",self.model.name];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.model.text = textField.text;
}


@end
