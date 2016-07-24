//
//  TableViewController.m
//  AutoLayoutTableHeaderView
//
//  Created by 梁兴胜 on 16/7/24.
//  Copyright © 2016年 Loyt. All rights reserved.
//

#import "TableViewController.h"
#import "Masonry.h"

@interface TableViewController ()
@property (nonatomic, weak) UIView *myTableHeaderView;
@property (nonatomic, strong) UIImageView *myImageView;
@property (nonatomic, strong) UIView *myContentLabel;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    //
    [self setupTableHeaderView];
}


-(void)setupTableHeaderView{
    
    UIView *myTableHeaderView = [[UIView alloc] init];
    myTableHeaderView.backgroundColor = [UIColor purpleColor];
    self.myTableHeaderView = myTableHeaderView;
    
    [myTableHeaderView addSubview:self.myImageView];
    [myTableHeaderView addSubview:self.myContentLabel];
    
    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(myTableHeaderView).mas_offset(5);
        make.centerX.mas_equalTo(myTableHeaderView);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.myContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.myImageView.mas_bottom).mas_offset(5);
        make.width.mas_equalTo(myTableHeaderView);
        make.bottom.mas_equalTo(myTableHeaderView).mas_offset(-5);
    }];
    
    
    [self.tableView beginUpdates];
    [self.tableView setTableHeaderView:myTableHeaderView];
    [self.tableView endUpdates];
    
    //下面这部分很关键,重新布局获取最新的frame,然后赋值给myTableHeaderView
    [myTableHeaderView setNeedsLayout];
    [myTableHeaderView layoutIfNeeded];
    CGSize size = [myTableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGRect headerFrame = myTableHeaderView.frame;
    headerFrame.size.height = size.height;
    myTableHeaderView.frame = headerFrame;
    
    self.tableView.tableHeaderView = myTableHeaderView;
}

-(UIImageView *)myImageView{
    
    if (!_myImageView) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sweet"]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        _myImageView = imageView;
    }
    return _myImageView;
}

-(UIView *)myContentLabel{
    
    if (!_myContentLabel) {
        
        UILabel *label = [[UILabel alloc] init];
        NSString *str = @"锄禾日当午，\n汗滴禾下土。\n谁念盘中餐，\n粒粒皆辛苦。\n";
        [label setText:str];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont systemFontOfSize:15]];
        [label setTextColor:[UIColor greenColor]];
        [label setNumberOfLines:0];
        
        _myContentLabel = label;
    }
    return _myContentLabel;
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
