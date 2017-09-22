//
//  UIView+Shadow.m
//  pocketSport
//
//  Created by Александр on 14.02.17.
//
//

#import "UIView+Shadow.h"

@implementation UIView (Shadow)

- (void)shadowViewLeft {
    
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(-1.0f,2.0f);
    self.layer.shadowRadius = 0.5f;
    self.layer.shadowOpacity = 0.6f;
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
}

- (void)shadowViewRight {
    
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(1.0f,2.0f);
    self.layer.shadowRadius = 0.5f;
    self.layer.shadowOpacity = 0.6f;
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
}


@end
