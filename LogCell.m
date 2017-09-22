//
//  LogCell.m
//  pocketSport
//
//  Created by Александр on 27.01.17.
//
//

#import "LogCell.h"
#import "UIView+Shadow.h"

@implementation LogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.shadowView shadowViewLeft];
    [self.shadowSecondView shadowViewRight];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
