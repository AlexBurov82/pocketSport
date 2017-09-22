//
//  ServiceOfGymCell.m
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import "ServiceOfGymCell.h"

@implementation ServiceOfGymCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self styleButton:self.payButton];
    
    self.shadowView.layer.masksToBounds = NO;
    self.shadowView.layer.shadowOffset = CGSizeMake(2.0f,3.0f);
    self.shadowView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.shadowView.bounds].CGPath;
    self.shadowView.layer.shadowRadius = 1.0f;
    self.shadowView.layer.shadowOpacity = 0.3f;
    self.shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    
    self.shadowView2.layer.masksToBounds = NO;
    self.shadowView2.layer.shadowOffset = CGSizeMake(-2.0f,3.0f);
    self.shadowView2.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.shadowView2.bounds].CGPath;
    self.shadowView2.layer.shadowRadius = 1.0f;
    self.shadowView2.layer.shadowOpacity = 0.3f;
    self.shadowView2.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    
    self.shadowView3.layer.masksToBounds = NO;
    self.shadowView3.layer.shadowOffset = CGSizeMake(-2.0f,-2.0f);
    self.shadowView3.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.shadowView3.bounds].CGPath;
    self.shadowView3.layer.shadowRadius = 1.0f;
    self.shadowView3.layer.shadowOpacity = 0.3f;
    self.shadowView3.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    
    self.shadowView4.layer.masksToBounds = NO;
    self.shadowView4.layer.shadowOffset = CGSizeMake(2.0f,-2.0f);
    self.shadowView4.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.shadowView4.bounds].CGPath;
    self.shadowView4.layer.shadowRadius = 1.0f;
    self.shadowView4.layer.shadowOpacity = 0.3f;
    self.shadowView4.layer.shadowColor = [UIColor lightGrayColor].CGColor;
}




- (void)styleButton:(UIButton *)button {
    button.layer.cornerRadius = 2;
}

@end
