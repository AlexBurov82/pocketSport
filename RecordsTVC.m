//
//  RecordsTVC.m
//  pocketSport
//
//  Created by Александр on 27.01.17.
//
//

#import "RecordsTVC.h"
#import "RecordCell.h"
#import <SWRevealViewController.h>
#import "ServerManager.h"
#import "NoRecordsCell.h"

@interface RecordsTVC () <SWRevealViewControllerDelegate>

@property (strong, nonatomic) NSArray *records;

@end

@implementation RecordsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_dark"]];
    
    [self initTitle];
    
    [self actionMenuButton];
    
    [self getScheduleRecords];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTitle {
    
    self.navigationItem.title = @"Записи";
    
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
    
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        if ([self.records count] > 0) {
            return [self.records count];
        } else {
            return 0;
        }
    } else {
        if ([self.records count] > 0) {
            return 0;
        } else {
            return 1;
        }
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *idRecordCell= @"RecordCell";
    
    static NSString *idNoRecordsCell= @"NoRecordsCell";
    
    switch (indexPath.section) {
        case 0:
        {
            RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:idRecordCell];
            if (!cell) {
                cell = [[RecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idRecordCell];
            }
            
            cell.backgroundColor = [UIColor clearColor];
            
            return cell;
        }
            break;
        case 1:
        {
            NoRecordsCell *cell = [tableView dequeueReusableCellWithIdentifier:idNoRecordsCell];
            if (!cell) {
                cell = [[NoRecordsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idNoRecordsCell];
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

- (void)getScheduleRecords {
    
    [[ServerManager shareManager]getScheduleRecordsOnSuccess:^(NSArray *records) {
        self.records = [NSArray arrayWithArray:records];
        
        [self.tableView reloadData];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"error = %@, code = %ld", [error localizedDescription], (long)statusCode);
    }];
}

@end
