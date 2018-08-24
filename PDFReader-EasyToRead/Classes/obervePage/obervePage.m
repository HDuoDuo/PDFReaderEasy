//
//  obervePage.m
//  obervePanDa
//
//  Created by liuhang on 17/4/20.
//  Copyright © 2017年 liuhang. All rights reserved.
//

#import "obervePage.h"
#import "oberveCell.h"
#import "AppDelegate.h"
#import "stationModel.h"
#import "AppDelegate.h"
#import <SVProgressHUD/SVProgressHUD.h>
static NSString *cellReuseIdentifier = @"oberveCell";
@interface obervePage ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) AppDelegate *delegate;
@end

@implementation obervePage
//懒加载
- (AppDelegate *)delegate {
    if (!_delegate) {
        _delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return  _delegate;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return  _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"oberveList";
    
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc]initWithTitle:@"removeAll" style:UIBarButtonItemStylePlain target:self action:@selector(removeAll)];
    
    [self.navigationItem setRightBarButtonItem:rightItem2];

    //初始化tableView
    self.tableView.rowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:cellReuseIdentifier bundle:nil] forCellReuseIdentifier:cellReuseIdentifier];
    [self getData];
}
- (void)removeAll {
    for (stationModel *model in self.dataArray) {
        model.isOberving = NO;
    }
    [self.dataArray removeAllObjects];
    [self.delegate.oberver removeAllObervies];
    [self.tableView reloadData];
    [SVProgressHUD showSuccessWithStatus:@"removeSucceed"];
}
- (void)getData {
    //处理数据
    //1.获取到监听列表所有数据
    NSArray *oberives = [self.delegate.oberver allObervies];
    //2.便利数组获取到模型并添加到数据数组
    for (stationModel *stationModel in [self.statiosMDic allValues] ) {
        if ([oberives containsObject:stationModel.ID]) {
            [self.dataArray addObject:stationModel];
        }
    }
    [self.tableView reloadData];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    oberveCell *cell=[tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    stationModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   UITableViewCellEditingStyleDelete;
}
//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setEditing:NO animated:YES];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        stationModel *model = self.dataArray[indexPath.row];
        model.isOberving = NO;
        [self.delegate.oberver removeBeOberved:model];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
@end
