//
//  stationModel.m
//  obervePanDa
//
//  Created by liuhang on 17/4/18.
//  Copyright © 2017年 liuhang. All rights reserved.
//

#import "stationModel.h"

@implementation stationModel
//创建模型
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)provinceWithDictionary:(NSDictionary *)dict

{
    return [[self alloc] initWithDictionary:dict];
}
//处理未知的key
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
        self.isOberving = NO;
    }
}
@end
