//
//  MainLogoCell.m
//  pocketSport
//
//  Created by Александр on 23.01.17.
//
//

#import "MainLogoCell.h"

@implementation MainLogoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundTop"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
