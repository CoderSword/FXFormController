//
//  FXBaseViewController.h
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/15.
//  Copyright © 2020 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXFormModelTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface FXFormViewController : UIViewController
@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,strong)NSMutableDictionary *requestDict;
@property(nonatomic,strong)NSMutableDictionary *uploadDict;
@property (nonatomic,strong)UITableView *tableView;

-(void)loadDataWithFileName:(NSString *)fileName;

@property(nonatomic,copy)void(^block)(void);

-(void)checkHaveEmptyField:(void(^)(BOOL result,NSString *message))block;

@end

NS_ASSUME_NONNULL_END
