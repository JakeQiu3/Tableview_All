//
//  TableContact.h
//  tableview使用大全
//  联系人模型
//  Created by 邱少依 on 15/12/24.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableContact : NSObject
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *phoneNumber;

- (TableContact *)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName phoneNumber:(NSString *)phoneNum;
+ (TableContact *)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName phoneNumber:(NSString *)phoneNum;


-(NSString *)getName;

@end
