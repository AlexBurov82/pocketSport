//
//  NoRecordsCell.m
//  pocketSport
//
//  Created by Александр on 14.02.17.
//
//

#import "NoRecordsCell.h"
#import "UIView+Shadow.h"

@implementation NoRecordsCell

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
