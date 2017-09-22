//
//  MainTVC.m
//  pocketSport
//
//  Created by Александр on 23.01.17.
//
//

#import "WelcomeTVC.h"
#import "MainLogoCell.h"
#import "MainInputTelephoneCell.h"
#import "MainButtonSendCell.h"
#import "MainInputVKCell.h"
#import "MainInputFaceBookCell.h"
#include <SHSPhoneLibrary.h>
#include <SHSPhoneNumberFormatter.h>
#import "ServerManager.h"
#import "Reachability.h"
#import "InputCodeTVC.h"
#import <VKSdk.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@interface WelcomeTVC () <UITextFieldDelegate, VKSdkDelegate, VKSdkUIDelegate>

@property (strong, nonatomic) SHSPhoneTextField *phoneNumberTextField;
@property (strong, nonatomic) NSString *numberPhone;


@end

@implementation WelcomeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jeans"]];
    
//    [self formatPhoneNumberTextField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)formatPhoneNumberTextField {
//    
//    [self.phoneNumberTextField.formatter setDefaultOutputPattern:@"(###) ###-##-##"];
//    self.phoneNumberTextField.formatter.prefix = @"+7 ";
//}




#pragma mark - Actions

- (IBAction)receiveCodeAction:(UIButton *)sender {
    
    NSString *stringNumber = [self formatString:self.phoneNumberTextField.text];
    
    if (stringNumber.length == 11) {
        
        self.numberPhone = stringNumber;
        
        [self testInternetConnection];
    }
}

- (IBAction)authorizationVKAction:(UIButton *)sender {
    
    [self authorizationVK];
}

- (IBAction)authorizationFBAction:(UIButton *)sender {
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [self logoutFacebook];
    }else {
        [self loginFacebook];
    }
}

