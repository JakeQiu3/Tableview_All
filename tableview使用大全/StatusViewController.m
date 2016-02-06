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
@interface StatusViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSMutableArray *_statusCellsArray; //存储cell，用于计算高度
    
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

    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
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
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   static NSString *cellIndenfiner = @"cellIndenfiner";
    StatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndenfiner];
    if (!cell) {
        cell = [[StatusTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndenfiner];
    }
    WeiboStatus *status = _dataArray[indexPath.row];
    cell.weiboStatus = status;
    return cell;
}
#pragma  mark delegate 
// Cell内部设置多高都没有用，需要重新设置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    StatusTableViewCell *statusCell = _statusCellsArray[indexPath.row];
    statusCell.weiboStatus = _dataArray[indexPath.row];
    return statusCell.height;
}

#pragma mark 重写状态样式方法
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
