//
//  Product.m
//  ProductShow
//
//  Created by runlin on 16/9/29.
//  Copyright © 2016年 gavin. All rights reserved.
//

#import "Product.h"

@implementation Product
+(NSURLSessionDataTask*)getProductList:(NSDictionary *)option
                               Success:(void (^)(NSURLSessionDataTask *task,NSArray *result))success
                               Failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failue{
    
    return [APIManager SafeGET:@"CN/zh_CN/reserve/iPhone/stores.json" parameters:option success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *stores = [responseObject objectForKey:@"stores"];
        
        
        NSMutableArray *result = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in stores) {
            Product *product = [[Product alloc] initWithDictionary:dic error:nil];
            [result addObject:product];
        }
        
        
        
        
        success(task,[NSArray arrayWithArray:result]);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failue(task,error);
    }];

}
@end
