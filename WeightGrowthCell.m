//
//  WeightGrowthCell.m
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import "WeightGrowthCell.h"
#import "UITextField+Style.h"

@implementation WeightGrowthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.weightTextField shadowTextField];
    [self.growthTextField shadowTextField];
    
    [self.weightTextField spaceTextField];
    [self.growthTextField spaceTextField];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
