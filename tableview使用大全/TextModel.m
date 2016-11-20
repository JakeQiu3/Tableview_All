//
//  xibModel.m
//  tableview使用大全
//
//  Created by qsyMac on 16/11/20.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "TextModel.h"

@implementation TextModel
- (TextModel *)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.question = dic[@"text"];
    }
    return self;
}

+ (TextModel *)initWithDic:(NSDictionary *)dic {
    TextModel *model = [[TextModel alloc] initWithDic:dic];
    return model;
}

@end
