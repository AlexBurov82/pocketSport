//
//  InputCodeTVC.h
//  pocketSport
//
//  Created by Александр on 23.01.17.
//
//

#import <UIKit/UIKit.h>

@interface InputCodeTVC : UITableViewController


@property (strong, nonatomic) NSString *phoneNumber;

- (IBAction)confirmInputAction:(UIButton *)sender;

@end
