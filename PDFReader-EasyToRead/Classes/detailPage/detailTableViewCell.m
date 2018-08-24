//
//  detailTableViewCell.m
//  obervePanDa
//
//  Created by liuhang on 17/4/18.
//  Copyright © 2017年 liuhang. All rights reserved.
//

#import "detailTableViewCell.h"

@implementation detailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(DetailModel *)model {
    _model = model;
    self.energy.text = _model.dcdl;
    self.mileage.text = [NSString stringWithFormat:@"%@KM",_model.xhlc];
    if (model.rooms == 3) {
        self.carImage.image = [UIImage imageNamed:@"car3"];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
