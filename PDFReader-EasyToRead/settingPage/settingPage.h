//
//  settingPage.h
//  obervePanDa
//
//  Created by liuhang on 17/4/20.
//  Copyright © 2017年 liuhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface settingPage : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *versionTF;
@property (weak, nonatomic) IBOutlet UITextField *rateTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *switchCitySegment;

@end
