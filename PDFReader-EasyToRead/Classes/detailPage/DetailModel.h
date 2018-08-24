//
//  DetailModel.h
//  obervePanDa
//
//  Created by liuhang on 17/4/18.
//  Copyright © 2017年 liuhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject
//车型
@property (nonatomic, assign) NSInteger rooms;
//剩余电量
@property (nonatomic, strong) NSString *dcdl;
//剩余里程
@property (nonatomic, strong) NSString *xhlc;
//用字典创建模型
+ (instancetype)provinceWithDictionary:(NSDictionary *)dict;
@end
