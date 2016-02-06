//
//  TableContactGroup.m
//  tableview使用大全
//
//  Created by 邱少依 on 15/12/24.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import "TableContactGroup.h"

@implementation TableContactGroup


- (TableContactGroup *)initWithGroupName:(NSString *)groupName groupDetail:(NSString *)groupDetail contacts:(NSMutableArray *)contacts {
    self = [super init];
    if (self) {
        self.groupName = groupName;
        self.groupDetail = groupDetail;
        self.contacts = contacts;
    }
    return self;
}

+ (TableContactGroup *)initWithGroupName:(NSString *)groupName groupDetail:(NSString *)groupDetail contacts:(NSMutableArray *)contacts {
    TableContactGroup *contactGroup = [[TableContactGroup alloc] initWithGroupName:groupName groupDetail:groupDetail contacts:contacts];
    return contactGroup;
}
@end