- (NSString *)formatString:(NSString *)string {
    
    NSString *string1 = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *string2 = [string1 stringByReplacingOccurrencesOfString:@"(" withString:@""];
    NSString *string3 = [string2 stringByReplacingOccurrencesOfString:@")" withString:@""];
    NSString *string4 = [string3 stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return string4;
}


#pragma mark - UITextFieldDelegate


- (BOOL)textField:(SHSPhoneTextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    
    NSString *stringNuber = [self formatString:self.phoneNumberTextField.text];
    
    if (stringNuber.length == 11) {
        
        NSIndexPath *rowIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        [self.tableView scrollToRowAtIndexPath:rowIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
    }
    
    return YES;
}

#pragma mark - ProtocolBus4us

- (void)requestCodeFrorNumberPhone:(NSString*)number {
    
    [[ServerManager shareManager] requestCode:number onSuccess:^(NSInteger result) {
        
        if (result == 1) {
            InputCodeTVC *tvc = [self.storyboard instantiateViewControllerWithIdentifier:@"InputCodeTVC"];
            
            tvc.phoneNumber = self.numberPhone;
            
             [self presentViewController:tvc animated:NO completion:nil];
        }
        
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"error = %@, code = %ld", [error localizedDescription], (long)statusCode);
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *idMainLogoCell = @"MainLogoCell";
    static NSString *idMainInputTelephoneCell = @"MainInputTelephoneCell";
    static NSString *idMainButtonSendCell = @"MainButtonSendCell";
    static NSString *idMainInputVKCell = @"MainInputVKCell";
    static NSString *idMainInputFaceBookCell = @"MainInputFaceBookCell";
    
    switch (indexPath.row) {
        case 0:
        {
            MainLogoCell *cell = [tableView dequeueReusableCellWithIdentifier:idMainLogoCell];
            if (!cell) {
                cell = [[MainLogoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idMainLogoCell];
            }
            
            return cell;
        }
            break;
            
        case 1:
        {
            MainInputTelephoneCell *cell = [tableView dequeueReusableCellWithIdentifier:idMainInputTelephoneCell];
            if (!cell) {
                cell = [[MainInputTelephoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idMainInputTelephoneCell];
            }
            
            [cell.phoneTextField.formatter setDefaultOutputPattern:@"(###) ###-##-##"];
            cell.phoneTextField.formatter.prefix = @"8 ";
            
            self.phoneNumberTextField = cell.phoneTextField;
            
            cell.backgroundColor = [UIColor clearColor];
            
            return cell;
        }
            break;
            
        case 2:
        {
            MainButtonSendCell *cell = [tableView dequeueReusableCellWithIdentifier:idMainButtonSendCell];
            if (!cell) {
                cell = [[MainButtonSendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idMainButtonSendCell];
            }
            
            cell.backgroundColor = [UIColor clearColor];
            
            return cell;
        }
            break;
            
        case 3:
        {
            MainInputVKCell *cell = [tableView dequeueReusableCellWithIdentifier:idMainInputVKCell];
            if (!cell) {
                cell = [[MainInputVKCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idMainInputVKCell];
            }
            
            cell.backgroundColor = [UIColor clearColor];
            
            return cell;
        }
            break;
            
        case 4:
        {
            MainInputFaceBookCell *cell = [tableView dequeueReusableCellWithIdentifier:idMainInputFaceBookCell];
            if (!cell) {
                cell = [[MainInputFaceBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idMainInputFaceBookCell];
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

#pragma mark - TestInternetConnection

- (void)testInternetConnection {
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        /*
        ABNoConnectionVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ABNoConnectionVC"];
        
        vc.delegate = self;
        
        [self presentViewController:vc animated:YES completion:nil];
        */
        //        [self noInternetConnectionAlert];
    } else {
        [self requestCode];
    }
}

- (void)requestCode {
    
    if (self.numberPhone.length == 11) {
        
        [self requestCodeFrorNumberPhone:self.numberPhone];
        
    }
}


- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    NSLog(@"VK: token - %@, id - %@", result.token.accessToken, result.token.userId);
}

- (void)vkSdkUserAuthorizationFailed {
    
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
//    [self dismissViewControllerAnimated:YES completion:^{
////        [self presentViewController:controller animated:YES completion:nil];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://vk.com"]];
//    }];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://vk.com"]];
}


- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    
}

-(void) vkSdkReceivedNewToken:(VKAccessToken*) newToken {
    
}

-(void)authorizationVK {
    
    VKSdk *sdkInstance = [VKSdk initializeWithAppId:[self appIdVK]];
    [sdkInstance registerDelegate:self];
    [sdkInstance setUiDelegate:self];
    
    NSArray *scope = @[@"friends", @"email"];
    
    [VKSdk wakeUpSession:scope completeBlock:^(VKAuthorizationState state, NSError *error) {
        // NSLog(@"state vk = %lu",(unsigned long)state);
        if (state == VKAuthorizationAuthorized) {
            
//            [[VKSdk accessToken] userId];
            
            ;
            [VKSdk forceLogout];
            
//            [[VKSdk forceLogout] userId];
            // Authorized and ready to go
            // NSLog(@" vk ready auth");
            
//            [self performSelector:@selector(postToVK) withObject:self afterDelay:0.2];
        }
        if (state == VKAuthorizationInitialized){
            // need Authorized
            // NSLog(@" vk need auth");
            [VKSdk authorize:scope];
            
//            if ([VKSdk vkAppMayExists]) {
//                [VKSdk authorize:scope];
//            } else {
//                [VKSdk authorize:scope revokeAccess:YES forceOAuth:YES inApp:YES];
//            }
            
        }
        if (error) {
            // Some error happend, but you may try later
            NSLog(@"vk some error");
        }
    }];
}


- (void)loginFacebook {
    
    [self logoutFacebook];
    
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    // Optional: Place the button in the center of your view.
//    loginButton.center = self.view.center;
//    [self.view addSubview:loginButton];
    
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logInWithReadPermissions:@[@"public_profile", @"email"]
                        fromViewController:self
                                   handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                       NSLog(@"Facebook: token - %@, id - %@", result.token.tokenString, result.token.userID);
                                   }];

}

//- (void) loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult: (FBSDKLoginManagerLoginResult *)result error:   (NSError *)error{
//    
//    if ([[result token] tokenString]) {
//        //send token to the server...
//    }
//}


- (void)logoutFacebook {
    
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
}




- (NSString *)appIdVK {
    
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    
    NSString *appIdVK = [info objectForKey:@"appIdVK"];
    
    return appIdVK;
}

//appIdFacebook

- (NSString *)appIdFacebook {
    
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    
    NSString *appIdFacebook = [info objectForKey:@"appIdFacebook"];
    
    return appIdFacebook;
}

@end
