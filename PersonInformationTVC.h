//
//  PersonInformationTVC.h
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import <UIKit/UIKit.h>

@interface PersonInformationTVC : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *personInformationTV;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
- (IBAction)saveAction:(UIButton *)sender;

@end
