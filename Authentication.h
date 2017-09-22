//
//  ABAuthentication.h
//  bus4us
//
//  Created by Александр on 25.08.16.
//  Copyright © 2016 Alex Bukharov. All rights reserved.
//

#import "ServerObject.h"

@interface Authentication : ServerObject <NSCoding>

@property (strong, nonatomic) NSString *clientEmail;
@property (strong, nonatomic) NSNumber *clientID;
@property (strong, nonatomic) NSString *clientName;
@property (strong, nonatomic) NSString *clientLastName;
@property (strong, nonatomic) NSNumber *clientPhone;
@property (assign, nonatomic) NSInteger result;

//@property (strong, nonatomic) NSString *email;

- (id)initWithServerResponse:(NSDictionary *)responseObject;


@end
