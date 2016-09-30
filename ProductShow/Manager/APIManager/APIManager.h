//
//  APIManager.h
//  ProductShow
//
//  Created by runlin on 16/9/29.
//  Copyright © 2016年 gavin. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
@interface APIManager : AFHTTPSessionManager
+ (instancetype)sharedManager;

+ (NSURLSessionDataTask *)SafePOST:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

+ (NSURLSessionDataTask *)SafeGET:(NSString *)URLString
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

+ (void)reset;
@end
