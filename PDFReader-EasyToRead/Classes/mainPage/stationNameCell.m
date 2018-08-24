//
//  stationNameCell.m
//  obervePanDa
//
//  Created by liuhang on 17/4/18.
//  Copyright © 2017年 liuhang. All rights reserved.
//

#import "stationNameCell.h"

@implementation stationNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(stationModel *)model {
    _model = model;
    _nameLB.text = _model.stationname;
    _canUseNumLB.text = [NSString stringWithFormat:@"%ld",_model.canusenum];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
