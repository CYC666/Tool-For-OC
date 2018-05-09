//
//  FriendsListCtrl.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/5/9.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "FriendsListCtrl.h"
#import "FollowGroupModel.h"
#import "FollowModel.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "FollwTableViewCell.h"
#import "NSMutableArray+FilterElement.h"
#import "UIView+MHCommon.h"

@interface FriendsListCtrl ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView; // 表示图
@property (nonatomic,strong) NSMutableArray *dataArray; // 数据源大数组
@property (nonatomic,strong) NSMutableArray *array; // 数据源数组 分组和每个区的模型
@property (nonatomic,strong) NSMutableArray *sectionIndexs; // 放字母索引的数组
@end

@implementation FriendsListCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"好友列表";
    [self.view addSubview:self.tableView];
    // 加载数据源
    [self loadDatas];
}
/**
 *  加载数据
 */
- (void)loadDatas
{
    self.array = [NSMutableArray array];
    NSMutableArray *tempArray = [NSMutableArray array];
    self.dataArray = [NSMutableArray arrayWithObjects:@"京东白条",@"无人机",@"HD3144",@"HD3145",@"水杯",@"小绵羊",@"索菲亚的复苏",@"13705038428@163.com",@"@#3",@"詹姆斯",@"奥巴马",nil];
    self.sectionIndexs = [NSMutableArray array];
    for (NSString *string in self.dataArray) {
        NSString *header = [PinYinForObjc chineseConvertToPinYinHead:string];
        [self.sectionIndexs addObject:header];
    }
    // 去除数组中相同的元素
    self.sectionIndexs = [self.sectionIndexs filterTheSameElement];
    // 数组排序
    [self.sectionIndexs sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *string1 = obj1;
        NSString *string2 = obj2;
        return [string1 compare:string2];
    }];
    // 将排序号的首字母数组取出 分成一个个组模型 和组模型下边的一个个 item
    for (NSString *string in self.sectionIndexs) {
        FollowGroupModel *group = [FollowGroupModel getGroupsWithArray:self.dataArray groupTitle:string];
        if ([group.groupTitle isEqualToString:@"#"]) {
            // 默认 #开头的放在数组的最前边 后边才是 A-Z
            [tempArray insertObject:group atIndex:0];
        }else{
            [tempArray addObject:group];
        }
    }
    self.array = tempArray;
    [self.tableView reloadData];
}

#pragma mark - 懒加载一些内容
- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Nav_Height, kScreenWidth, kScreenHeight - Nav_Height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
#ifdef __IPHONE_11_0
        if(@available(iOS 11.0, *)){
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
#else
        
#endif
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.array.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    FollowGroupModel *group = self.array[section];
    return group.follows.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"FollwTableViewCell";
    FollwTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [FollwTableViewCell viewFromBundle];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    FollowGroupModel *group = self.array[indexPath.section];
    FollowModel *followM = group.follows[indexPath.row];
    cell.nickNmaeLabel.text = followM.nickname;
    return cell;
}
/**
 *   右侧的索引标题数组
 *
 *   @param tableView 标示图
 *
 *   @return 数组
 */
- (NSArray*)sectionIndexTitlesForTableView:(UITableView*)tableView {
    
    return self.sectionIndexs;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    FollowGroupModel *group = self.array[section];
    // 背景图
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    bgView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    // 显示分区的 label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth-40, 30)];
    label.text = group.groupTitle;
    label.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:label];
    return bgView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

#pragma mark - 设置 tableViewcell横线左对齐
-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
