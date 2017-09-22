//
//  UIView+UITableViewCell.m
//  FileManagerDZ-33-34
//
//  Created by Александр on 01.06.15.
//  Copyright (c) 2015 Alex Bukharov. All rights reserved.
//

#import "UIView+UITableViewCell.h"

@implementation UIView (UITableViewCell)

- (UITableViewCell *)superCell {
    
    if (!self.superview) {
        return nil;
    }
    
    if ([self.superview isKindOfClass:[UITableViewCell class]]) {
        return (UITableViewCell *)self.superview;
    }
    
    return [self.superview superCell];
}

@end
