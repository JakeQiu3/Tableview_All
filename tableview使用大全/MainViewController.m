//
//  MainViewController.m
//  tableview使用大全
//
//  Created by 邱少依 on 15/12/24.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import "MainViewController.h"
#import "TableContact.h"
#import "TableContactGroup.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_contactsArray;
    NSIndexPath *_selcetedIndex;//当前选中的组和行
    UIToolbar *_toolBar;
    BOOL _isInsert;//记录是点击了插入还是删除按钮
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setUI];
    [self addToolbar];
    // Do any additional setup after loading the view.
}

- (void)initData {
    _contactsArray = [[NSMutableArray alloc] init];
// 控件内容 == init的参数（模型化）
//    让程序定位到出错代码行：view->navigators->Show the Breakpoint  navigator—> Add Exception breakpoint。
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
    
    TableContact *contact10 = [[TableContact alloc]initWithFirstName:@"wiu" lastName:@"hhdfa" phoneNumber:@"13788774362"];
    TableContact *contact11 = [[TableContact alloc]initWithFirstName:@"wiu" lastName:@"huga" phoneNumber:@"1374362"];
    TableContact *contact12 = [[TableContact alloc]initWithFirstName:@"wiu" lastName:@"gsg" phoneNumber:@"137884774362"];
    TableContact *contact13 = [[TableContact alloc]initWithFirstName:@"wiu" lastName:@"erdsg" phoneNumber:@"137884774362"];
    TableContactGroup *group4 = [[TableContactGroup alloc] initWithGroupName:@"W" groupDetail:@"With names beginning with W" contacts:[NSMutableArray arrayWithObjects:contact10,contact11,contact12,contact13,nil]];
    [_contactsArray addObject:group4];
    
}

- (void)setUI {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
#pragma mark dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _contactsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
    static NSString *indentfifer = @"woout";
    static NSString *switchIndentifer = @"switchIdentifier";

    UITableViewCell *cell;
    if (0 == indexPath.row) {
        cell = [tableView dequeueReusableCellWithIdentifier:switchIndentifer];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:indentfifer];
    }

    if (!cell) {
        if (0 == indexPath.row) {
            cell = [[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:switchIndentifer];
            UISwitch *switchView = [[UISwitch alloc] init];
            [switchView addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = switchView;
        } else {
            cell = [[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentfifer];
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        }
    }
    TableContactGroup *tempGroup = _contactsArray[indexPath.section];
    TableContact *tempContact = tempGroup.contacts[indexPath.row];
    cell.textLabel.text = [tempContact getName];
    cell.detailTextLabel.text = tempContact.phoneNumber;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    TableContactGroup *tempGroup = _contactsArray[section];
    return tempGroup.groupName;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    TableContactGroup *tempGroup = _contactsArray[section];
    return tempGroup.groupDetail;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selcetedIndex = indexPath;
    TableContactGroup *tempGroup = _contactsArray[indexPath.section];
    TableContact *tempContact = tempGroup.contacts[indexPath.row];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[tempContact getName] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//  给alert 创建一个textfield
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//取得文本框
    UITextField *textField= [alert textFieldAtIndex:0];
    textField.text=tempContact.phoneNumber; //设置文本框内容
    [alert show]; //显示窗口
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (1 == buttonIndex) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        TableContactGroup *tempGroup = _contactsArray[_selcetedIndex.section];
        TableContact *tempContact = tempGroup.contacts[_selcetedIndex.row];
        tempContact.phoneNumber = textField.text;
//        // 全部刷新
//        [_tableView reloadData];
        //局部刷新表格
        NSArray *indexPathArray=@[_selcetedIndex];//需要局部刷新的单元格的组、行
        [_tableView reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationAutomatic];//后面的参数代表更新时的动画
    }
}

#pragma mark delegate 
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (0 == section) {
        return 100;
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//切换按钮的方法
- (void)switchValueChange:(UISwitch *)switchView {
    NSLog(@"切换按钮");
}

//添加工具栏
- (void)addToolbar {
    
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,64)];
    [self.view addSubview:_toolBar];
//   删除按钮
    UIBarButtonItem *removeBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(remove:)];
//    
    UIBarButtonItem *flexibleBtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    添加按钮
    UIBarButtonItem *addBtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    
    NSArray *buttonArray=[NSArray arrayWithObjects:removeBtn,flexibleBtn,addBtn, nil];
    _toolBar.items = buttonArray;
    
    
}

/*
 * 删除方法
 */
- (void)remove:(UIBarButtonItem *)btnItem {
    _isInsert = NO;
    [_tableView setEditing:!_tableView.isEditing animated:YES];
}

/*
 * 添加方法
 */
- (void)add:(UIBarButtonItem *)btnItem {
    _isInsert = YES;
    [_tableView setEditing:!_tableView.isEditing animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isInsert) {
        return UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}

// 向左滑动删除和添加方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    TableContactGroup *tempGroup = _contactsArray[indexPath.section];
    TableContact *tableContact = tempGroup.contacts[indexPath.row];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tempGroup.contacts removeObject:tableContact];
//        局部刷新数据 delete
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        //如果当前组中已经没有数据则移除组刷新整个表格
        if (tempGroup.contacts.count == 0) {
            [_contactsArray removeObject:tempGroup];
            [tableView reloadData];
        }
    }else if (editingStyle == UITableViewCellEditingStyleInsert) {//添加
        TableContact *tempContact = [[TableContact alloc] init];
        tempContact.firstName = @"woqu";
        tempContact.lastName = @"A";
        tempContact.phoneNumber = @"16349983597";
        [tempGroup.contacts insertObject:tempContact atIndex:indexPath.row];
        //            局部刷新 insert
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }

}


//移动排序
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    TableContactGroup *tempGroup = _contactsArray[sourceIndexPath.section];
    TableContact *tempContact = tempGroup.contacts[sourceIndexPath.row];
    [tempGroup.contacts removeObject:tempContact];
    if (tempGroup.contacts.count == 0) {//若移除后，该组无联系人
        [_contactsArray removeObject:tempGroup];
        [tableView reloadData];
    }
     TableContactGroup *destinationGroup = _contactsArray[destinationIndexPath.section];
    [destinationGroup.contacts insertObject:tempContact atIndex:destinationIndexPath.row];
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
