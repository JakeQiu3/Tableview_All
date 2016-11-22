//
//  QLKInfoTableViewHeaderFooterView.m
//  tableview使用大全
//
//  Created by qsyMac on 16/11/19.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "QLKInfoTableViewHeaderFooterView.h"
#import "QLKHeaderFooterModel.h"
#define kMargin 10
@interface   QLKInfoTableViewHeaderFooterView()
@end
@implementation QLKInfoTableViewHeaderFooterView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    // 创建num序号
    _numLabel = [[UILabel alloc] init];
    _numLabel.textColor = [UIColor redColor];
    _numLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_numLabel];
    // 创建问题序号
    _questionLabel = [[UILabel alloc] init];
    _questionLabel.textColor = [UIColor redColor];
    _questionLabel.backgroundColor = [UIColor clearColor];
    _questionLabel.numberOfLines = 0;
    _questionLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_questionLabel];
}

- (void)setHeaderModel:(QLKHeaderFooterModel *)headerModel {
    _headerModel = headerModel;
    if (_headerModel) {
        _numLabel.frame = CGRectMake(kMargin, kMargin, 20, 20);
        [_numLabel sizeToFit];
        
        _questionLabel.text = _headerModel.question;
        // 去除左右2边的空行、内部、换行符等
        _questionLabel.text = [_questionLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        _questionLabel.text  = [_questionLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        _questionLabel.text = [_questionLabel.text stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        _questionLabel.text = [_questionLabel.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        CGFloat textWidth = [UIScreen mainScreen].bounds.size.width -_numLabel.frame.size.width -2*kMargin;
        CGSize quesTextSize = [_questionLabel.text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
        _questionLabel.frame = CGRectMake(CGRectGetMaxX(_numLabel.frame), kMargin,quesTextSize.width, quesTextSize.height);
//        [_questionLabel sizeToFit];

        self.height = CGRectGetMaxY(_questionLabel.frame) + 2*kMargin;// 计算高度时还是不够，需要增加了20的高度。
    }
}
@end
