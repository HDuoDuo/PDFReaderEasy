//
//  oberveCell.h
//  obervePanDa
//
//  Created by liuhang on 17/4/20.
//  Copyright © 2017年 liuhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "stationModel.h"
@interface oberveCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *stationName;
@property (weak, nonatomic) IBOutlet UILabel *canUseNum;
@property (nonatomic, strong) stationModel *model;
@end
