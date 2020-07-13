//
//  FXFormHeaderModel.h
//  FXFieldController
//
//  Created by 杨健 on 2020/7/8.
//  Copyright © 2020 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXFormModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FXFormHeaderModel : NSObject
@property (nonatomic,strong)FXFormModel *header;
@property (nonatomic,strong)NSArray *content;
@end

NS_ASSUME_NONNULL_END
