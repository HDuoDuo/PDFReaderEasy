

//
//  oberveCell.m
//  obervePanDa
//
//  Created by liuhang on 17/4/20.
//  Copyright © 2017年 liuhang. All rights reserved.
//

#import "oberveCell.h"

@implementation oberveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(stationModel *)model
{
    _model = model;
    _stationName.text = _model.stationname;
    _canUseNum.text = [NSString stringWithFormat:@"%ld",_model.canusenum];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
