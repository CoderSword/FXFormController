//
//  FXIDCardKeyboardView.m
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/6/30.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXIDCardKeyboardView.h"
#import "UIImage+Addition.h"
#import "UITextField+Addtion.h"
#import "NSArray+Sudoku.h"
#import "UIColor+Addtion.h"
#define kMargin 5
#define kButtonWidth ([UIScreen mainScreen].bounds.size.width - 4*kMargin) / 3
#define kButtonHeight 50
#define KItemCount 12
@interface FXIDCardKeyboardView ()
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSMutableString *inputstr;
@property(nonatomic,strong)UIImage *clearImage;
@end

@implementation FXIDCardKeyboardView

-(UIImage *)clearImage{
    if (_clearImage == nil) {
        _clearImage = [UIImage imageWithColor:[UIColor clearColor]];
    }
    return _clearImage;
}

-(NSArray *)titles{
    return @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"X",@"0",@"delete"];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"D3D7DD"];
        self.inputstr = [NSMutableString string];
        [self setUIConfig];
    }
    return self;
}

-(void)setUIConfig{
    for (int index = 0; index < KItemCount; index ++) {
        UIButton *button = [self createKeyBoardButton];
        if (index == KItemCount -1) {
            [button setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
            [button setBackgroundImage:self.clearImage forState:UIControlStateNormal];
            [button setBackgroundImage:self.clearImage forState:UIControlStateHighlighted];
        }else{
           [button setTitle:self.titles[index] forState:UIControlStateNormal];
        }
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    [self.subviews mas_distributeSudokuViewsWithFixedItemWidth:kButtonWidth fixedItemHeight:kButtonHeight warpCount:3 topSpacing:kMargin bottomSpacing:kMargin leadSpacing:kMargin tailSpacing:kMargin];
}

-(UIButton *)createKeyBoardButton{
    UIButton *keyboardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    keyboardBtn.titleLabel.font = [UIFont systemFontOfSize:25];
    [keyboardBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [keyboardBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] ] forState:UIControlStateNormal];
    [keyboardBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"BAC8D4"]] forState:UIControlStateHighlighted];
    keyboardBtn.layer.cornerRadius = 5.0f;
    keyboardBtn.layer.masksToBounds = YES;
    return keyboardBtn;
}

-(void)buttonClick:(UIButton *)button{
    NSRange currentRange = self.currentTextField.selectedRange;
    if (button.currentImage) {
        if (self.inputstr.length) {
            [self.inputstr deleteCharactersInRange:NSMakeRange(currentRange.location - 1, 1)];
            [self.currentTextField deleteBackward];
        }
    }else{
        [self.inputstr insertString:button.currentTitle atIndex:currentRange.location];
        self.currentTextField.text = self.inputstr;
        [self.currentTextField setCursorLocation:currentRange.location + 1];
    }
}

//CGFloat itemX = kMargin +(kItemWidth + kMargin) * (index % 3);
//CGFloat itemY = kMargin +(kItemHeight + kMargin) * (index / 3);
//[button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//button.frame = CGRectMake(itemX,itemY, kItemWidth, kItemHeight);

@end
