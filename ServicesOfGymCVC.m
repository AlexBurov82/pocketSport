//
//  ServicesOfGymCVC.m
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import "ServicesOfGymCVC.h"
#import "ServiceOfGymCell.h"

@interface ServicesOfGymCVC ()

@property (strong, nonatomic) NSString *rubString;


@end

@implementation ServicesOfGymCVC

static NSString * const reuseIdentifier = @"ServiceOfGymCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rubString = [NSString stringWithUTF8String:[@"\u20BD" UTF8String]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//
//    return 1;
//}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ServiceOfGymCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *title = [NSString stringWithFormat:@"%@ %@", [self numberFormatter:1000], self.rubString];
    
    [cell.payButton setTitle:title forState:UIControlStateNormal];
    
    return cell;
}

- (NSString *)numberFormatter:(NSInteger)number {
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:number]];
    return numberAsString;
}


@end
