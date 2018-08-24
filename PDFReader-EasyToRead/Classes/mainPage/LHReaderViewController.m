//
//  ViewController.m
//  obervePanDa
//
//  Created by liuhang on 17/4/17.
//  Copyright © 2017年 liuhang. All rights reserved.
//

#import "LHReaderViewController.h"
#import "LHNetworking.h"
#import "XCompareString.h"
#import "stationModel.h"
#import "stationNameCell.h"
#import "detailViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "AppDelegate.h"
#import "obervePage.h"
#import "settingPage.h"
#import <AVFoundation/AVFoundation.h>
#import "DetailModel.h"
static NSString *cellReuseIdentifier = @"stationNameCell";
@interface LHReaderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *numLB;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//字母数组
@property (nonatomic, strong) NSMutableArray *indexArray;
//分组数据数组
@property (nonatomic, strong) NSMutableArray *letterResultArr;
//排序数组
@property (nonatomic, strong) NSMutableArray *stringsToSort;
//数据字典
@property (nonatomic, strong) NSMutableDictionary *modelsDic;
//动态图片数组
@property (nonatomic, strong) NSMutableArray *imgsArr;
//imageView
@property (nonatomic, strong) UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UISwitch *oberverSwitch;
@property (nonatomic, strong) AppDelegate *delegate;
@end

