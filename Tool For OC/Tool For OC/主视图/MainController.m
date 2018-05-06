//
//  MainController.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/4/17.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "MainController.h"
#import "MMDrawerController.h"
#import "MainCCell.h"
#import "FunctionListController.h"

@interface MainController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    
    UICollectionView *_listCollectionView;
    NSArray *funcArray;
    
}

@end

@implementation MainController

#pragma mark ========================================生命周期========================================

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"功能列表";
    self.view.backgroundColor = Background_Color;
    
    funcArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MainFunctionList.plist" ofType:nil]];
    
    // 集合视图
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth, 40);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _listCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Nav_Height, kScreenWidth, kScreenHeight - Nav_Height)
                                             collectionViewLayout:layout];
    _listCollectionView.backgroundColor = [UIColor clearColor];
    [_listCollectionView registerNib:[UINib nibWithNibName:@"MainCCell" bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:@"MainCCell"];
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

































@end
