//
//  DetailTableViewCell.h
//  ANong1
//
//  Created by PQ on 16/3/23.
//  Copyright (c) 2016年 QQ:1049976497. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *GoodsName;
@property (weak, nonatomic) IBOutlet UILabel *placeLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *unitLab;
@property (weak, nonatomic) IBOutlet UILabel *salesLab;

@end
