//
//  headerFooterModel.m
//  tableview使用大全
//
//  Created by qsyMac on 16/11/20.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "QLKHeaderFooterModel.h"

@implementation QLKHeaderFooterModel
- (QLKHeaderFooterModel *)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.question = dic[@"text"];
    }
    return self;
}

+ (QLKHeaderFooterModel *)initWithDic:(NSDictionary *)dic {
    QLKHeaderFooterModel *headerFooterModel = [[QLKHeaderFooterModel alloc] initWithDic:dic];
    return headerFooterModel;
}

@end
