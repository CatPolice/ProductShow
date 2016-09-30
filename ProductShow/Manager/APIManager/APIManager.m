//
//  APIManager.m
//  ProductShow
//
//  Created by runlin on 16/9/29.
//  Copyright © 2016年 gavin. All rights reserved.
//
#import "APIManager.h"
#import "AFSecurityPolicy.h"
#import "NSDictionary+JSONString.h"

static dispatch_once_t onceToken;
static APIManager *_sharedManager = nil;

@implementation APIManager
+ (instancetype)sharedManager {
    
    dispatch_once(&onceToken, ^{
        //设置服务器根地址
        _sharedManager = [[APIManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://reserve.cdn-apple.com/"]];
        
        [_sharedManager setSecurityPolicy:[AFSecurityPolicy defaultPolicy]];
        _sharedManager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(100, 500)];
        
        //发送json数据
        _sharedManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //响应json数据
        _sharedManager.responseSerializer  = [AFJSONResponseSerializer serializer];
        
        //设置头
//        [_sharedManager.requestSerializer setValue:"audi" forHTTPHeaderField:@"name"];
        
        _sharedManager.responseSerializer.acceptableContentTypes =  [_sharedManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml",nil]];
        
    });
    
    return _sharedManager;
}


+ (NSURLSessionDataTask *)SafePOST:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{
    APIManager *manager = [APIManager sharedManager];
    //todo 统一封装请求参数
    NSLog(@"client request POST interface:%@",URLString);
    NSLog(@"client request POST JSON:\n%@",[parameters?:@{} JSONStringValue]);
    
    return [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"server respone  JSON:\n%@",[responseObject JSONStringValue]);

        //todo 统一处理响应数据
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error respone :\n%@",[error debugDescription]);
         if(error.code == NSURLErrorCancelled)
        {
            NSLog(@"请求被取消");
        }
        //todo 统一处理错误
        failure(task,error);
    }];
}
+ (NSURLSessionDataTask *)SafeGET:(NSString *)URLString
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{
    APIManager *manager = [APIManager sharedManager];
    NSLog(@"client request POST interface:%@",URLString);
    NSLog(@"client request POST JSON:\n%@",[parameters?:@{} JSONStringValue]);
    
    return [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"server respone  JSON:\n%@",[responseObject JSONStringValue]);
        //todo
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo
        if(error.code == NSURLErrorCancelled)
        {
            NSLog(@"请求被取消");
        }
        failure(task,error);
    }];
}

//设置ip要重置单例 生效
+ (void)reset {
    _sharedManager = nil;
    onceToken = 0;
}
@end
