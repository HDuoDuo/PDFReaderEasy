
//
//  detailViewController.m
//  obervePanDa
//
//  Created by liuhang on 17/4/18.
//  Copyright © 2017年 liuhang. All rights reserved.
//

#import "detailViewController.h"
#import "LHNetworking.h"
#import "detailTableViewCell.h"
#import "DetailModel.h"
#import <MJRefresh/MJRefresh.h>
#import "AppDelegate.h"
static NSString *cellIdentifier=@"detailTableViewCell";
@interface detailViewController ()<UITabBarDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSURLSessionDataTask*taskStation;
@end

@implementation detailViewController
//懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.stationname;
    //设置buttonItem
    [self setRightNavigationButton:self.model.isOberving];
    //初始化tableView
    self.tableView.rowHeight = 80;
    //下拉刷新
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.view.userInteractionEnabled = NO;
    }];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView registerNib:[UINib nibWithNibName:@"detailTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
}

- (void)getDetail {
    //获取站点数据
    NSString *urlwithDetail = @"http://www.pand-auto.com/api/app?version=1.2.5";
    NSDictionary *bodyDetail = @{@"header":@{@"service":@"canordervehicles"},@"body":@{@"apptype":@"ios",@"appversion":@"1.2.5",@"getstationid":self.model.ID}};
    NSData * jsonDataDetail = [NSJSONSerialization dataWithJSONObject:bodyDetail options:NSJSONWritingPrettyPrinted error:nil];
    
    NSMutableURLRequest *requestStation = [[LHNetworking shareInstance] requestWithUrl:urlwithDetail];
    [requestStation setHTTPBody:jsonDataDetail];
    
    NSURLSession*session = [NSURLSession sharedSession];
    
    __weak typeof(self) weakSelf = self;
    self.taskStation = [session dataTaskWithRequest:requestStation completionHandler:^(NSData*_Nullable data,NSURLResponse*_Nullable response,NSError*_Nullable error) {
        if (!error) {
            //解析数据
            [weakSelf.dataArray removeAllObjects];
            NSDictionary *dictionary = [weakSelf dictionaryWithJsonString:data];
            NSDictionary *bodyDic = dictionary[@"body"];
            NSArray *listArr = bodyDic[@"list"];
            for (NSDictionary *operatingdataDic in listArr) {
                DetailModel *model = [DetailModel provinceWithDictionary:operatingdataDic];
                [weakSelf.dataArray addObject:model];
            }
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                [weakSelf.tableView.mj_header endRefreshing];
                [weakSelf.tableView reloadData];
                weakSelf.view.userInteractionEnabled = YES;
            });
        }
    }];
    [self.taskStation resume];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%ld",self.dataArray.count);
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    detailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    DetailModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
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
- (void)setRightNavigationButton:(BOOL)isOberve {
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(navButtonClicked:)];
    if (isOberve) {
        buttonItem.title = @"取消监听";
    }else {
        buttonItem.title = @"加入监听";
    }
    [self.navigationItem setRightBarButtonItem:buttonItem];
}
//加入监听
- (void)navButtonClicked:(UIBarButtonItem *)sender {
    self.model.isOberving = !self.model.isOberving;
    AppDelegate *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    //点击切换
    if (self.model.isOberving) {
        sender.title = @"取消监听";
        //加入监听器
         [appDelegate.oberver addBeOberved:self.model];
    }else {
        sender.title = @"加入监听";
        //从监听器中移除
        [appDelegate.oberver removeBeOberved:self.model];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.dataArray removeAllObjects];
    [self.taskStation cancel];
    
}
@end
