//
//  headerFooterModel.h
//  tableview使用大全
//
//  Created by qsyMac on 16/11/20.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderFooterModel : NSObject
@property (nonatomic,copy) NSString *question; //问题的str
- (HeaderFooterModel *)initWithDic:(NSDictionary *)dic;
+ (HeaderFooterModel *)initWithDic:(NSDictionary *)dic;
@end
