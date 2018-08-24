//
//  stationModel.h
//  obervePanDa
//
//  Created by liuhang on 17/4/18.
//  Copyright © 2017年 liuhang. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface stationModel : NSObject
//记录是否已经被监听
@property (nonatomic, assign) BOOL isOberving;
//站点名称
@property (nonatomic, strong) NSString *stationname;
//站点ID
@property (nonatomic, strong) NSString *ID;
//可用车数量
@property (nonatomic, assign) NSInteger canusenum;
//用字典创建模型
+ (instancetype)provinceWithDictionary:(NSDictionary *)dict;
@end
