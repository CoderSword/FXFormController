//
//  UITextField+Addtion.m
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/7/1.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "UITextField+Addtion.h"

@implementation UITextField (Addtion)

- (NSRange) selectedRange{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}


- (void) setSelectedRange:(NSRange) range{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}


-(void)setCursorLocation:(NSInteger)location{
    NSRange range = NSMakeRange(location, 0);
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *start = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [self positionFromPosition:start offset:range.length];
    [self setSelectedTextRange:[self textRangeFromPosition:start toPosition:end]];
}

@end
