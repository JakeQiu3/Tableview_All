//
//  TableViewXibCell.h
//  tableview使用大全
//
//  Created by qsyMac on 16/11/20.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewXibCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *messgae;
@property (nonatomic, copy) NSString* content;
@property (nonatomic, assign) CGFloat cellHeight;
@end
