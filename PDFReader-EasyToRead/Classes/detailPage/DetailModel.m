//
//  DetailModel.m
//  obervePanDa
//
//  Created by liuhang on 17/4/18.
//  Copyright © 2017年 liuhang. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel
//创建模型
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        NSDictionary *operatingDict = dict[@"operatingdata"];
        [self setValuesForKeysWithDictionary:operatingDict];
        //车型
        NSDictionary *tempDic = dict[@"vehicletype"];
        NSInteger num = [tempDic[@"rooms"] integerValue];
        self.rooms = num;
    }
    return self;
}
+ (instancetype)provinceWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"dcdl"]) {
        self.dcdl = [NSString stringWithFormat:@"%.f%%",[value floatValue]*100];
        return;
    }
    [super setValue:value forKey:key];
}
//处理未知的key
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
