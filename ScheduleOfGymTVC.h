//
//  ScheduleOfGymTVC.h
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import <UIKit/UIKit.h>

@interface ScheduleOfGymTVC : UITableViewController

@property (strong, nonatomic) NSIndexPath *selectedIndexPhthGym;

- (IBAction)recordAction:(UIButton *)sender;


@end
