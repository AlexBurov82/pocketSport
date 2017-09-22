//
//  MenuTVC.h
//  pocketSport
//
//  Created by Александр on 23.01.17.
//
//

#import <UIKit/UIKit.h>

@interface MenuTVC : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView *userPhotoView;
@property (weak, nonatomic) IBOutlet UILabel *clientNameLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *logoutCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *allGymsCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *myActivitiesCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *myClubCardsCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *historyActivitiesCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *callbackCell;

@end
