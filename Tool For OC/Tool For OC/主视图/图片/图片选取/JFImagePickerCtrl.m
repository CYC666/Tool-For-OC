//
//  JFImagePickerCtrl.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/4/18.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "JFImagePickerCtrl.h"
#import "JFImagePickerController.h"


@interface JFImagePickerCtrl () <JFImagePickerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation JFImagePickerCtrl {
    NSMutableArray *photos;
    UICollectionView *photosList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    photos = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pickPhotos)];
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:self.navigationItem.rightBarButtonItem];
    [items addObject:addItem];
    self.navigationItem.rightBarButtonItems = items;
//    self.navigationItem.title = @"JFImagePicker";
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 3;
    NSInteger size = [UIScreen mainScreen].bounds.size.width/4-1;
    if (size%2!=0) {
        size-=1;
    }
    flowLayout.itemSize = CGSizeMake(size, size);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    photosList = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Nav_Height, kScreenWidth, kScreenHeight - Nav_Height) collectionViewLayout:flowLayout];
//    photosList.contentInset = UIEdgeInsetsMake(Nav_Height, 0, 0, 0);
    photosList.scrollIndicatorInsets = photosList.contentInset;
    photosList.delegate = self;
    photosList.dataSource = self;
    photosList.backgroundColor = [UIColor whiteColor];
    photosList.alwaysBounceVertical = YES;
    [self.view addSubview:photosList];
    [photosList registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"imagePickerCell"];
    
#ifdef __IPHONE_11_0
    if(@available(iOS 11.0, *)){
        photosList.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#else
    
#endif
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imagePickerCell" forIndexPath:indexPath];
    ALAsset *asset = photos[indexPath.row];
    UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:1];
    if (!imgView) {
        imgView = [[UIImageView alloc] initWithFrame:cell.bounds];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.tag = 1;
        [cell addSubview:imgView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(preview:)];
        [cell addGestureRecognizer:tap];
    }
    cell.tag = indexPath.item;
    [[JFImageManager sharedManager] thumbWithAsset:asset resultHandler:^(UIImage *result) {
        if (cell.tag==indexPath.item) {
            imgView.image = result;
        }
    }];
    return cell;
}

- (void)preview:(UITapGestureRecognizer *)tap{
    UIView *temp = tap.view;
    JFImagePickerController *picker = [[JFImagePickerController alloc] initWithPreviewIndex:temp.tag];
    picker.pickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)pickPhotos{
    JFImagePickerController *picker = [[JFImagePickerController alloc] initWithRootViewController:nil];
    picker.pickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - ImagePicker Delegate

- (void)imagePickerDidFinished:(JFImagePickerController *)picker{
    [photos removeAllObjects];
    [photos addObjectsFromArray:picker.assets];
    [photosList reloadData];
    [self imagePickerDidCancel:picker];
}

- (void)imagePickerDidCancel:(JFImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
