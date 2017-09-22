//
//  PersonSportsCell.m
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import "PersonSportsCell.h"
#import "UITextField+Style.h"

@implementation PersonSportsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.sportsTextField shadowTextField];
    [self.sportsTextField spaceTextField];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
