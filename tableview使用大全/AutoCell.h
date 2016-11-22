//
//  AutoCell.h
//  CellAutoHeight
//
//  Created by lijinyang on 16/8/3.
//  Copyright © 2016年 noveleven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *itemImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *subTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *contentLabel;

@end
