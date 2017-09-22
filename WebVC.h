//
//  WebVC.h
//  pocketSport
//
//  Created by Александр on 13.02.17.
//
//

#import <UIKit/UIKit.h>

@interface WebVC : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSString *stringURL;

@end
