//
//  MenuTVC.m
//  pocketSport
//
//  Created by Александр on 23.01.17.
//
//

#import "MenuTVC.h"
#import <SWRevealViewController.h>
#import "Authentication.h"
#import "WelcomeTVC.h"
#import "ServerManager.h"

@interface MenuTVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *menuItems;

@end

@implementation MenuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_dark"]];
    
    self.userPhotoView.layer.cornerRadius = self.userPhotoView.frame.size.height/2;
    self.userPhotoView.layer.masksToBounds = YES;
    self.userPhotoView.layer.borderWidth = 1.0;
    
    Authentication *auth = [self unarchivingAuthentication];
    
    NSString *name = [auth.clientLastName uppercaseString];
    
    NSMutableString *clientName = [NSMutableString stringWithFormat:@"%@", auth.clientName];
    
    [clientName replaceCharactersInRange:NSMakeRange(0, 1) withString:[clientName substringToIndex:1].capitalizedString];
    
    self.clientNameLabel.text = [NSString stringWithFormat:@"%@ %@", clientName, name];
    
    self.allGymsCell.backgroundColor = [UIColor clearColor];
    self.myActivitiesCell.backgroundColor = [UIColor clearColor];
    self.myClubCardsCell.backgroundColor = [UIColor clearColor];
    self.historyActivitiesCell.backgroundColor = [UIColor clearColor];
    self.callbackCell.backgroundColor = [UIColor clearColor];
    self.logoutCell.backgroundColor = [UIColor clearColor];
}

#pragma mark UICollectionViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([tableView cellForRowAtIndexPath:indexPath] == self.logoutCell) {
        
        [self preventionLogoutUserAlert];
    }
    
    
}

- (void)logoutUser {
    
    WelcomeTVC *tvc = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeTVC"];
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    [self presentViewController:tvc animated:YES completion:nil];
}

- (void)preventionLogoutUserAlert {
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:@"Вы уверены, что хотите удалить все данные и сменить пользователя?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Да"
                                style:UIAlertActionStyleDestructive
                                handler:^(UIAlertAction * action)
                                {
                                    [self logout];
                                    
                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                    ;
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Нет"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   NSIndexPath *indexPath = [self.tableView indexPathForCell:self.logoutCell];
                                   
                                   [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
                                   
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                   ;
                               }];
    
    [alert addAction:noButton];
    
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)logout {
    
    [[ServerManager shareManager]logoutOnSuccess:^(NSInteger result) {
        
        if (result == 1) {
            [self logoutUser];
        }
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"error = %@, code = %ld", [error localizedDescription], (long)statusCode);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 241;
    } else if (indexPath.row == 3) {
        return 0;
    } else {
        return 46;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

#pragma mark - NSCoding

- (Authentication *)unarchivingAuthentication {
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"auth"];
    Authentication *auth = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return auth;
}





@end
