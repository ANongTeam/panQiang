//
//  ShoppingCarViewController.m
//  ANong
//
//  Created by PQ on 16/3/21.
//  Copyright (c) 2016年 QQ:1049976497. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "MyCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"
#import "DetailViewController.h"
#import "NetHelpers.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController111.h"
@interface ShoppingCarViewController ()<UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *arr;
@end

@implementation ShoppingCarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [NetHelpers getWithURL:@"http://m.anong.com/products/hotRecommendCart" parameters:nil andCompletionBlockHandler:^(NSArray *arr, NSError *error) {
        _arr = arr;
        //NSLog(@"%@----%@",_arr,error);
        [_collectionView reloadData];
    }];
    
}
- (IBAction)GotoDetail:(UIButton *)sender {
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HeaderCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    return reusableView;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    NSDictionary *dic = _arr[indexPath.item];
    cell.name.text = dic[@"seller_name"];
    cell.fruitName.text = dic[@"title"];
    cell.price.text = [NSString stringWithFormat:@"￥%@",dic[@"price"]];
    cell.place.text = dic[@"origin"];
    NSString *urlStr = dic[@"seller_avatar"];
    NSString *urlStrFruit = dic[@"picture"];
    [cell.headName sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    [cell.fruitImage sd_setImageWithURL:[NSURL URLWithString:urlStrFruit]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.item);
    NSDictionary *dic = _arr[indexPath.item];
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
