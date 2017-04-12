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
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.allowsMultipleSelectionDuringEditing = YES;// 允许在编辑模式进行多选操作
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
//分区索引
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *indexArray = [[NSMutableArray alloc] init];
    for (TableContactGroup *tempGroup in _contactsArray) {
        [indexArray addObject:tempGroup.groupName];
    }
    return indexArray;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    2种cell：2个标示
    static NSString *indentfifer = @"woout";
    static NSString *switchIndentifer = @"switchIdentifier";
//    缓存池取cell
    UITableViewCell *cell;
    if (0 == indexPath.row) {
        cell = [tableView dequeueReusableCellWithIdentifier:switchIndentifer];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:indentfifer];
    }
//创建cell
    if (!cell) {
        if (0 == indexPath.row) {
            cell = [[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:switchIndentifer];
            UISwitch *switchView= [[UISwitch alloc]init];
//            设置tag:获取对应indexPath,再获取cell
            switchView.tag = indexPath.section +100;
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
    //获取选择的indexPath
    _selcetedIndex = indexPath;
    TableContactGroup *tempGroup = _contactsArray[indexPath.section];
    TableContact *tempContact = tempGroup.contacts[indexPath.row];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[tempContact getName] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//  给alert创建一个textfield
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
// 取得文本框
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

//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//切换按钮的方法
- (void)switchValueChange:(UISwitch *)switchView {
    NSInteger section = switchView.tag - 100;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
//    获取到点击的cell
    UITableViewCell *cell;
    cell = (UITableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%p====切换按钮",cell);
}

//添加工具栏
- (void)addToolbar {
    
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,64)];
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
#warning 少 删除和添加的4步骤
// 多行删除的方法
//1.    // 允许在编辑模式进行多选操作
//self.tableView.allowsMultipleSelectionDuringEditing = YES;
//2.  点击批量删除实行编辑按钮执行方法
- (void)multiOperation:(id)sender {
    [_tableView setEditing:!_tableView.isEditing animated:YES];
}
//3.删除按钮
- (void)deleteMutile:(id)sender{
    // 获得所有被选中的行indextPath
    NSArray *indextPaths = [_tableView indexPathsForSelectedRows];
//    NSArray *indexPahts = [_tableView indexPathsForVisibleRows];//获取所有能看到的行数
     // 遍历所有的行号，得到所有的删除的数据模型。
    NSMutableArray *deletedArray =  [NSMutableArray array];
    for (NSIndexPath *path in indextPaths) {
        [deletedArray addObject:_contactsArray[path.row]];
    }
//   删除模型中的数据数组
    [_contactsArray removeObjectsInArray:deletedArray];
//    刷新表哥
    [_tableView reloadData];
    
}
///*
// * 删除方法:1.可编辑状态
// */
//- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
//    [super setEditing:editing animated:animated];
//    [_tableView setEditing:editing animated:YES];
//}
////2、确定哪些行能够编辑：默认是yes
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
////3、确定编辑样式
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (_isInsert) {
//        return UITableViewCellEditingStyleInsert;//添加
//    }
//    return UITableViewCellEditingStyleDelete;//删除
//    
//}
////四、提交编辑（不提交，无法使用侧滑来完成删除）:或者添加
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        //找到要删除的行所在的分组
//        NSMutableArray *groupArray = [self.contactsDic objectForKey:[self.keyArray objectAtIndex:indexPath.section]];
//        //判断组里是否只有1行,将整个分区删掉
//        if ([groupArray count] == 1) {
//            NSString *key = [self.keyArray objectAtIndex:indexPath.section];
//            
//            //1、删数据源
//            [self.contactsDic removeObjectForKey:key];
//            [self.keyArray removeObject:key];
//            //2、删除分区
//            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
//    //   3.刷新视图
//            [tableView reloadData];//整个视图都进行刷新
//        } else {
//            // 把当前cell对应的数据从数组中移除
//            // 1、删除数据源
//            [groupArray removeObjectAtIndex:indexPath.row];
//            
//            // 2、删除数据源对应的cell
//           if (groupArray.count == 0) {
//[tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
//} else {
//    // 2、删除数据源对应的cell
//    [tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section]]withRowAnimation:UITableViewRowAnimationLeft];
//}

//        }
//        // =======插入1行的方法 =======
//       else if (editingStyle == UITableViewCellEditingStyleInsert){
////        在点击的这1行的下面插入数据
//                    [self.dataArray insertObject:@"23" atIndex:indexPath.row + 1];
//                    //        第二步：刷新视图
//                    [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationTop];
//           
//           
//                }
//    }
//    
//}
#warning 少 --移动的3步骤--
////第一步：让tableview能够编辑；
//- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
//    [super setEditing:editing animated:animated];
//    [_tableView setEditing:editing animated:YES];
//}
//
////第二步：指定能够移动的行；
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//
////第三步：视图的移动完成；
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//    //视图移动之后数据源的改变步骤：
//    //1、找到cell所在的数组
//    NSMutableArray *groupArray = [self.contactsDic objectForKey:[self.keyArray objectAtIndex:sourceIndexPath.section]];
//    
//    id object = [groupArray objectAtIndex:sourceIndexPath.row];
//    //2、将对象添加到要移动的位置上面
//    [groupArray insertObject:object atIndex:destinationIndexPath.row];
//    //  [groupArray addObject:object] 不用该方法,位置是最后!
//    //4、将对象从数组中移除
//    [groupArray removeObjectAtIndex:sourceIndexPath.row];
//    //   5、刷新数据源
//    [tableView reloadData];
//    
//}
//
////不让tableView跨区域移动
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
//    //如果对象的原始位置和临时位置在同一个分区中，就可以让他移动；
//    if (sourceIndexPath.section == proposedDestinationIndexPath.section) {
//        return proposedDestinationIndexPath;
//    }
//    //如果不在同一个分区中，让对象回到原来的位置上；
//    return sourceIndexPath;
//}

//删除cell的方法

- (void)remove:(UIBarButtonItem *)btnItem {
    _isInsert = NO;
    [_tableView setEditing:!_tableView.isEditing animated:YES];
}

/*
 * 添加方法:可编辑状态
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

@end
