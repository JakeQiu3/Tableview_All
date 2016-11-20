//
//  QLKInfoTableViewHeaderFooterView.h
//  tableview使用大全
//
//  Created by qsyMac on 16/11/19.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QLKHeaderFooterModel;
@interface QLKInfoTableViewHeaderFooterView : UITableViewHeaderFooterView
@property (nonatomic, strong) UILabel *questionLabel;
@property (nonatomic, strong)UILabel *numLabel;

@property (nonatomic, strong)QLKHeaderFooterModel *headerModel;
@property (nonatomic, assign)CGFloat height;

@end
