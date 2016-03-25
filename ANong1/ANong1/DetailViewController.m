//
//  DetailViewController.m
//  ANong1
//
//  Created by PQ on 16/3/21.
//  Copyright (c) 2016年 QQ:1049976497. All rights reserved.
//

#import "DetailViewController.h"
#import "MyTableViewCell.h"
#import "NetHelpers.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController111.h"
@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong , nonatomic )NSArray *arr;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_tableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    [NetHelpers getWithURL:@"http://m.anong.com/products?hotRecommend=true&page=1" parameters:nil completionBlockHandler:^(NSDictionary *responseDic, NSError *error) {
        //NSLog(@"%@",responseDic);
        _arr = responseDic[@"products"];
        NSLog(@"%@",_arr);
        [_tableView reloadData];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    cell.nameLab.text = _arr[indexPath.row][@"seller_name"];
    cell.priceLab.text = [NSString stringWithFormat:@"￥%@",_arr[indexPath.row][@"price"]];
    cell.fruitNameLab.text  = _arr[indexPath.row][@"title"];
    cell.placeLab.text = _arr[indexPath.row][@"origin"];
    cell.xiaoLiangLab.text = [NSString stringWithFormat:@"销量 %@",_arr[indexPath.row][@"sales"]];
    cell.danJiaLab.text = [NSString stringWithFormat:@"[%@/斤]",_arr[indexPath.row][@"unifyPrice"]];
    cell.unitLab.text = [NSString stringWithFormat:@"/%@",_arr[indexPath.row][@"unit"]];
    
    
    NSString *urlStr = _arr[indexPath.row][@"seller_avatar"];
    NSString *urlStr1 = _arr[indexPath.row][@"picture"];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    [cell.fruitImage sd_setImageWithURL:[NSURL URLWithString:urlStr1]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    NSDictionary *dic = _arr[indexPath.row];
    NSString *ID = dic[@"id"];
    DetailViewController111 *detail = [[DetailViewController111 alloc] init];
    detail.IDNum = ID;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
