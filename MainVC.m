//
//  ViewController.m
//  bus4us
//
//  Created by Александр on 04.08.16.
//  Copyright © 2016 Alex Bukharov. All rights reserved.
//

#import "MainVC.h"
#import "SWRevealViewController.h"
#import "AccessToken.h"
#import "ServerManager.h"
#import "Authentication.h"
#import "Reachability.h"
#import "WelcomeTVC.h"
//#import "ABServerNotAvailableVC.h"


@interface MainVC () /*<ABServerNotAvailableDelegate>*/


//@property(strong, nonatomic) NSTimer *timer;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self testInternetConnection];
}




- (void)animationView:(UIView *)view {
   
    [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom
                     animations:^{
                         
                         CGRect frame = view.frame;
                         
                         if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                             frame.origin.y = 70.0;
                         } else {
                             frame.origin.y = 40.0;
                         }
                         
                         view.transform = CGAffineTransformMakeScale(0.5, 0.5);
                         
                         view.frame = frame;
                        
                         
                     } completion:^(BOOL finished) {
                         [self performSegueWithIdentifier:@"splash" sender:self];
                     }];
}

- (void)authenticate:(AccessToken *)accessToken {
    
    [[ServerManager shareManager]authenticate:accessToken onSuccess:^(Authentication *auth) {
        
        if (auth.result == 1) {
            if ([auth.clientID integerValue] > 0) {
                
                [self archivingAuthentication:auth];
                
                SWRevealViewController *rvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                
                //rvc.segueFrontIdentifier = identifier;
                
                [self presentViewController:rvc animated:NO completion:NULL];
            }
        } else {
            
            NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
            [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
            //NSLog(@"other - %ld", (long)errorCode);
            [self checkConnectWithServer];
        }
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"error = %@, code = %ld", [error localizedDescription], (long)statusCode);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                     (int64_t)(2 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                           
                           [self checkConnectWithServer];

                       });
        
    }];
}

- (void)checkConnectWithServer {
    
//    ServerNotAvailableVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ABServerNotAvailableVC"];
//    
//    vc.delegate = self;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
//                                 (int64_t)(0.8 * NSEC_PER_SEC)),
//                   dispatch_get_main_queue(), ^{
//                       
//                       [self testInternetConnection];
//                   });
//    
//    [self presentViewController:vc animated:YES completion:nil];
}

- (void)transitionToWelcome {
    
    WelcomeTVC *rvc = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeTVC"];
    
    [self presentViewController:rvc animated:NO completion:NULL];
}


#pragma mark - TestInternetConnection

- (void)testInternetConnection {
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        
        
        [self checkConnectWithServer];
        
//        ABNoConnectionVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ABNoConnectionVC"];
//        
//        vc.delegate = self;
//        
//        [self presentViewController:vc animated:YES completion:nil];
        
//        [self noInternetConnectionAlert];
    } else {
        
        [self authorization];
    }
}

- (void)repeatOrder {
    [self testInternetConnection];
}

//- (void)authorizationRepetition {
//    [self testInternetConnection];
//}

- (void)authorization {
    
    if ([self unarchivingToken].length > 0) {
        
        AccessToken *accessToken = [[AccessToken alloc] init];
        
        accessToken.token = [self unarchivingToken];
        
        [self authenticate:accessToken];
    } else {
        
        [self performSegueWithIdentifier:@"splash" sender:self];
//        [self animationView:self.logoImageView];
    }
}




- (void)authErrorAlert {
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Ошибка авторизации"
                                 message:@"Не удалось пройти авторизацию."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                                  actionWithTitle:@"Ок"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action) {

                                      dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                                                   (int64_t)(2 * NSEC_PER_SEC)),
                                                     dispatch_get_main_queue(), ^{
                                                         [self transitionToWelcome];
                                                     });
                                      
                                      [alert dismissViewControllerAnimated:YES completion:nil];
                                  }];
    
    
    [alert addAction:okButton];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}



#pragma mark - NSCoding

- (NSString *)unarchivingToken {
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *token = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return token;
}

- (void)transitionToFollowingControler:(NSString *)identifier {
    
    SWRevealViewController *rvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    
//    rvc.segueFrontIdentifier = identifier;

    [self presentViewController:rvc animated:NO completion:NULL];
}



- (void)archivingAuthentication:(Authentication *)auth {
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:auth];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"auth"];
}



@end
