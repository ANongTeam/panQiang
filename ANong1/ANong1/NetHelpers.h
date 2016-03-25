//
//  NetHelpers.h
//  ANong1
//
//  Created by Mac on 16/3/21.
//  Copyright (c) 2016年 QQ:1049976497. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetHelpers : NSObject

///解析出来是字典
+ (void)getWithURL:(NSString *)urlStr parameters:(NSString *)paramsStr completionBlockHandler:(void(^)(NSDictionary *responseDic, NSError *error)) completionBlock;
+ (void)getWithURL1:(NSString *)urlStr parameters:(NSString *)paramsStr completionBlockHandler:(void(^)(NSDictionary *responseDic, NSError *error)) completionBlock;
///解析出来是数组
+ (void)getWithURL:(NSString *)urlStr parameters:(NSString *)paramsStr andCompletionBlockHandler:(void(^)(NSArray *arr, NSError *error)) completionBlock;

+(void)postWithURL:(NSString *)URLStr parameters:(NSString *)paraStr completionBlockHandler:(void(^)(NSDictionary *responseDic,NSError *error))completionBlock;

@end
