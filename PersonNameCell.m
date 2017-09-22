//
//  PersonNameCell.m
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import "PersonNameCell.h"
#import "UITextField+Style.h"

@implementation PersonNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.nameTextField shadowTextField];
    [self.surnameTextField shadowTextField];
    
    self.userPhotoView.layer.cornerRadius = self.userPhotoView.frame.size.height/2;
    self.userPhotoView.layer.masksToBounds = YES;
    self.userPhotoView.layer.borderWidth = 1.0;
    
    [self.nameTextField spaceTextField];
    [self.surnameTextField spaceTextField];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
