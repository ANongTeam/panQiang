//
//  MyTableViewCell.h
//  ANong1
//
//  Created by PQ on 16/3/21.
//  Copyright (c) 2016年 QQ:1049976497. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *fruitImage;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *placeLab;
@property (weak, nonatomic) IBOutlet UILabel *fruitNameLab;
@property (weak, nonatomic) IBOutlet UILabel *xiaoLiangLab;
@property (weak, nonatomic) IBOutlet UILabel *danJiaLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *unitLab;


@end
