//
//  Record.h
//  pocketSport
//
//  Created by Александр on 30.01.17.
//
//

#import "ServerObject.h"

@interface Record : ServerObject

- (id)initWithServerResponse:(NSDictionary *)responseObject;

@end
