//
//  FunctionListController.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/4/18.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "FunctionListController.h"
#import "MMDrawerController.h"
#import "MainCCell.h"


@interface FunctionListController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    
    UICollectionView *_listCollectionView;
    NSArray *funcArray;
    
}

@end

@implementation FunctionListController

#pragma mark ========================================生命周期========================================

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = Background_Color;
    self.navigationItem.rightBarButtonItem = nil;
    
    
    
    funcArray = self.funcDic[@"func"];
    
    // 集合视图
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth, (kScreenHeight - Nav_Height) * 0.1);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _listCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Nav_Height, kScreenWidth, kScreenHeight - Nav_Height)
                                             collectionViewLayout:layout];
    _listCollectionView.backgroundColor = [UIColor clearColor];
    [_listCollectionView registerNib:[UINib nibWithNibName:@"MainCCell" bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:@"MainCCell"];
    _listCollectionView.delegate = self;
    _listCollectionView.dataSource = self;
    [self.view addSubview:_listCollectionView];
    
#ifdef __IPHONE_11_0
    if(@available(iOS 11.0, *)){
        _listCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#else
    
#endif
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    MMDrawerController *drawCtrl= (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [drawCtrl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    MMDrawerController *drawCtrl= (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [drawCtrl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}




#pragma mark ========================================动作响应=============================================


#pragma mark ========================================网络请求=============================================


#pragma mark ========================================代理方法=============================================
#pragma mark - 集合视图代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return funcArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MainCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCCell" forIndexPath:indexPath];
    
    if (indexPath.row % 2) {
        cell.colorView.backgroundColor = Background_Color;
        cell.nameLabel.textColor = Label_Color_A;
    } else {
        cell.colorView.backgroundColor = Label_Color_A;
        cell.nameLabel.textColor = Background_Color;
    }
    
    NSDictionary *dic = funcArray[indexPath.row];
    cell.nameLabel.text = dic[@"name"];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = funcArray[indexPath.row];
    BaseController *ctrl = [[NSClassFromString([NSString stringWithFormat:@"%@Ctrl", dic[@"func"]]) alloc] init];
    ctrl.funcDic = dic;
    [self.navigationController pushViewController:ctrl animated:YES];
    
}





@end
