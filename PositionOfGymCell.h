//
//  PositionOfGymCell.h
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface PositionOfGymCell : UITableViewCell

@property (strong, nonatomic) IBOutlet GMSMapView *mapView;

@end
