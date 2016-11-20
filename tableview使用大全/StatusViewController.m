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

static NSString * const infoTableViewHeaderFooterView = @"InfoTableViewHeaderFooterView";

@interface StatusViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSMutableArray *_statusCellsArray; //存储cell，用于计算高度
    NSMutableArray *headerViewArray;//区头数据
}

@end

@implementation StatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setUI];
    

    // Do any additional setup after loading the view.
}

- (void)initData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"StatusInfo" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    _dataArray = [[NSMutableArray alloc] init];
    _statusCellsArray = [[NSMutableArray alloc] init];
    headerViewArray = @[].mutableCopy;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [headerViewArray addObject:[obj objectForKey:@"text"]];// 获取区头数据
        WeiboStatus *statusModel = [WeiboStatus initWithDic:obj];
        [_dataArray addObject:statusModel];
//       把cell放进数组中。
        StatusTableViewCell *statusCell = [[StatusTableViewCell alloc] init];
        [_statusCellsArray addObject:statusCell];
        
    }];
    
}

- (void)setUI {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[QLKInfoTableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:infoTableViewHeaderFooterView];

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
    }
    WeiboStatus *status = _dataArray[indexPath.section];
    cell.weiboStatus = status;
    return cell;
}
#pragma  mark delegate 
// Cell内部设置多高都没有用，需要重新设置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    获取到对应的cell
    StatusTableViewCell *statusCell = _statusCellsArray[indexPath.section];
//   再次给cell赋值
    statusCell.weiboStatus = _dataArray[indexPath.section];
    return statusCell.height;
}

#pragma mark 重写状态样式方法
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark 设置区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    QLKInfoTableViewHeaderFooterView *infoTableViewHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:infoTableViewHeaderFooterView];
    return infoTableViewHeaderView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

@end
