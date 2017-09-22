//
//  LogTVC.m
//  pocketSport
//
//  Created by Александр on 27.01.17.
//
//

#import "LogTVC.h"
#import "LogCell.h"
#import <SWRevealViewController.h>

@interface LogTVC () <SWRevealViewControllerDelegate>

@end

@implementation LogTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_dark"]];
    
    [self initTitle];
    
    [self actionMenuButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTitle {
    
    self.navigationItem.title = @"Журнал";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setBackgroundImage:[UIImage imageNamed:@"logoNav"] forState:UIControlStateNormal];
    
    [button.layer setMasksToBounds:YES];
    
    button.frame = CGRectMake(0.0, 100.0, 84.41, 25.35);
    
    self.navigationItem.rightBarButtonItem.customView = button;
}

#pragma mark - SWRevealViewController

- (void)actionMenuButton {
    
    SWRevealViewController *revealViewController = self.revealViewController;
    
    if (revealViewController) {
        [self.menuButton setTarget:self.revealViewController];
        [self.menuButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
        revealViewController.delegate = self;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *idLogCell = @"LogCell";
    
    LogCell *cell = [tableView dequeueReusableCellWithIdentifier:idLogCell];
    if (!cell) {
        cell = [[LogCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idLogCell];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

@end
