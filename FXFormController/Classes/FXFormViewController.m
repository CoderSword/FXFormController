//
//  FXBaseViewController.m
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/15.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXFormViewController.h"
#import "FXBaseViewCell.h"
#import "FXTextFieldCell.h"
#import "FXArrowCell.h"
#import "FXLabelCell.h"
#import "FXSwitchCell.h"
#import "FXTextViewCell.h"
#import "FXRadioBoxCell.h"
#import "FXCheckBoxCell.h"
#import "FXMediaViewCell.h"
#import <MJExtension/MJExtension.h>
#define kcellHeight 60

@interface FXFormViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FXFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.tableView registerClass:[FXTextFieldCell class] forCellReuseIdentifier:FXTextFieldCellID];
    [self.tableView registerClass:[FXArrowCell class] forCellReuseIdentifier:FXArrowCellID];
    [self.tableView registerClass:[FXLabelCell class] forCellReuseIdentifier:FXLabelCellID];
    [self.tableView registerClass:[FXSwitchCell class] forCellReuseIdentifier:FXSwitchCellID];
    [self.tableView registerClass:[FXTextViewCell class] forCellReuseIdentifier:FXTextViewCellID];
    [self.tableView registerClass:[FXRadioBoxCell class] forCellReuseIdentifier:FXRadioBoxCellID];
    [self.tableView registerClass:[FXCheckBoxCell class] forCellReuseIdentifier:FXCheckBoxCellID];
    [self.tableView registerClass:[FXMediaViewCell class] forCellReuseIdentifier:FXMediaViewCellID];
    [self.view addSubview:self.tableView];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

-(void)loadDataWithFileName:(NSString *)fileName{
    self.datas = [FXFormModel mj_objectArrayWithKeyValuesArray:[NSArray readLocalFileWithName:fileName]];
    for (FXFormModel *model in self.datas) {
        [FXFormModelTool handeModelCellType:model];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FXFormModel *model = self.datas[indexPath.row];
    return model.height ? model.height : kcellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FXFormModel *model = self.datas[indexPath.row];
    FXBaseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.cellID forIndexPath:indexPath];
    [cell initWithModel:model parentVC:self];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FXBaseViewCell  *cell = [tableView cellForRowAtIndexPath:indexPath];
    FXFormModel *model = self.datas[indexPath.row];
    if (model.showInfo) {
        return;
    }
    [self.view endEditing:YES];
    [cell doSomething];
}


-(void)checkHaveEmptyField:(void (^)(BOOL,NSString *_Nonnull))block{
    for (FXFormModel *field in self.datas) {
        if (field.cellType == FXCellTypeMeida) { //是多媒体cell需要上传图片
            if (field.medias.count == 1) {
                block(YES ,[NSString stringWithFormat:@"请上传%@",field.name]);
                return;
            }
        }else{ //不是多媒体cell
            if (!field.text.length) {//判断为空
                NSString *prefix = (field.cellType == FXCellTypeArrow || field.cellType == FXCellTypeCheckBox) ? @"请选择" : @"请输入";
                block(YES ,[NSString stringWithFormat:@"%@%@",prefix,field.name]);
                return;
            }else{
                 [self.uploadDict setValue:field.text forKey:field.key];
            }
        }
    }
    
    block(NO,@"");
}

-(NSMutableDictionary *)requestDict{
    if (_requestDict == nil) {
        _requestDict = [NSMutableDictionary dictionary];
    }
    return _requestDict;
}

-(NSMutableDictionary *)uploadDict{
    if (_uploadDict == nil) {
        _uploadDict = [NSMutableDictionary dictionary];
    }
    return _uploadDict;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 0.0001;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _tableView;
}


@end
