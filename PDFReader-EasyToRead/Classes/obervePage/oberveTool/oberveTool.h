//
//  oberveTool.h
//  obervePanDa
//
//  Created by liuhang on 17/4/19.
//  Copyright © 2017年 liuhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "stationModel.h"
@interface oberveTool : NSObject
//监听总次数
@property (nonatomic, assign) NSInteger totalNum;
//判断是否正在监听
@property (nonatomic,assign) BOOL isOn;
//监听频率 /秒
@property (nonatomic, assign) NSInteger rate;
//监听到变化使得block
@property (nonatomic, copy) void(^changeBlock)(NSMutableArray *mArr,NSString *ID);
//总次数改变了
@property (nonatomic, copy) void(^totalNumChanged)(NSInteger total);
//监听过程记录的数组（ID 为键，value为数组，数组中为该站点所有可用车的model）
@property (nonatomic, strong) NSMutableDictionary *hadObervedMDict;
//重置
- (void)reset;
//查看所有被监听的成员
- (NSArray *)allObervies;
//移除所有Obervies
- (void)removeAllObervies;
//添加被监听成员
- (void)addBeOberved:(stationModel *)stationModel;
//移除被监听成员
- (void)removeBeOberved:(stationModel *)stationModel;
//开始监听
- (void)beginOberve;
//停止监听
- (void)endOberve;
//单例创建
+ (instancetype)shareInstance;
@end
