//
//  LHNetworking.h
//  LHNetWorking
//
//  Created by liuhang on 16/11/16.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
@interface LHNetworking : NSObject
- (NSMutableURLRequest *)requestWithUrl:(NSString *)url;
+ (LHNetworking *)shareInstance;
@end
