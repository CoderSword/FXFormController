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
#import "FXFormHeaderView.h"
#import "FXFormHeaderModel.h"
#define kcellHeight 60

@interface FXFormViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign)BOOL haveHeader;
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
    [self.tableView registerClass:[FXFormHeaderView class] forHeaderFooterViewReuseIdentifier:FXFormHeaderViewID];
    
    [self.view addSubview:self.tableView];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

-(void)loadDataWithFileName:(NSString *)fileName{
    self.datas = [NSMutableArray arrayWithArray:[FXFormModelTool getFieldModelsWithFileName:fileName]];
    self.haveHeader = [self.datas.firstObject isKindOfClass:[FXFormHeaderModel class]];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FXFormHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FXFormHeaderViewID];
    if (self.haveHeader) {
        FXFormHeaderModel *headerModel = self.datas[section];
        headerView.model = headerModel.header;
    }
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.haveHeader ? 45 : 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.haveHeader ? self.datas.count : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.haveHeader) {
        FXFormHeaderModel *headerModel = self.datas[section];
        return headerModel.content.count;
    }
    return self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FXFormModel *model = [self getCurrentFormModel:indexPath];
    return model.height ? model.height : kcellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FXFormModel *model = [self getCurrentFormModel:indexPath];
    FXBaseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.cellID forIndexPath:indexPath];
    [cell initWithModel:model parentVC:self];
    return cell;
}

-(FXFormModel *)getCurrentFormModel:(NSIndexPath *)indexPath{
    FXFormModel *model = [[FXFormModel alloc]init];
    if (self.haveHeader) {
        FXFormHeaderModel *headerModel = self.datas[indexPath.section];
        model = headerModel.content[indexPath.row];
    }else{
        model = self.datas[indexPath.row];
    }
     return model;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FXBaseViewCell  *cell = [tableView cellForRowAtIndexPath:indexPath];
    FXFormModel *model = [self getCurrentFormModel:indexPath];
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionFooterHeight = 0.001;
        _tableView.sectionHeaderHeight = 0.001;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
        _tableView.backgroundColor = _tableView.separatorColor;
    }
    return _tableView;
}


@end
