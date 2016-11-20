//
//  QLKInfoTableViewHeaderFooterView.m
//  tableview使用大全
//
//  Created by qsyMac on 16/11/19.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "QLKInfoTableViewHeaderFooterView.h"
#define kMargin 10
@interface   QLKInfoTableViewHeaderFooterView()
@end
@implementation QLKInfoTableViewHeaderFooterView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    _numLabel = [[UILabel alloc] init];
    
    [self.contentView addSubview:_numLabel];
    _questionLabel = [[UILabel alloc] init];
    
    _questionLabel.text = @"我饿孤傲奇偶涉及到刚看见了看的撒寄过来算啦";
    CGSize textSize = [_questionLabel.text boundingRectWithSize:CGSizeMake(self.bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.5]} context:nil].size;
    
    _questionLabel.frame = CGRectMake(10, 15, self.bounds.size.width-20, textSize.height);
    _questionLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _questionLabel.textColor = [UIColor blackColor];
    _questionLabel.numberOfLines = 0;
    _questionLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_questionLabel];
}

@end
