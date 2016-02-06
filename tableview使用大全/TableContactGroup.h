//
//  TableContactGroup.h
//  tableview使用大全
//  组模型
//  Created by 邱少依 on 15/12/24.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableContactGroup : NSObject
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, copy) NSString *groupDetail;
@property (nonatomic, strong) NSMutableArray *contacts;

- (TableContactGroup *)initWithGroupName:(NSString *)groupName groupDetail:(NSString *)groupDetail contacts:(NSMutableArray *)contacts;

+ (TableContactGroup *)initWithGroupName:(NSString *)groupName groupDetail:(NSString *)groupDetail contacts:(NSMutableArray *)contacts;
@end
