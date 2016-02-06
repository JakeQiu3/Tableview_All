//
//  SearchTableViewController.m
//  tableview使用大全
//
//  Created by 邱少依 on 15/12/28.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import "SearchTableViewController.h"
#import "TableContact.h"
#import "TableContactGroup.h"
@interface SearchTableViewController ()<UISearchBarDelegate,UISearchDisplayDelegate>
{
    NSMutableArray *_contactArray;
    NSMutableArray *_searchArray;
    UISearchBar *_searchBar;
    UISearchDisplayController *_searchDisplayController;//ios8之后已被舍弃
    
}

@end

@implementation SearchTableViewController
#pragma mark 重写状态样式方法
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self addSearchBar];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)initData {
    _contactArray = [[NSMutableArray alloc] init];
    
    TableContact *contact1 = [[TableContact alloc]initWithFirstName:@"cui" lastName:@"hha" phoneNumber:@"13788774362"];
    TableContact *contact2 = [[TableContact alloc]initWithFirstName:@"cui" lastName:@"hhjoeiuga" phoneNumber:@"1374362"];
    TableContact *contact3 = [[TableContact alloc]initWithFirstName:@"cui" lastName:@"gsdsg" phoneNumber:@"137884774362"];
    TableContactGroup *group1 = [[TableContactGroup alloc] initWithGroupName:@"C" groupDetail:@"With names beginning with C" contacts:[NSMutableArray arrayWithObjects:contact1,contact2,contact3, nil]];
    [_contactArray addObject:group1];
    
    TableContact *contact4 = [[TableContact alloc]initWithFirstName:@"bui" lastName:@"hha" phoneNumber:@"137887743632"];
    TableContact *contact5 = [[TableContact alloc]initWithFirstName:@"bui" lastName:@"hhjoeiuga" phoneNumber:@"13743621323"];
    TableContactGroup *group2 = [[TableContactGroup alloc] initWithGroupName:@"B" groupDetail:@"With names beginning with B" contacts:[NSMutableArray arrayWithObjects:contact4,contact5, nil]];
    [_contactArray addObject:group2];
    
    TableContact *contact6 = [[TableContact alloc]initWithFirstName:@"liu" lastName:@"hhdfa" phoneNumber:@"13788774362"];
    TableContact *contact7 = [[TableContact alloc]initWithFirstName:@"liu" lastName:@"huga" phoneNumber:@"1374362"];
    TableContact *contact8 = [[TableContact alloc]initWithFirstName:@"liu" lastName:@"gsg" phoneNumber:@"137884774362"];
    TableContact *contact9 = [[TableContact alloc]initWithFirstName:@"liu" lastName:@"erdsg" phoneNumber:@"137884774362"];
    TableContactGroup *group3 = [[TableContactGroup alloc] initWithGroupName:@"L" groupDetail:@"With names beginning with L" contacts:[NSMutableArray arrayWithObjects:contact6,contact7,contact8,contact9,nil]];
    [_contactArray addObject:group3];

}

- (void)addSearchBar {
    _searchBar = [[UISearchBar alloc] init];
    [_searchBar sizeToFit];//大小自适应容器
    _searchBar.placeholder = @"Please input key word";
    _searchBar.showsCancelButton = YES;
    _searchBar.autocapitalizationType =UITextAutocapitalizationTypeNone;
    _searchBar.delegate = self;
    self.tableView.tableHeaderView = _searchBar;
    
    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchDisplayController.delegate = self;
    _searchDisplayController.searchResultsDataSource = self;
    _searchDisplayController.searchResultsDelegate = self;
    
    [_searchDisplayController setActive:NO animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _searchDisplayController.searchResultsTableView) {
        return 1;
    }
    return _contactArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _searchDisplayController.searchResultsTableView) {
        return _searchArray.count;
    }
    TableContactGroup *tempGroup = _contactArray[section];
    return tempGroup.contacts.count;
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
     NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    if (tableView == _searchDisplayController.searchResultsTableView) {
        return tempArray;
    }
    for (TableContactGroup *tempGroup in _contactArray) {
        [tempArray addObject:tempGroup.groupName];
    }
    return tempArray;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableContact *tempContact = nil;
    if (tableView == _searchDisplayController.searchResultsTableView) {
        tempContact = _searchArray[indexPath.row];
    } else {
        TableContactGroup *tempGroup = _contactArray[indexPath.section];
        tempContact = tempGroup.contacts[indexPath.row];
    }
    
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [tempContact getName];
    cell.detailTextLabel.text = tempContact.phoneNumber;
    return cell;
}
#pragma mark 设置分组标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == _searchDisplayController.searchResultsTableView) {
        return @"搜索结果";
    }
    TableContactGroup *tempGroup = _contactArray[section];
    return tempGroup.groupName;
}

//选中之前执行的方法
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_searchBar resignFirstResponder];//退出键盘
    return indexPath;
}

#pragma mark - UISearchDisplayController代理方法
//加载后，自动刷新数据
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self searchDataWithKeyWord:searchString];
    return YES;
}
//搜索形成新数据
- (void)searchDataWithKeyWord:(NSString *)searchString {
    _searchArray = [[NSMutableArray alloc] init];
    [_contactArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TableContactGroup *tempGroup = obj;
        [tempGroup.contacts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TableContact *tempContact = obj;
            if ([tempContact.firstName.uppercaseString containsString:searchString.uppercaseString] || [tempContact.lastName.uppercaseString containsString:searchString.uppercaseString]|| [tempContact.phoneNumber containsString:searchString]) {
                [_searchArray addObject:tempContact];
            }
        }];
    }];
//    切勿再次刷新，会把源数据都刷新出来
//    [self.tableView reloadData];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _searchDisplayController.searchResultsTableView) {
        NSLog(@"点击了搜索数据");
    } else {
        NSLog(@"点击了源数据");
    }
}
@end
