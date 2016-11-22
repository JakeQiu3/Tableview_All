
//
//  XibTablleViewController.m
//  tableview使用大全
//
//  Created by 邱少依 on 2016/11/22.
//  Copyright © 2016年 QSY. All rights reserved.
//

//
//  ViewController.m
//  CellAutoHeight
//
//  Created by lijinyang on 16/8/2.
//  Copyright © 2016年 noveleven. All rights reserved.
//

#import "XibTablleViewController.h"
#import "UIImageView+WebCache.h"
#import "AutoCell.h"
static NSString *const qsyCellIdentifier = @"AutoCellIdentifier";

@interface XibTablleViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;//数据源数组
@property (nonatomic, strong) UITableViewCell *cellKeeper;//持有一个cell
@end

@implementation XibTablleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setData];
    [self setUI];
}

- (void)setUI {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    // 注册cell:[import]:
    [_tableView registerNib:[UINib nibWithNibName:@"AutoCell" bundle:nil] forCellReuseIdentifier:qsyCellIdentifier];
//    必须register后再根据AutoCellIdentifier获取UItableViewCell，要不然会失败
    _cellKeeper  = [_tableView dequeueReusableCellWithIdentifier:qsyCellIdentifier];
}

- (void)setData {
    _dataSource = @[@{@"image":@"https://upload.wikimedia.org/wikipedia/en/3/37/Calabashbrothers.jpg",
                      @"title":@"Calabash Brothers",
                      @"sub":@"1080P",
                      @"content":@"Calabash Brothers is a Chinese animation TV series produced by Shanghai Animation Film Studio. It is also referred to as Bottle Gourd Brothers, Hulu Brothers, Seven Brothers and Pumpkin Brothers. In China, the series is popularly known as Huluwa."},
                    
                    @{@"image":@"http://images.china.cn/attachement/jpg/site1000/20131016/d02788e9b6cd13c89d2223.jpg",
                      @"title":@"Journey to the West.",
                      @"sub":@"1080P",
                      @"content":@"Journey to the West is a Chinese novel published in the 16th century during the Ming dynasty and attributed to Wu Cheng'en. It is one of the Four Great Classical Novels of Chinese literature. In English-speaking countries, the work is widely known as Monkey, the title of Arthur Waley's popular abridged translation."},
                    @{@"image":@"http://images.china.cn/attachement/jpg/site1000/20131016/d02788e9b6cd13c89d2223.jpg",
                      @"title":@"Journey to the West.",
                      @"sub":@"1080P",
                      @"content":@"Journey to the West is a Chinese novel published in the 16th century during the Ming dynasty and attributed to Wu Cheng'en. It is one of the Four Great Classical Novels of Chinese literature. In English-speaking countries, the work is widely known as Monkey, the title of Arthur Waley's popular abridged translation."},
                    @{@"image":@"http://images.china.cn/attachement/jpg/site1000/20131016/d02788e9b6cd13c89d2223.jpg",
                      @"title":@"Journey to the West.",
                      @"sub":@"1080P",
                      @"content":@"Journey to the West is a Chinese novel published in the 16th century during the Ming dynasty and attributed to Wu Cheng'en. It is one of the Four Great Classical Novels of Chinese literature. In English-speaking countries, the work is widely known as Monkey, the title of Arthur Waley's popular abridged translation."},
                    @{@"image":@"http://images.china.cn/attachement/jpg/site1000/20131016/d02788e9b6cd13c89d2223.jpg",
                      @"title":@"Journey to the West.",
                      @"sub":@"1080P",
                      @"content":@"Journey to the West is a Chinese novel published in the 16th century during the Ming dynasty and attributed to Wu Cheng'en. It is one of the Four Great Classical Novels of Chinese literature. In English-speaking countries, the work is widely known as Monkey, the title of Arthur Waley's popular abridged translation."},
                    @{@"image":@"http://images.china.cn/attachement/jpg/site1000/20131016/d02788e9b6cd13c89d2223.jpg",
                      @"title":@"Journey to the West.",
                      @"sub":@"1080P",
                      @"content":@"Journey to the West is a Chinese novel published in the 16th century during the Ming dynasty and attributed to Wu Cheng'en. It is one of the Four Great Classical Novels of Chinese literature. In English-speaking countries, the work is widely known as Monkey, the title of Arthur Waley's popular abridged translation."},
                    @{@"image":@"http://images.china.cn/attachement/jpg/site1000/20131016/d02788e9b6cd13c89d2223.jpg",
                      @"title":@"Journey to the West.",
                      @"sub":@"1080P",
                      @"content":@"Journey to the West is a Chinese novel published in the 16th century during the Ming dynasty and attributed to Wu Cheng'en. It is one of the Four Great Classical Novels of Chinese literature. In English-speaking countries, the work is widely known as Monkey, the title of Arthur Waley's popular abridged translation."},
                    @{@"image":@"https://upload.wikimedia.org/wikipedia/en/3/37/Calabashbrothers.jpg",
                      @"title":@"Calabash Brothers",
                      @"sub":@"1080P",
                      @"content":@"Calabash Brothers is a Chinese animation TV series produced by Shanghai Animation Film Studio. It is also referred to as Bottle Gourd Brothers, Hulu Brothers, Seven Brothers and Pumpkin Brothers. In China, the series is popularly known as Huluwa."},
                    @{@"image":@"https://upload.wikimedia.org/wikipedia/en/3/37/Calabashbrothers.jpg",
                      @"title":@"Calabash Brothers",
                      @"sub":@"1080P",
                      @"content":@"Calabash Brothers is a Chinese animation TV series produced by Shanghai Animation Film Studio. It is also referred to as Bottle Gourd Brothers, Hulu Brothers, Seven Brothers and Pumpkin Brothers. In China, the series is popularly known as Huluwa."},
                    @{@"image":@"https://upload.wikimedia.org/wikipedia/en/3/37/Calabashbrothers.jpg",
                      @"title":@"Calabash Brothers",
                      @"sub":@"1080P",
                      @"content":@"Calabash Brothers is a Chinese animation TV series produced by Shanghai Animation Film Studio. It is also referred to as Bottle Gourd Brothers, Hulu Brothers, Seven Brothers and Pumpkin Brothers. In China, the series is popularly known as Huluwa."},
                    @{@"image":@"https://upload.wikimedia.org/wikipedia/en/3/37/Calabashbrothers.jpg",
                      @"title":@"Calabash Brothers",
                      @"sub":@"1080P",
                      @"content":@"Calabash Brothers is a Chinese animation TV series produced by Shanghai Animation Film Studio. It is also referred to as Bottle Gourd Brothers, Hulu Brothers, Seven Brothers and Pumpkin Brothers. In China, the series is popularly known as Huluwa."}
                    ];
}
#pragma mark tableview的delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AutoCell *cell = [tableView dequeueReusableCellWithIdentifier:qsyCellIdentifier];
    // 配置cell
    NSDictionary *dict = _dataSource[indexPath.row];
//    [cell.itemImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]] placeholderImage:[UIImage imageNamed:@""]];
    [cell.itemImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    cell.titleLabel.text = dict[@"title"];
    cell.subTitleLabel.text = dict[@"sub"];
    cell.contentLabel.text = dict[@"content"];//内容的自适应
    
    return cell;
}

#pragma mark 设置cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取该控制器持有的cell 为 自定义的cell
    AutoCell *cell = (AutoCell *)self.cellKeeper;
    NSDictionary *dict = _dataSource[indexPath.row];
    cell.contentLabel.text = dict[@"content"];
    
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));/* get corrent size, important to `systemLayoutSizeFittingSize:` */
    [cell layoutIfNeeded];/* important */
    
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return 1  + size.height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

@end
