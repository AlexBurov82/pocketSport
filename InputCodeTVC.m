//
//  InputCodeTVC.m
//  pocketSport
//
//  Created by Александр on 23.01.17.
//
//

#import "InputCodeTVC.h"
#import "InputCodeLogoCell.h"
#import "InputCodeCell.h"
#import "ConfirmCodeCell.h"
#import "Reachability.h"
#import "ServerManager.h"
#import "AccessToken.h"
#import "Authentication.h"
#import <SWRevealViewController.h>

@interface InputCodeTVC ()

@property (strong, nonatomic) UITextField *inputCodeTextField;

@end

@implementation InputCodeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jeans"]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmInputAction:(UIButton *)sender {
    
    [self confirmInput];
}

- (void)confirmInput {
    if ([self.inputCodeTextField.text length] == 4) {
        
        [self testInternetConnection];
    } else {
       // [self authorizationErrorAlert];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    return !([newString length] > 4);
    
    return YES;
}


- (IBAction)editingChengedTextField {
    
    NSString *string = self.inputCodeTextField.text;
    
    if (string.length == 4) {
        
        NSIndexPath *rowIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:rowIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *idInputCodeLogoCell = @"InputCodeLogoCell";
    static NSString *idInputCodeCell = @"InputCodeCell";
    static NSString *idConfirmCodeCell = @"ConfirmCodeCell";
    
    switch (indexPath.row) {
        case 0:
        {
            InputCodeLogoCell *cell = [tableView dequeueReusableCellWithIdentifier:idInputCodeLogoCell];
            if (!cell) {
                cell = [[InputCodeLogoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idInputCodeLogoCell];
            }
            
            return cell;
        }
            break;
            
        case 1:
        {
            InputCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:idInputCodeCell];
            if (!cell) {
                cell = [[InputCodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idInputCodeCell];
            }
            
            cell.backgroundColor = [UIColor clearColor];
            
            self.inputCodeTextField = cell.codeTextField;
            
            return cell;
        }
            break;
             
        case 2:
        {
            ConfirmCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:idConfirmCodeCell];
            if (!cell) {
                cell = [[ConfirmCodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idConfirmCodeCell];
            }
            
            cell.backgroundColor = [UIColor clearColor];
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

- (void)verifyCode:(NSString *)code forPhoneNumber:(NSString *)phoneNumber {
    
    [[ServerManager shareManager]verifyCode:code forPhoneNumber:phoneNumber onSuccess:^(AccessToken *accessToken) {
        
        if ([accessToken.token length] > 0) {
            
            [self archivingToken:accessToken.token];
            
            [self authenticate:accessToken];
            /*
            ABGlobalVariables *gv = [ABGlobalVariables sharedInstance];
            
            gv.isContactWithServer = YES;
            
            [self.timerRepeatConnect invalidate];
             */
            
        } else {
            [self authorizationErrorAlert];
        }
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"error = %@, code = %ld", [error localizedDescription], (long)statusCode);
        
        [self checkConnectWithServer];
    }];
}

- (void)authenticate:(AccessToken *)accessToken {
    
    [[ServerManager shareManager]authenticate:accessToken onSuccess:^(Authentication *auth) {
        
        if (auth.result == 1) {
            if ([auth.clientID integerValue] > 0) {
                
//                [self.timerRepeatConnect invalidate];
//                
                [self archivingAuthentication:auth];
                
                [self transitionToFollowingControler];
            }
        } else {
            //            NSLog(@"other - %ld", (long)errorCode);
            [self checkConnectWithServer];
        }
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        //        NSLog(@"error = %@, code = %ld", [error localizedDescription], (long)statusCode);
        
        [self checkConnectWithServer];
    }];
}

- (void)transitionToFollowingControler {
    
    SWRevealViewController *rvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    
//    rvc.segueFrontIdentifier = @"front";
    
    [self presentViewController:rvc animated:NO completion:nil];
}



#pragma mark - TestInternetConnection

- (void)testInternetConnection {
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        
        [self checkConnectWithServer];
        
        //        [self noInternetConnectionAlert];
    } else {
        /*
        ABGlobalVariables *gv = [ABGlobalVariables sharedInstance];
        
        gv.isContactWithServer = YES;
        
        [self.timerRepeatConnect invalidate];
        */
        if ([self.inputCodeTextField.text length] == 4 && [self.phoneNumber length] == 11) {
            [self verifyCode:self.inputCodeTextField.text forPhoneNumber:self.phoneNumber];
        }
    }
}

- (void)authorizationErrorAlert {
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Ошибка авторизации"
                                  message:@"Убедитесь, что ввели код правильно."
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"Ок"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                               }];
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)checkConnectWithServer {
    /*
    ABServerNotAvailableVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ABServerNotAvailableVC"];
    
    vc.delegate = self;
    
    ABGlobalVariables *gv = [ABGlobalVariables sharedInstance];
    
    gv.isContactWithServer = NO;
    
    if (!self.timerRepeatConnect) {
        self.timerRepeatConnect = [NSTimer scheduledTimerWithTimeInterval:15.0 target:self selector:@selector(repeatConnect) userInfo:nil repeats:YES];
    }
    
    [self presentViewController:vc animated:YES completion:nil];
     */
}

#pragma mark - NSCoding

- (void)archivingToken:(NSString *)token {
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:token];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"token"];
}

- (void)archivingAuthentication:(Authentication *)auth {
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:auth];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"auth"];
}

@end
