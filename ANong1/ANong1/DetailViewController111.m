//
//  DetailViewController111.m
//  ANong1
//
//  Created by PQ on 16/3/23.
//  Copyright (c) 2016年 QQ:1049976497. All rights reserved.
//

#import "DetailViewController111.h"
#import <SDCycleScrollView.h>
#import "NetHelpers.h"
#import "DetailTableViewCell.h"
#import "SendDetailTableViewCell.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "ContentTableViewCell.h"
#import "ImageTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface DetailViewController111 ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)NSDictionary *dic;
@property (strong, nonatomic)NSMutableArray *contentArr;
@property (strong, nonatomic)NSMutableArray *imgArr;
@property (strong, nonatomic)NSArray *titleArr;
@property (strong, nonatomic)NSDictionary *detailDic;
@end

@implementation DetailViewController111

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _titleArr = [[NSArray alloc] initWithObjects:@"identification",@"more",@"nutrition",@"origin",@"pick",@"produce" ,nil];
    [_tableView registerNib:[UINib nibWithNibName:@"ScollerViewCell" bundle:nil] forCellReuseIdentifier:@"ScollerViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"DetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"DetailTableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"SendDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"SendDetailTableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"ContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"ContentTableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"ImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"ImageTableViewCell"];
    [NetHelpers getWithURL1:nil parameters:_IDNum completionBlockHandler:^(NSDictionary *responseDic, NSError *error) {
        //NSLog(@"%@",responseDic);
        _dic = responseDic;
        [_tableView reloadData];
    }];
    NSString *patameterStr = [NSString stringWithFormat:@"%@/detail",_IDNum];
    [NetHelpers getWithURL1:nil parameters:patameterStr completionBlockHandler:^(NSDictionary *responseDic, NSError *error) {
        _detailDic = responseDic[@"detail"];
        //NSLog(@"identification:%@",dic);
        _contentArr = [[NSMutableArray alloc] init];
        _imgArr = [[NSMutableArray alloc] init];
        [_detailDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSString *str = obj;
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            TFHpple *tf = [[TFHpple alloc] initWithHTMLData:data];
            NSArray *arr1 = [tf searchWithXPathQuery:@"//p"];
            NSArray *arr = [tf searchWithXPathQuery:@"//img"];
            for (TFHppleElement *ele in arr1) {
                //NSLog(@"%@",ele.content);
                if (ele.content) {
                    [_contentArr addObject:ele.content];
                }
            }
            for (TFHppleElement *ele in arr) {
                NSDictionary *dic = [ele attributes];
                //NSLog(@"%@",dic[@"src"]);
                if (dic[@"src"]) {
                    [_imgArr addObject:dic[@"src"]];
                }
            }
        }];
    }];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return _contentArr.count+_imgArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 250;
        }else if(indexPath.row == 1)
        {
            return 77;
        }else{
            CGFloat width = [UIScreen mainScreen].bounds.size.width - 8;
            NSString *str = _dic[@"notification"];
            CGRect rect = [str boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:10]} context:nil];
            rect.size.height = rect.size.height>24?rect.size.height:24;
            
            return rect.size.height + 20;
        }
    }else{
        return 70;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ScollerViewCell" forIndexPath:indexPath];
            NSArray *picArr = _dic[@"pictures"];
            SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, cell.frame.size.width, 250) delegate:nil placeholderImage:nil];
            scrollView.imageURLStringsGroup = picArr;
            scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
            [cell addSubview:scrollView];
        }
        else if(indexPath.row == 1){
            cell = [tableView dequeueReusableCellWithIdentifier:@"DetailTableViewCell" forIndexPath:indexPath];
           DetailTableViewCell *theCell = (DetailTableViewCell *)cell;
            theCell.priceLab.text = [NSString stringWithFormat:@"￥%@",_dic[@"price"]];
            theCell.placeLab.text = [NSString stringWithFormat:@"来自%@",_dic[@"origin"]];
            theCell.GoodsName.text = _dic[@"title"];
            theCell.unitLab.text =_dic[@"unit"];
            theCell.salesLab.text =[NSString stringWithFormat:@"销量：%@",_dic[@"sales"]] ;
            return theCell;
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"SendDetailTableViewCell" forIndexPath:indexPath];
            SendDetailTableViewCell *theCell = (SendDetailTableViewCell *)cell;
            theCell.contentLab.text =  _dic[@"notification"];
           // NSLog(@"%@",_dic[@"notification"]);
        }
    }
    if (indexPath.section == 1) {
        NSString *key = _titleArr[0];
        NSString *str = _detailDic[key];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        TFHpple *tf = [[TFHpple alloc] initWithHTMLData:data];
        NSArray *arr1 = [tf searchWithXPathQuery:@"//p"];
        NSArray *arr = [tf searchWithXPathQuery:@"//img"];
        for (TFHppleElement *ele in arr1) {
            if (ele.content) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"ContentTableViewCell" forIndexPath:indexPath];
                ContentTableViewCell *theCell = (ContentTableViewCell *)cell;
                theCell.contentLab.text = ele.content;
                return theCell;
            }
        }
        for (TFHppleElement *ele in arr) {
            NSDictionary *dic = [ele attributes];
            //NSLog(@"%@",dic[@"src"]);
            if (dic[@"src"]) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"ImageTableViewCell" forIndexPath:indexPath];
                ImageTableViewCell *theCell = (ImageTableViewCell *)cell;
                [theCell.imgView sd_setImageWithURL:[NSURL URLWithString:dic[@"src"]]];
                return theCell;
            }
        }
    }
    return cell;
}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
