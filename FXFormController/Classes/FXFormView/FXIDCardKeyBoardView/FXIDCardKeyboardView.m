//
//  FXIDCardKeyboardView.m
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/6/30.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXIDCardKeyboardView.h"

#define kMargin 5
#define kTotalRows 4
#define kTotalCols 3
#define kButtonWidth ([UIScreen mainScreen].bounds.size.width - (kTotalCols + 1)*kMargin) / kTotalCols
#define kButtonHeight 50
@interface FXIDCardKeyboardView ()
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSMutableString *inputstr;
@property(nonatomic,strong)UIImage *clearImage;
@property(nonatomic,assign)NSInteger maxY;
@end

@implementation FXIDCardKeyboardView

-(UIImage *)clearImage{
    if (_clearImage == nil) {
        _clearImage = [self imageWithColor:[UIColor clearColor]];
    }
    return _clearImage;
}

-(NSArray *)titles{
    return @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"X",@"0",@"deleted"];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:211.0/255.0 green:215.0/255.0 blue:221.0/255.0 alpha:1.0];
        self.inputstr = [NSMutableString string];
        [self setUIConfig];
    }
    return self;
}

-(void)setUIConfig{
    NSInteger count = self.titles.count;
    for (int index = 0; index < count; index ++) {
        UIButton *button = [self createKeyBoardButton];
        
        NSInteger currentRow = index / kTotalCols;
        NSInteger currentCol = index % kTotalCols;
        CGFloat buttonX = kMargin + (kButtonWidth + kMargin) * currentCol;
        CGFloat buttonY = kMargin + (kButtonHeight + kMargin) * currentRow;
        button.frame = CGRectMake(buttonX, buttonY, kButtonWidth, kButtonHeight);
        if (index == self.titles.count -1) {
            [button setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
            [button setBackgroundImage:self.clearImage forState:UIControlStateNormal];
            [button setBackgroundImage:self.clearImage forState:UIControlStateHighlighted];
            self.maxY = CGRectGetMaxY(button.frame);
        }else{
            [button setTitle:self.titles[index] forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}


-(UIButton *)createKeyBoardButton{
    UIButton *keyboardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    keyboardBtn.titleLabel.font = [UIFont systemFontOfSize:25];
    [keyboardBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [keyboardBtn setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [keyboardBtn setBackgroundImage:[self imageWithColor:self.backgroundColor] forState:UIControlStateHighlighted];
    keyboardBtn.layer.cornerRadius = 5.0f;
    keyboardBtn.layer.masksToBounds = YES;
    return keyboardBtn;
}

-(void)buttonClick:(UIButton *)button{
    NSRange currentRange = [self selectedRange:self.currentTextField];
    if (button.currentImage) {
        if (self.inputstr.length) {
            [self.inputstr deleteCharactersInRange:NSMakeRange(currentRange.location - 1, 1)];
            [self.currentTextField deleteBackward];
        }
    }else{
        [self.inputstr insertString:button.currentTitle atIndex:currentRange.location];
        self.currentTextField.text = self.inputstr;
        [self setCursorLocation:currentRange.location + 1 :self.currentTextField];
    }
}


- (NSRange)selectedRange:(UITextField *)textField{
    UITextPosition* beginning = textField.beginningOfDocument;
    UITextRange* selectedRange = textField.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    const NSInteger location = [textField offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [textField offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}


- (void) setSelectedRange:(NSRange)range :(UITextField *)textField{
    UITextPosition* beginning = textField.beginningOfDocument;
    UITextPosition* startPosition = [textField positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [textField positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [textField textRangeFromPosition:startPosition toPosition:endPosition];
    [textField setSelectedTextRange:selectionRange];
}


-(void)setCursorLocation:(NSInteger)location :(UITextField *)textField{
    NSRange range = NSMakeRange(location, 0);
    UITextPosition *beginning = textField.beginningOfDocument;
    UITextPosition *start = [textField positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [textField positionFromPosition:start offset:range.length];
    [textField setSelectedTextRange:[textField textRangeFromPosition:start toPosition:end]];
}


- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
