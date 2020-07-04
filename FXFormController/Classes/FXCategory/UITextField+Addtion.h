//
//  UITextField+Addtion.h
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/7/1.
//  Copyright © 2020 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Addtion)
-(NSRange) selectedRange;
-(void) setSelectedRange:(NSRange) range;
-(void)setCursorLocation:(NSInteger)location;
@end

NS_ASSUME_NONNULL_END
