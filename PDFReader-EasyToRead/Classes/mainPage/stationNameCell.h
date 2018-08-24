//
//  stationNameCell.h
//  obervePanDa
//
//  Created by liuhang on 17/4/18.
//  Copyright © 2017年 liuhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "stationModel.h"
@interface stationNameCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *canUseNumLB;
@property (nonatomic, strong) stationModel *model;
@end
