//
//  WeiboStatus.h
//  tableview使用大全
//
//  Created by 邱少依 on 15/12/25.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboStatus : NSObject
@property (nonatomic,assign) long long Id;//微博id
@property (nonatomic,copy) NSString *profileImageUrl;//头像
@property (nonatomic,copy) NSString *userName;//发送用户
@property (nonatomic,copy) NSString *mbtype;//会员类型
@property (nonatomic,copy) NSString *createdAt;//创建时间
@property (nonatomic,copy) NSString *text;//微博内容

@property (nonatomic,copy) NSString *source;//设备来源

- (WeiboStatus *)initWithDic:(NSDictionary *)dic;
+ (WeiboStatus *)initWithDic:(NSDictionary *)dic;
@end
