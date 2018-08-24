//
//  settingPage.m
//  obervePanDa
//
//  Created by liuhang on 17/4/20.
//  Copyright © 2017年 liuhang. All rights reserved.
//

#import "settingPage.h"
#import "AppDelegate.h"
#import <SVProgressHUD/SVProgressHUD.h>
@interface settingPage ()
@property (nonatomic, strong) AppDelegate *delegate;
@end

@implementation settingPage
- (AppDelegate *)delegate {
    if (!_delegate) {
        _delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return _delegate;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"setting";
    //设置频率
    self.rateTF.text = [NSString stringWithFormat:@"%ld",self.delegate.oberver.rate];
    //设置位置
    if ([self.delegate.locationCode isEqualToString:@"400000"]) {
        //重庆
        self.switchCitySegment.selectedSegmentIndex = 0;
    }else {
        //成都
        self.switchCitySegment.selectedSegmentIndex = 1;
    }
    //设置版本
    self.versionTF.text = self.delegate.version;
    
}
- (IBAction)sureBtn:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] setObject:self.versionTF.text forKey:@"versionTF"];
    self.delegate.version = self.versionTF.text;
    [[NSUserDefaults standardUserDefaults] setObject:self.rateTF
     .text forKey:@"rateTF"];
    self.delegate.oberver.rate = [self.rateTF.text integerValue];
    [self.delegate.oberver reset];
    if (self.switchCitySegment.selectedSegmentIndex == 0) {
        [[NSUserDefaults standardUserDefaults] setObject:@"400000" forKey:@"location"];
        self.delegate.locationCode = @"400000";
    }else {
        [[NSUserDefaults standardUserDefaults] setObject:@"610000" forKey:@"location"];
        self.delegate.locationCode = @"610000";
    }
    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.cityid":"610000"
}
@end
