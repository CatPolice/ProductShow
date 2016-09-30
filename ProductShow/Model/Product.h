//
//  Product.h
//  ProductShow
//
//  Created by runlin on 16/9/29.
//  Copyright © 2016年 gavin. All rights reserved.
//

#import "JSONModel.h"
#import "APIManager.h"

@interface Product : JSONModel

//sellEdition = 1;
//storeCity = "\U5317\U4eac";
//storeEnabled = 1;
//storeName = "\U534e\U8d38\U8d2d\U7269\U4e2d\U5fc3";
//storeNumber = R479;

@property (nonatomic , copy) NSString *sellEdition;
@property (nonatomic , copy) NSString *storeCity;
@property (nonatomic , copy) NSString *storeEnabled;
@property (nonatomic , copy) NSString *storeName;
@property (nonatomic , copy) NSString *storeNumber;


+(NSURLSessionDataTask*)getProductList:(NSDictionary *)option
                            Success:(void (^)(NSURLSessionDataTask *task,NSArray *result))success
                            Failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failue;
@end