@implementation LHReaderViewController
//懒加载
- (AppDelegate *)delegate {
    if (!_delegate) {
        _delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return _delegate;
}
- (NSMutableArray *)imgsArr {
    if (!_imgsArr) {
        _imgsArr = [[NSMutableArray alloc]init];
        for (NSInteger index = 1; index < 18; index++) {
            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",index]];
            [_imgsArr addObject:img];
        }
    }
    return _imgsArr;
}
- (NSMutableDictionary *)modelsDic {
    if (!_modelsDic) {
        _modelsDic = [[NSMutableDictionary alloc]init];
    }
    return _modelsDic;
}
-(NSMutableArray *)stringsToSort {
    if (!_stringsToSort) {
        _stringsToSort = [[NSMutableArray alloc]init];
    }
    return _stringsToSort;
}

-(NSMutableArray *)indexArray {
    if (!_indexArray) {
        _indexArray = [[NSMutableArray alloc]init];
    }
    return _indexArray;
}
-(NSMutableArray *)letterResultArr {
    if (!_letterResultArr) {
        _letterResultArr = [[NSMutableArray alloc]init];
    }
    return _letterResultArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    //实现按钮监听到时关闭
    __weak typeof(self) weakSelf = self;
    
    self.delegate.oberver.totalNumChanged = ^(NSInteger num) {
        weakSelf.numLB.text = [NSString stringWithFormat:@"监听次数:%ld",num];
    };
    
    self.delegate.oberver.changeBlock = ^(NSMutableArray *mArr,NSString *stationID) {
        weakSelf.oberverSwitch.on = !weakSelf.oberverSwitch.on;
        [weakSelf.delegate.player pause];
        NSArray * arr = [weakSelf.modelsDic allValues];
        //电量信息
        NSMutableString *mStr = [NSMutableString stringWithFormat:@"\n剩余电量:"];
        for (NSString *str in mArr) {
            [mStr appendString:[NSString stringWithFormat:@"%@   ",str]];
        }
        for (stationModel *model in arr) {
            if (model.ID == stationID) {
                //发出通知
                
                break;
            }
        }
    };
    [self setNavigationButton];
    //初始化tableView
    self.tableView.rowHeight = 50;
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    }];
}
//数据请求
- (void)getStations {
    self.view.userInteractionEnabled = NO;
    //获取所有站点
    NSString *urlwithStation = @"http://www.pand-auto.com/api/app?version=1.2.5";
    NSDictionary *bodyStation = @{@"header":@{@"service":@"getstations"},@"body":@{@"appversion":self.delegate.version,@"cityid":self.delegate.locationCode,@"station":@"1",@"apptype":@"ios",@"presetstation":@"0",@"chargingpile":@"0",@"presetchargingpile":@"0"}};
    NSData * jsonDataStation = [NSJSONSerialization dataWithJSONObject:bodyStation options:NSJSONWritingPrettyPrinted error:nil];
    
    NSMutableURLRequest *requestStation = [[LHNetworking shareInstance] requestWithUrl:urlwithStation];
    [requestStation setHTTPBody:jsonDataStation];
    
    NSURLSession*session = [NSURLSession sharedSession];
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask*taskStation = [session dataTaskWithRequest:requestStation completionHandler:^(NSData*_Nullable data,NSURLResponse*_Nullable response,NSError*_Nullable error) {
        if (!error) {
            [weakSelf.modelsDic removeAllObjects];
            [weakSelf.stringsToSort removeAllObjects];
            [weakSelf.letterResultArr removeAllObjects];
            NSDictionary *dictionary = [weakSelf dictionaryWithJsonString:data];
            NSDictionary *dic = dictionary[@"body"];
            NSArray *arr = dic[@"station"];
            for (NSDictionary *modelDic in arr) {
                stationModel *model = [stationModel provinceWithDictionary:modelDic];
                NSArray *oberives = [weakSelf.delegate.oberver allObervies];
                if ([oberives containsObject:model.ID]) {
                    model.isOberving = YES;
                }
                //添加到排序数组
                [weakSelf.stringsToSort addObject:model.stationname];
                [weakSelf.modelsDic setObject:model forKey:model.stationname];
            }
            //排序
            XCompareString *sortTool = [[XCompareString alloc]init];
            weakSelf.letterResultArr = [sortTool getDivideGroupsWithArray:weakSelf.stringsToSort];
            weakSelf.indexArray = sortTool.indexMArray;
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView.mj_header endRefreshing];
                //回调或者说是通知主线程刷新，
                [weakSelf.tableView reloadData];
                weakSelf.view.userInteractionEnabled = YES;
            });
            
        }else {
            settingPage *vc = [[settingPage alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    }];
    [taskStation resume];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.letterResultArr[section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.letterResultArr.count;
}
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.indexArray;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    stationNameCell *cell=[tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if(cell==nil){
        cell=[[stationNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
    }
    NSString *key = self.letterResultArr[indexPath.section][indexPath.row];
    stationModel *model = [self.modelsDic objectForKey:key];
    cell.model = model;
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = self.letterResultArr[indexPath.section][indexPath.row];
    stationModel *model = [self.modelsDic objectForKey:key];
    detailViewController *vc = [[detailViewController alloc]init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];    
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
- (void)setNavigationButton {
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:@"setting" style:UIBarButtonItemStylePlain target:self action:@selector(settingButtonClicked)];
    [self.navigationItem setLeftBarButtonItem:buttonItem];
    
    
    self.gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 25)];
    self.gifImageView.animationImages =self.imgsArr; //获取Gif图片列表
    self.gifImageView.animationDuration = 3;     //执行一次完整动画所需的时长
    self.gifImageView.animationRepeatCount = 0;  //动画重复次数
    
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:self.gifImageView];
    
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc]initWithTitle:@"list" style:UIBarButtonItemStylePlain target:self action:@selector(oberveRobotButtonClicked)];
    
    [self.navigationItem setRightBarButtonItems:@[rightItem2,rightItem1]];
}
- (void)settingButtonClicked {
    settingPage *vc = [[settingPage alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//监听开关
- (IBAction)oberverSwitch:(UISwitch *)sender {
    if (sender.on) {
        [self.delegate.oberver beginOberve];
        self.numLB.hidden = NO;
    }else {
        [self.delegate.oberver endOberve];
        self.numLB.hidden = YES;
        [self.delegate.oberver.hadObervedMDict removeAllObjects];
        self.delegate.oberver.totalNum = 0;
    }
}
//监听列表
- (void)oberveRobotButtonClicked {
    obervePage *vc = [[obervePage alloc]init];
    vc.statiosMDic = self.modelsDic;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)getDetail:(stationModel *)staModel {
    //获取站点数据
    NSString *urlwithDetail = @"http://www.pand-auto.com/api/app?version=1.2.5&client=ios&service=canordervehicles";
    NSDictionary *bodyDetail = @{@"header":@{@"service":@"canordervehicles"},@"body":@{@"apptype":@"ios",@"appversion":@"1.2.5",@"getstationid":staModel.ID}};
    NSData * jsonDataDetail = [NSJSONSerialization dataWithJSONObject:bodyDetail options:NSJSONWritingPrettyPrinted error:nil];
    
    NSMutableURLRequest *requestStation = [[LHNetworking shareInstance] requestWithUrl:urlwithDetail];
    [requestStation setHTTPBody:jsonDataDetail];
    
    NSURLSession*session = [NSURLSession sharedSession];
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionTask *taskStation = [session dataTaskWithRequest:requestStation completionHandler:^(NSData*_Nullable data,NSURLResponse*_Nullable response,NSError*_Nullable error) {
        if (!error) {
            //解析数据
            NSDictionary *dictionary = [weakSelf dictionaryWithJsonString:data];
            NSDictionary *bodyDic = dictionary[@"body"];
            NSArray *listArr = bodyDic[@"list"];
            for (NSDictionary *operatingdataDic in listArr) {
                NSString *license = operatingdataDic[@"license"];
                if ([license isEqualToString:@"渝D39271"]) {
                    NSLog(@"%@",staModel.stationname);
                }
            }
        }
    }];
    [taskStation resume];
}
@end
