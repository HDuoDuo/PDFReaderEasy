//
//  oberveTool.m
//  obervePanDa
//
//  Created by liuhang on 17/4/19.
//  Copyright © 2017年 liuhang. All rights reserved.
//

#import "oberveTool.h"
#import "LHNetworking.h"
#import "DetailModel.h"
@interface oberveTool ()
//被监听成员数组
@property (nonatomic, strong) NSMutableArray *obervedArr;
//timer
@property (nonatomic, strong) NSTimer *timer;
@end
@implementation oberveTool
//懒加载
- (NSMutableDictionary *)hadObervedMDict {
    if (!_hadObervedMDict) {
        _hadObervedMDict = [[NSMutableDictionary alloc]init];
    }
    return _hadObervedMDict;
}
- (NSMutableArray *)obervedArr {
    if (!_obervedArr) {
        NSArray *arr = [[NSUserDefaults standardUserDefaults]objectForKey:@"obervedArr"];
        _obervedArr = [NSMutableArray arrayWithArray:arr];
    }
    return  _obervedArr;
}
- (NSTimer *)timer {
    if (!_timer) {
        self.timer = [NSTimer timerWithTimeInterval:self.rate target:self selector:@selector(loopGetData) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}
//重置
- (void)reset {
    [self.timer invalidate];
    self.timer = nil;
    if (self.isOn) {
        [self beginOberve];
    }    
}
+(instancetype)shareInstance {
    //创建单例方法
    static oberveTool *oberve = nil;
    static dispatch_once_t onceToken;
    if (oberve == nil) {
        dispatch_once(&onceToken, ^{
            oberve = [[self alloc]init];
        });
    }
    return oberve;
}
//查询所有被监听成员
- (NSArray *)allObervies {
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"obervedArr"];
    return arr;
}
- (void)removeAllObervies {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"obervedArr"];
    [self.obervedArr removeAllObjects];
    [self.hadObervedMDict removeAllObjects];
}
//添加被监听成员
- (void)addBeOberved:(stationModel *)stationModel {
    if (![self.obervedArr containsObject:stationModel.ID]) {
        [self.obervedArr addObject:stationModel.ID];
        //添加到本地
        [[NSUserDefaults standardUserDefaults] setObject:self.obervedArr forKey:@"obervedArr"];
    }
}
//移除被监听成员
- (void)removeBeOberved:(stationModel *)stationModel {
    if ([self.obervedArr containsObject:stationModel.ID]) {
        [self.obervedArr removeObject:stationModel.ID];
        [self.hadObervedMDict removeObjectForKey:stationModel.ID];
        //添加到本地
        [[NSUserDefaults standardUserDefaults] setObject:self.obervedArr forKey:@"obervedArr"];
    }
}
//监听到变化
- (void)hadChange:(NSMutableArray *)mArr withID:(NSString *)ID {
    // 关闭监听
    [self endOberve];
    //切换监听按钮
    if (self.changeBlock) {
        self.changeBlock(mArr,ID);
    }
}
-(void)beginOberve {
    [self.timer setFireDate:[NSDate distantPast]];
    self.isOn = YES;
}
//停止监听
- (void)endOberve {
    [self.timer setFireDate:[NSDate distantFuture]];
    self.isOn = NO;
}
//循环获取数据
- (void)loopGetData {
    self.totalNum++;
    //串行队列
    dispatch_queue_t singal =  dispatch_queue_create("singal", DISPATCH_QUEUE_SERIAL);
    __weak typeof(self) weakSelf = self;
    dispatch_async(singal, ^{
        for (NSString *index in weakSelf.obervedArr) {
            [index stringByAppendingString:@""];
        }
    });
    
}
//获取数据
- (void)getData:(NSString *)ID {
    //获取站点数据
    NSString *urlwithDetail = @"http://www.pand-auto.com/api/app?version=1.2.5&client=ios&service=canordervehicles";
    NSDictionary *bodyDetail = @{@"header":@{@"service":@"canordervehicles"},@"body":@{@"apptype":@"ios",@"appversion":@"1.2.5",@"getstationid":ID}};
    NSData * jsonDataDetail = [NSJSONSerialization dataWithJSONObject:bodyDetail options:NSJSONWritingPrettyPrinted error:nil];
    
    NSMutableURLRequest *requestStation = [[LHNetworking shareInstance] requestWithUrl:urlwithDetail];
    [requestStation setHTTPBody:jsonDataDetail];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:requestStation returningResponse:nil error:nil];
    //解析数据
    NSDictionary *dictionary = [self dictionaryWithJsonString:data];
    NSDictionary *bodyDic = dictionary[@"body"];
    NSArray *listArr = bodyDic[@"list"];
    //判断可用车辆有没有增加
    NSMutableArray *modelsMArr = (NSMutableArray *)[self.hadObervedMDict objectForKey:ID];
    NSInteger arrCount = modelsMArr ? modelsMArr.count : 0;
    if (listArr.count > arrCount) {
        NSMutableArray *mArray = [self changedHadObervedMDict:listArr withID:ID];
        //通知主线程刷新
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [weakSelf hadChange:mArray withID:ID];
        });
        return;
    }
    if (listArr.count < arrCount) {
        [self changedHadObervedMDict:listArr withID:ID];
    }
}
//改变hadObervedMDict
- (NSMutableArray *)changedHadObervedMDict:(NSArray *)arr withID:(NSString *)ID{
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    for (NSDictionary *operatingdataDic in arr) {
        DetailModel *model = [DetailModel provinceWithDictionary:operatingdataDic];
        [mArray addObject:model.dcdl];
    }
    [self.hadObervedMDict setObject:mArray forKey:ID];
    return mArray;
}

//json 解析
- (NSDictionary *)dictionaryWithJsonString:(id)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonString options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}
- (void)setTotalNum:(NSInteger)totalNum {
    _totalNum = totalNum;
    if (self.totalNumChanged) {
        self.totalNumChanged(_totalNum);
    }
}
@end
