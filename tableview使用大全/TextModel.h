//
//  xibModel.h
//  tableview使用大全
//
//  Created by qsyMac on 16/11/20.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextModel : NSObject
@property (nonatomic,copy) NSString *question; //问题
- (TextModel *)initWithDic:(NSDictionary *)dic;
+ (TextModel *)initWithDic:(NSDictionary *)dic;
@end
