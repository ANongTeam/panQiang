//
//  NetHelpers.m
//  ANong1
//
//  Created by Mac on 16/3/21.
//  Copyright (c) 2016年 QQ:1049976497. All rights reserved.
//

#import "NetHelpers.h"

@implementation NetHelpers

///解析出来为字典
+ (void)getWithURL:(NSString *)urlStr parameters:(NSString *)paramsStr completionBlockHandler:(void(^)(NSDictionary *responseDic, NSError *error)) completionBlock
{
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        completionBlock(dic,connectionError);
        
    }];
    
}
+ (void)getWithURL1:(NSString *)urlStr parameters:(NSString *)paramsStr completionBlockHandler:(void(^)(NSDictionary *responseDic, NSError *error)) completionBlock
{
    NSString *str = [NSString stringWithFormat:@"http://m.anong.com/products/%@",paramsStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        completionBlock(dic,connectionError);
        
    }];
}

+ (void)getWithURL:(NSString *)urlStr parameters:(NSString *)paramsStr andCompletionBlockHandler:(void(^)(NSArray *arr, NSError *error)) completionBlock
{
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        completionBlock(arr,connectionError);
        
    }];
    
}
+(void)postWithURL:(NSString *)URLStr parameters:(NSString *)paraStr completionBlockHandler:(void(^)(NSDictionary *responseDic,NSError *error))completionBlock{
    NSURL *url=[NSURL URLWithString:URLStr];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod=@"POST";
    //NSMutableString *dataStr=@" ";
    NSData *data=[paraStr dataUsingEncoding:NSUTF8StringEncoding];
    
    request.HTTPBody=data;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        completionBlock(dic,connectionError);
        
    }];
}

@end
