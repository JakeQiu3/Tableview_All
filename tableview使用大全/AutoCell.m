//
//  AutoCell.m
//  CellAutoHeight
//
//  Created by lijinyang on 16/8/3.
//  Copyright © 2016年 noveleven. All rights reserved.
//

#import "AutoCell.h"

@implementation AutoCell

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.contentView layoutIfNeeded];/* important */
    self.contentLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.contentLabel.frame);/* important */
}

@end
