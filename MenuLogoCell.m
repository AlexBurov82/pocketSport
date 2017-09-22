//
//  MenuLogoCell.m
//  pocketSport
//
//  Created by Александр on 08.02.17.
//
//

#import "MenuLogoCell.h"

@implementation MenuLogoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_darkTop"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
