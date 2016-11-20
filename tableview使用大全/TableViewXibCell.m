//
//  TableViewXibCell.m
//  tableview使用大全
//
//  Created by qsyMac on 16/11/20.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "TableViewXibCell.h"

@implementation TableViewXibCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.messgae.textColor = [UIColor lightTextColor];
    self.title.textColor = [UIColor lightGrayColor];
}
- (void)setContent:(NSString *)content {
    _content = content;
    if (_content) {
        CGRect r = [content boundingRectWithSize:CGSizeMake(self.messgae.frame.size.width,10000) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.f]} context:nil];
        self.cellHeight = r.size.height;
        self.messgae.text = content;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
