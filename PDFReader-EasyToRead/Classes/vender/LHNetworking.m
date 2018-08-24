//
//  LHNetworking.m
//  LHNetWorking
//
//  Created by liuhang on 16/11/16.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import "LHNetworking.h"

@implementation LHNetworking
//懒加载
- (NSMutableURLRequest *)requestWithUrl:(NSString *)url {
    NSURL *urlstring = [NSURL URLWithString:url];
    
    NSMutableURLRequest*request = [NSMutableURLRequest requestWithURL:urlstring];
    
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    [request setHTTPMethod:@"POST"];
    
    return request;
}
//创建单例方法
+ (LHNetworking *)shareInstance {
    static LHNetworking *networkingManager = nil;
    static dispatch_once_t onceToken;
    if (networkingManager == nil) {
        dispatch_once(&onceToken, ^{
            networkingManager = [[self alloc]init];
        });
    }
    return networkingManager;
}
@end
