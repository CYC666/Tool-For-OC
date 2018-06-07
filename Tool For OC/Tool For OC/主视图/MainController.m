//
//  MainController.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/4/17.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "MainController.h"
#import "MainCCell.h"
#import "FunctionListController.h"
#import "LeftController.h"
#import "F3HNumberTileGameViewController.h"
#import "MainCHeader.h"

@interface MainController () <UICollectionViewDelegate, UICollectionViewDataSource, LeftControllerDlegate, SDCycleScrollViewDelegate> {
    
    UICollectionView *_listCollectionView;
    NSArray *funcArray;
    LeftController *left;
    F3HNumberTileGameViewController *ctrl2048;
    NSArray *funcControllerArray;
    
}

@end

@implementation MainController

#pragma mark ========================================生命周期========================================

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"功能列表";
    self.view.backgroundColor = Background_Color;
    
    funcControllerArray = @[
                            @"F3HNumberTileGameViewController",
                            @"CweatherViewController",
                            @"CodeViewController",
                            @"NoteViewController",
                            @"CalendarViewController",
                            @"FontViewController",
                            @"CalcularViewController"
                            //                            @"WCViewController"
                            ];
    
//    // 导航栏右边的添加按钮
//    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightItem setImage:[UIImage imageNamed:@"菜单"] forState:UIControlStateNormal];
//    [rightItem setTintColor:[UIColor whiteColor]];
//    [rightItem addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
//    self.navigationItem.leftBarButtonItem = rightBarItem;
    
    funcArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MainFunctionList.plist" ofType:nil]];
    
    // 集合视图
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth, 60);
    layout.headerReferenceSize = CGSizeMake(kScreenWidth, kScreenWidth * 0.5);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _listCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Nav_Height, kScreenWidth, kScreenHeight - Nav_Height)
                                             collectionViewLayout:layout];
    _listCollectionView.backgroundColor = [UIColor clearColor];
    [_listCollectionView registerNib:[UINib nibWithNibName:@"MainCCell" bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:@"MainCCell"];
    [_listCollectionView registerNib:[UINib nibWithNibName:@"MainCHeader" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MainCHeader"];
    _listCollectionView.delegate = self;
    _listCollectionView.dataSource = self;
    _listCollectionView.alwaysBounceVertical = YES;
    [self.view addSubview:_listCollectionView];
    
#ifdef __IPHONE_11_0
    if(@available(iOS 11.0, *)){
        _listCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#else
    
#endif
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeAction:)];
//    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
//    [self.view addGestureRecognizer:rightSwipe];
//    
//    
//    // 第一次打开，动一下左边的菜单
//    left = [[LeftController alloc] init];
//    left.view.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, kScreenHeight);
//    left.view.backgroundColor = [UIColor clearColor];
//    left.delegate = self;
//    [self.view addSubview:left.view];
//    [self addChildViewController:left];
//    
//    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeAction:)];
//    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
//    [left.view addGestureRecognizer:leftSwipe];
//    
//    NSString *didShowEnum = [[NSUserDefaults standardUserDefaults] objectForKey:@"didShowEnum"];
//    if (didShowEnum == nil || [didShowEnum isEqualToString:@""]) {
//        [UIView animateWithDuration:1 animations:^{
//            left.view.transform = CGAffineTransformMakeTranslation(kScreenWidth, 0);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:.35 animations:^{
//                left.view.transform = CGAffineTransformMakeTranslation(0, 0);
//            } completion:^(BOOL finished) {
//                [UIView animateWithDuration:1 animations:^{
//                    left.view.transform = CGAffineTransformMakeTranslation(kScreenWidth, 0);
//                } completion:^(BOOL finished) {
//                    [UIView animateWithDuration:.35 animations:^{
//                        left.view.transform = CGAffineTransformMakeTranslation(0, 0);
//                    } completion:^(BOOL finished) {
//                        
//                    }];
//                }];
//            }];
//        }];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:@"Done" forKey:@"didShowEnum"];
//    }
    
    
}






#pragma mark ========================================动作响应=============================================

#pragma mark - 左边菜单
- (void)leftButtonAction:(UIButton *)button {
    
    [UIView animateWithDuration:.35 animations:^{
        left.view.transform = CGAffineTransformMakeTranslation(kScreenWidth, 0);
    }];
    
}

#pragma mark - 展左边菜单
- (void)rightSwipeAction:(UISwipeGestureRecognizer *)swipe {
    
    [UIView animateWithDuration:.35 animations:^{
        left.view.transform = CGAffineTransformMakeTranslation(kScreenWidth, 0);
    }];
    
}

#pragma mark - 隐藏左边菜单
- (void)leftSwipeAction:(UISwipeGestureRecognizer *)swipe {
    
    [UIView animateWithDuration:.35 animations:^{
        left.view.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
    
}

#pragma mark ========================================网络请求=============================================


#pragma mark ========================================代理方法=============================================
#pragma mark - 集合视图代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return funcArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    MainCHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MainCHeader" forIndexPath:indexPath];
    
    header.bannerView.imageURLStringsGroup = funcControllerArray;
    header.bannerView.delegate = self;
    header.bannerView.autoScrollTimeInterval = 5;
    
    return header;
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MainCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCCell" forIndexPath:indexPath];
    
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    
    NSDictionary *dic = funcArray[indexPath.row];
    cell.nameLabel.text = dic[@"name"];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = funcArray[indexPath.row];
    FunctionListController *ctrl = [[FunctionListController alloc] init];
    ctrl.funcDic = dic;
    [self.navigationController pushViewController:ctrl animated:YES];
    
}


#pragma mark - 左控制器代理方法
- (void)LeftControllerIndexChange:(NSString *)ctrl {
    
    if ([ctrl isEqualToString:@"F3HNumberTileGameViewController"]) {
        // 2048
        if (!ctrl2048) {
            ctrl2048 = [F3HNumberTileGameViewController numberTileGameWithDimension:4
                                                                       winThreshold:2048
                                                                    backgroundColor:[UIColor whiteColor]
                                                                        scoreModule:YES
                                                                     buttonControls:NO
                                                                      swipeControls:YES];
        }
        
        [self presentViewController:ctrl2048 animated:YES completion:nil];
        
    } else {
        
        UIViewController *viewCtrl = [[NSClassFromString(ctrl) alloc] init];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    }
    
    
    [UIView animateWithDuration:.35 animations:^{
        left.view.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
    
    
}


#pragma mark - 轮播图点击事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    NSString *ctrl = funcControllerArray[index];
    
    if ([ctrl isEqualToString:@"F3HNumberTileGameViewController"]) {
        // 2048
        if (!ctrl2048) {
            ctrl2048 = [F3HNumberTileGameViewController numberTileGameWithDimension:4
                                                                       winThreshold:2048
                                                                    backgroundColor:[UIColor whiteColor]
                                                                        scoreModule:YES
                                                                     buttonControls:NO
                                                                      swipeControls:YES];
        }
        
        [self presentViewController:ctrl2048 animated:YES completion:nil];
        
    } else {
        
        UIViewController *viewCtrl = [[NSClassFromString(ctrl) alloc] init];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    }
    
}



























@end
