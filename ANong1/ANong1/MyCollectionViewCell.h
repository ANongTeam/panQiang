//
//  MyCollectionViewCell.h
//  ANong1
//
//  Created by PQ on 16/3/21.
//  Copyright (c) 2016年 QQ:1049976497. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headName;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *fruitName;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UIImageView *fruitImage;

@end
