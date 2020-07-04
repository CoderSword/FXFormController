//
//  SGRightButton.m
//  ChongZhouPrint
//
//  Created by 杨健 on 2020/3/10.
//  Copyright © 2020 com.sofn.lky. All rights reserved.
//

#import "FXRightButton.h"

#define kImageToTitleMargin 5

@interface FXRightButton ()
@end

@implementation FXRightButton

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(self.bounds.size.width - self.imageView.bounds.size.width - kImageToTitleMargin - self.titleLabel.bounds.size.width, self.titleLabel.frame.origin.y, self.titleLabel.bounds.size.width, self.titleLabel.bounds.size.height);
    self.imageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame), self.titleLabel.frame.origin.y + 2, self.imageView.bounds.size.width, self.imageView.bounds.size.height);
}

+(instancetype)buttonWithfont:(UIFont *)font titleColor:(UIColor *)color imageName:(NSString *)imageName{
    
    FXRightButton *button = [FXRightButton buttonWithType:UIButtonTypeCustom];
    button.userInteractionEnabled = NO;
    button.titleLabel.font = font;
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return button;
}

@end
