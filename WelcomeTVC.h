//
//  MainTVC.h
//  pocketSport
//
//  Created by Александр on 23.01.17.
//
//

#import <UIKit/UIKit.h>

@interface WelcomeTVC : UITableViewController

- (IBAction)receiveCodeAction:(UIButton *)sender;
- (IBAction)authorizationVKAction:(UIButton *)sender;
- (IBAction)authorizationFBAction:(UIButton *)sender;

@end
