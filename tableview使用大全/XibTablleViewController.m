//
//  XibTablleViewController.m
//  tableview使用大全
//
//  Created by qsyMac on 16/11/20.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "XibTablleViewController.h"
#import "TextModel.h"
#import "TableViewXibCell.h"

@interface XibTablleViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation XibTablleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setData];
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)setData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"StatusInfo" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    _dataArray = [[NSMutableArray alloc] init];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 转cell的数据字典为模型
        TextModel *model = [TextModel initWithDic:obj];
        [_dataArray addObject:model];
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
    static NSString *cellXibIndenfiner = @"cellXibIndenfiner";
    TableViewXibCell *cell = [tableView dequeueReusableCellWithIdentifier:cellXibIndenfiner];
    if (!cell) {
        cell = [[TableViewXibCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellXibIndenfiner];
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TableViewXibCell" owner:nil options:nil] lastObject];
    }
//    TextModel *model = _dataArray[indexPath.section];
    cell.content = @"ashgkjhjkahgeuhkjaxhkjbcmnbzjb uavsjbajhbk hbdasdhciurehwicuhriwojPUCIocntluocijew";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 240;
    return tableView.rowHeight;
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
