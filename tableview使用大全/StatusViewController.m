//
//  StatusViewController.m
//  tableview使用大全
//
//  Created by 邱少依 on 15/12/25.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import "StatusViewController.h"
#import "StatusTableViewCell.h"
#import "WeiboStatus.h"

#import "QLKInfoTableViewHeaderFooterView.h"
#import "QLKHeaderFooterModel.h"

@interface StatusViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;// cell的模型数据源
    NSMutableArray *headerArray;//区头的模型数据源
    
    NSMutableArray *_statusCellsArray; //存储cell，用于计算高度
    NSMutableArray *_headerFootersViewArray; //存储headerFooterView，用于计算高度
}

@end

@implementation StatusViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setUI];
}

- (void)initData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"StatusInfo" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    _dataArray = [[NSMutableArray alloc] init];
    _statusCellsArray = [[NSMutableArray alloc] init];
    headerArray = [[NSMutableArray alloc] init];
    _headerFootersViewArray = [[NSMutableArray alloc] init];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 转cell的数据字典为模型
        WeiboStatus *statusModel = [WeiboStatus initWithDic:obj];
        [_dataArray addObject:statusModel];
        // 把cell放进数组中。
        StatusTableViewCell *statusCell = [[StatusTableViewCell alloc] init];
        [_statusCellsArray addObject:statusCell];
        
        
        // 转区头view的数据字典为模型
        QLKHeaderFooterModel *headerModel = [QLKHeaderFooterModel initWithDic:obj];
        [headerArray addObject:headerModel];
        
        //将区头view添加到数组中
        QLKInfoTableViewHeaderFooterView *headerView = [[QLKInfoTableViewHeaderFooterView alloc] init];
        [_headerFootersViewArray addObject:headerView];
    }];
}

- (void)setUI {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    //设置成grouped类型: 3个后果
    // 1、区头区尾有粘性效果（有默认的高度->设置对应区头区尾的高度不为0就行
    // 2、和对应默认的颜色->修改默认的区头区尾的背景颜色方法）
    _tableView.backgroundView = [[UIView alloc] init];
    _tableView.backgroundColor = [UIColor clearColor];
    //  3、tableview的tableHeaderView和tableFooterView有粘性高度->重新指向的一个有高度的view
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.1f)];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.1f)];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndenfiner = @"cellIndenfiner";
    StatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndenfiner];
    if (!cell) {
        cell = [[StatusTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndenfiner];
#warning 曾经踩过的坑：cell 的init过程中切勿涉及到indexpath，因为创建只执行了visible cells，其他的cells不走复用。
        
    }
    WeiboStatus *status = _dataArray[indexPath.section];
    cell.weiboStatus = status;
    return cell;
}

#pragma mark 动态设置cell rowHeight
// Cell内部设置多高都没有用，需重新设置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    获取到对应的cell
    StatusTableViewCell *statusCell = _statusCellsArray[indexPath.section];
    //   再次给cell赋值
    statusCell.weiboStatus = _dataArray[indexPath.section];
    return statusCell.height;
}

#pragma mark 动态设置section header height
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *InfoTableViewHeaderView = @"InfoTableViewHeaderView";
    QLKInfoTableViewHeaderFooterView *infoTableViewHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:InfoTableViewHeaderView];
    if (!infoTableViewHeaderView) {
        infoTableViewHeaderView = [[QLKInfoTableViewHeaderFooterView alloc] initWithReuseIdentifier:InfoTableViewHeaderView];
    }
    infoTableViewHeaderView.numLabel.text = [NSString stringWithFormat:@"区头%ld.",(section+1)];
    infoTableViewHeaderView.headerModel = [headerArray objectAtIndex:section];
    return infoTableViewHeaderView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    //    获取到对应的headerView
    QLKInfoTableViewHeaderFooterView *headerView = _headerFootersViewArray[section];
    //   再次给cell赋值
    headerView.headerModel = headerArray[section];
    return headerView.height;
}

#pragma mark 动态设置section footerview height
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    //    获取到对应的headerView
    QLKInfoTableViewHeaderFooterView *headerView = _headerFootersViewArray[section];
    //   再次给cell赋值
    headerView.headerModel = headerArray[section];
    return headerView.height;
//    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    static NSString *InfoTableViewFooterView = @"InfoTableViewFooterView";
    QLKInfoTableViewHeaderFooterView *infoTableViewHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:InfoTableViewFooterView];
    if (!infoTableViewHeaderView) {
        infoTableViewHeaderView = [[QLKInfoTableViewHeaderFooterView alloc] initWithReuseIdentifier:InfoTableViewFooterView];
    }
    infoTableViewHeaderView.numLabel.text = [NSString stringWithFormat:@"区尾%d.",(section+1)];
    infoTableViewHeaderView.headerModel = [headerArray objectAtIndex:section];
    return infoTableViewHeaderView;
}
@end
