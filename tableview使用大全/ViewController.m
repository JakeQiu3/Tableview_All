//
//  ViewController.m
//  动画大全
//
//  Created by 邱少依 on 16/1/5.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_dataArray;//文件夹数组
    NSArray *_classArray;//类名数组

}
//   测试2 ：cell的微博展示和基本移动删除等
//    StatusViewController *mainController=[[StatusViewController alloc]init];
//    测试3 ：cell的搜索
//    ContactTableViewController *mainController = [[ContactTableViewController alloc] init];
//    测试4 ：cell的搜索2
//    SearchTableViewController *mainController = [[SearchTableViewController alloc] init];

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)initData {
    _dataArray = [[NSArray alloc] initWithObjects:@"tableView(通讯录展示：编辑和删除排序)",@"tableview（微博展示）",@"tableView（UISearchBar 搜索常用）",@"tableView（UISearchDisplayController 搜索）", nil];
    _classArray = [[NSArray alloc] initWithObjects:@"MainViewController",@"StatusViewController",@"ContactTableViewController",@"SearchTableViewController", nil];
}

- (void)setUI {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    NSLog(@"少：self.view —> %@ \n tableview —> %@",NSStringFromCGRect(self.view.frame),NSStringFromCGRect(_tableView.frame));

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%li : %@",(long)indexPath.row,_dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class cls;
    cls = NSClassFromString(_classArray[indexPath.row]);
    UIViewController *viewC = [[cls alloc] init];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backBtnItem;
    [self.navigationController pushViewController:viewC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
