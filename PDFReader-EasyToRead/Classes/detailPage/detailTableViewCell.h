//
//  detailTableViewCell.h
//  obervePanDa
//
//  Created by liuhang on 17/4/18.
//  Copyright © 2017年 liuhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"
@interface detailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *carImage;
@property (weak, nonatomic) IBOutlet UILabel *energy;
@property (weak, nonatomic) IBOutlet UILabel *mileage;
@property (nonatomic, strong) DetailModel *model;
@end
