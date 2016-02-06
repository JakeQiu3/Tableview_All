//
//  ContactTableViewController.m
//  tableview使用大全
//
//  Created by 邱少依 on 15/12/24.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import "ContactTableViewController.h"
#import "TableContact.h"
#import "TableContactGroup.h"
@interface ContactTableViewController ()<UISearchBarDelegate>
{
    UISearchBar *_searchBar;
    NSMutableArray *_contactsArray;//数据数组
    NSMutableArray *_searchContactArray;//搜索数组
    BOOL _isSearching;
    UILabel *label;//无搜索结果时展示
}
@end

@implementation ContactTableViewController
//添加状态栏
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];//数据源
    [self addSearchBar];//添加到表头
    [self creatResultLable];// 无搜索结果label
    
}
- (void)creatResultLable {
    label = [[UILabel alloc] init];
    label.hidden = YES;
    label.frame = CGRectMake(100, 200, 200, 30);
    label.text = @"没有搜索到您要的结果";
    label.textColor = [UIColor blackColor];
    [self.view insertSubview:label belowSubview:self.tableView];

}
- (void)initData {
    _contactsArray = [[NSMutableArray alloc] init];
    TableContact *contact1 = [[TableContact alloc]initWithFirstName:@"cui" lastName:@"hha" phoneNumber:@"13788774362"];
    TableContact *contact2 = [[TableContact alloc]initWithFirstName:@"cui" lastName:@"hhjoeiuga" phoneNumber:@"1374362"];
    TableContact *contact3 = [[TableContact alloc]initWithFirstName:@"cui" lastName:@"gsdsg" phoneNumber:@"137884774362"];
    TableContactGroup *group1 = [[TableContactGroup alloc] initWithGroupName:@"C" groupDetail:@"With names beginning with C" contacts:[NSMutableArray arrayWithObjects:contact1,contact2,contact3, nil]];
    [_contactsArray addObject:group1];
    
    TableContact *contact4 = [[TableContact alloc]initWithFirstName:@"bui" lastName:@"hha" phoneNumber:@"137887743632"];
    TableContact *contact5 = [[TableContact alloc]initWithFirstName:@"bui" lastName:@"hhjoeiuga" phoneNumber:@"13743621323"];
    TableContactGroup *group2 = [[TableContactGroup alloc] initWithGroupName:@"B" groupDetail:@"With names beginning with B" contacts:[NSMutableArray arrayWithObjects:contact4,contact5, nil]];
    [_contactsArray addObject:group2];
    
    TableContact *contact6 = [[TableContact alloc]initWithFirstName:@"liu" lastName:@"hhdfa" phoneNumber:@"13788774362"];
    TableContact *contact7 = [[TableContact alloc]initWithFirstName:@"liu" lastName:@"huga" phoneNumber:@"1374362"];
    TableContact *contact8 = [[TableContact alloc]initWithFirstName:@"liu" lastName:@"gsg" phoneNumber:@"137884774362"];
    TableContact *contact9 = [[TableContact alloc]initWithFirstName:@"liu" lastName:@"erdsg" phoneNumber:@"137884774362"];
    TableContactGroup *group3 = [[TableContactGroup alloc] initWithGroupName:@"L" groupDetail:@"With names beginning with L" contacts:[NSMutableArray arrayWithObjects:contact6,contact7,contact8,contact9,nil]];
    [_contactsArray addObject:group3];
    
}

- (void)addSearchBar {
    UIView *headerView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    CGRect searchBarRect = CGRectMake(0, 20, self.view.bounds.size.width-10, 30);
    _searchBar = [[UISearchBar alloc] initWithFrame:searchBarRect];
    [_searchBar sizeToFit];//自适应
    _searchBar.placeholder = @"Please input key word";
    _searchBar.showsCancelButton = YES;
    _searchBar.delegate = self;
    [headerView addSubview:_searchBar];
    self.tableView.tableHeaderView = headerView;
}

#pragma mark 搜索框代理方法
//取消搜索
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    _isSearching = NO;
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    [self.tableView reloadData];
}

//搜索关键字发生变化时
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText isEqualToString:@""]) {//若无输入时
        _isSearching = NO;
        [self.tableView reloadData];
    }
    [self searchDataWithKeyWord:searchText];
}

//点击搜索键盘上的搜索时
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self searchDataWithKeyWord:searchBar.text];
    [searchBar resignFirstResponder];//放弃第一响应者，关闭虚拟键盘
}

//搜索的方法
- (void)searchDataWithKeyWord:(NSString *)keyWord {
    _isSearching = YES;
    _searchContactArray = [[NSMutableArray alloc] init];
    [_contactsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TableContactGroup *tempGroup = obj;
        [tempGroup.contacts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TableContact *tempContact = obj;
            if ([tempContact.firstName.uppercaseString containsString:keyWord.uppercaseString] || [tempContact.lastName.uppercaseString containsString:keyWord.uppercaseString]|| [tempContact.phoneNumber containsString:keyWord]) {
                [_searchContactArray addObject:tempContact];
              
            }
        }];
    }];
    if (_searchContactArray.count) {
        label.hidden = YES;
    } else {
        label.hidden = NO;
    }
    [self.tableView reloadData];//刷新表格
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (_isSearching) {
        return 1;
    }
    return _contactsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isSearching) {
        return _searchContactArray.count;
    }
    TableContactGroup *tempGroup = _contactsArray[section];
    return tempGroup.contacts.count;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    NSMutableArray *indexArray = [[NSMutableArray alloc] init];
    for (TableContactGroup *tempGroup in _contactsArray) {
        [indexArray addObject:tempGroup.groupName];
    }
    return indexArray;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableContact *tempContact = nil;
    if (_isSearching) {
        tempContact = _searchContactArray[indexPath.row];
    } else {
       TableContactGroup *tempGroup = _contactsArray[indexPath.section];
        tempContact = tempGroup.contacts[indexPath.row];
    }
    static NSString *cellIdentifier = @"UITableViewCellIdentifierKey1";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [tempContact getName];
    cell.detailTextLabel.text = tempContact.phoneNumber;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_isSearching) {
        return @"搜索结果";
    }
    TableContactGroup *tempGroup = _contactsArray[section];
    return tempGroup.groupName;
}

// 获取搜索还是直接点击cell 的数据
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isSearching) {//获取搜索的,根据indexpath获取对应的数据
        NSLog(@"woca");
    } else {//根据indexpath获取对应的数据
        NSLog(@"hhh");
    }
}

@end
