//
//  TableContact.m
//  tableview使用大全
//
//  Created by 邱少依 on 15/12/24.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import "TableContact.h"

@implementation TableContact

- (TableContact *)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName phoneNumber:(NSString *)phoneNum {
    self = [super init];
    if (self) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.phoneNumber = phoneNum;
    }
    return self;
}

+ (TableContact *)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName phoneNumber:(NSString *)phoneNum {
    TableContact *contact = [[TableContact alloc] initWithFirstName:firstName lastName:lastName phoneNumber:phoneNum];
    return contact;
}

- (NSString *)getName {
    return [NSString stringWithFormat:@"%@ %@",_lastName,_firstName];
}
@end
