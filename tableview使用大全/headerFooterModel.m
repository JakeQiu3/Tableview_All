//
//  headerFooterModel.m
//  tableview使用大全
//
//  Created by qsyMac on 16/11/20.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "HeaderFooterModel.h"

@implementation HeaderFooterModel
- (HeaderFooterModel *)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.question = dic[@"text"];
    }
    return self;
}

+ (HeaderFooterModel *)initWithDic:(NSDictionary *)dic {
    HeaderFooterModel *headerFooterModel = [[HeaderFooterModel alloc] initWithDic:dic];
    return headerFooterModel;
}

@end
