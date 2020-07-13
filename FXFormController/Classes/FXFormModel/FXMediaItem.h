//
//  FXMediaItem.h
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/18.
//  Copyright © 2020 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FXMediaItem : NSObject
@property (nonatomic,copy)NSString *url;
@property (nonatomic,copy)NSString *fileName;
@property (nonatomic,assign)BOOL isEdit;
@property(nonatomic,strong)NSData *imageData;
@property (nonatomic,assign)BOOL isAddImage;
@end

NS_ASSUME_NONNULL_END
