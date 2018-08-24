//
//  AppDelegate.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2013/12/17.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "oberveTool.h"
#import <AVFoundation/AVFoundation.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//监听工具
@property (nonatomic, strong) oberveTool *oberver;
//地理位置
@property (nonatomic, strong) NSString *locationCode;
//版本
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) AVAudioPlayer *player;
@end
