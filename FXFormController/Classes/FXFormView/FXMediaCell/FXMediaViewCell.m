//
//  FXMediaCell.m
//  FXFieldOCAPP
//
//  Created by 杨健 on 2020/5/18.
//  Copyright © 2020 杨健. All rights reserved.
//

#import "FXMediaViewCell.h"
#import "FXMediaItemCell.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import <GKPhotoBrowser/GKPhotoBrowser.h>
#define kPictureCount 5


static NSString *const FXMediaItemCellID = @"FXMediaItemCell";

@interface FXMediaViewCell ()<TZImagePickerControllerDelegate,FXMediaItemCellDelegate>
@property(nonatomic,strong)UIImage *addImage;
@property(nonatomic,strong)FXMediaItem *addItem;
@end

@implementation FXMediaViewCell

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FXMediaItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FXMediaItemCellID forIndexPath:indexPath];
    cell.media = self.model.medias[indexPath.item];
    cell.delegate = self;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.medias.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FXMediaItem *media = self.model.medias[indexPath.item];
    if (media.isAddImage) {
      [self showPickerContoller];
    }else{
        [self showMedias:indexPath];
    }
}

#pragma mark --FXMediaItemCellDelegate
-(void)mediaItemCellDeleted:(FXMediaItemCell *)itemCell{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:itemCell];
    [self.model.medias removeObjectAtIndex:indexPath.item];
    self.model.height = [self calculationModelheight];
    NSIndexPath *currentIndexPath = [self.parentVC.tableView indexPathForCell:self];
    //会重新走initWithModel方法检查有没有+图片
    [self.parentVC.tableView reloadRowsAtIndexPaths:@[currentIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.addImage.size.width / 375, [UIScreen mainScreen].bounds.size.height  * self.addImage.size.height / 667);
        [self.collectionView registerClass:[FXMediaItemCell class] forCellWithReuseIdentifier:FXMediaItemCellID];
        self.collectionView.userInteractionEnabled = !self.model.showInfo;
        [self.contentView addSubview:self.collectionView];
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.cellMargin);
            make.right.mas_equalTo(-self.cellMargin);
            make.top.equalTo(self.iconBtn.mas_bottom).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        }];
    }
    return self;
}

-(void)initWithModel:(FXFormModel *)model parentVC:(FXFormViewController *)parentVC{
    [super initWithModel:model parentVC:parentVC];
    
    FXMediaItem *lastItem = self.model.medias.lastObject;
    if (!lastItem.isAddImage && self.model.medias.count < kPictureCount) {
        [self.model.medias addObject:self.addItem];
    }
    
    self.model.height = [self calculationModelheight];
    [self.collectionView reloadData];
}

#pragma mark --弹出TZImagePickerController
-(void)showPickerContoller{
    NSInteger maxNum = kPictureCount - self.model.medias.count + 1;
    TZImagePickerController *imagePickController = [[TZImagePickerController alloc] initWithMaxImagesCount:maxNum delegate:self];
    imagePickController.allowPickingImage = YES;
    imagePickController.allowPickingMultipleVideo = NO;
    imagePickController.allowPickingVideo = NO;
    [self.parentVC presentViewController:imagePickController animated:YES completion:nil];
}

#pragma mark --TZImagePickerControllerDelegate
-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos{
    for (int index = 0; index < photos.count; index++) {
        FXMediaItem *media = [[FXMediaItem alloc]init];
        UIImage *image = photos[index];
        PHAsset *sset = assets[index];
        media.imageData = UIImageJPEGRepresentation(image, 0.6);
        media.isEdit = YES;
        media.fileName = [sset valueForKeyPath:@"filename"];
        [self.model.medias insertObject:media atIndex:0];
    }
    if (self.model.medias.count > kPictureCount) {//超出5个删除addModel
        [self.model.medias removeLastObject];
    }
    self.model.height = [self calculationModelheight];
    [self.parentVC.tableView reloadData];
}

#pragma mark ----显示媒体浏览器
-(void)showMedias:(NSIndexPath *)indexPath{
    NSMutableArray *photos = [NSMutableArray array];
    for (FXMediaItem *media in self.model.medias) {
        if(![media isEqual:self.addItem]){
            GKPhoto *photo = [[GKPhoto alloc]init];
            if (media.imageData) {
                photo.image = [UIImage imageWithData:media.imageData];
            }else if (media.url){
                photo.url = [NSURL URLWithString:media.url];
            }
            [photos addObject:photo];
        }
    }
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:indexPath.row];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    [browser showFromVC:self.parentVC];
}

-(CGFloat)calculationModelheight{
    int rows =  ceil(self.model.medias.count / 3.0);
    CGFloat totalHeight = self.cellHeight * 0.5 + self.iconBtnImageHeight * 0.5 + self.layout.sectionInset.top + self.layout.sectionInset.bottom + rows * self.layout.itemSize.height + (rows - 1) * self.layout.minimumLineSpacing;
    return totalHeight;
}

-(UIImage *)addImage{
    if (_addImage == nil) {
        _addImage = [UIImage imageNamed:@"media_add"];
    }
    return _addImage;
}

-(FXMediaItem *)addItem{
    if (_addItem == nil) {
        _addItem = [[FXMediaItem alloc]init];
        _addItem.imageData = UIImageJPEGRepresentation(self.addImage, 0.6);
        _addItem.isAddImage = YES;
    }
    return _addItem;
}


@end
