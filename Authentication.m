//
//  ABAuthentication.m
//  bus4us
//
//  Created by Александр on 25.08.16.
//  Copyright © 2016 Alex Bukharov. All rights reserved.
//

#import "Authentication.h"

#define kClientID  @"kClientID"
#define kClientName  @"kClientName"
#define kClientLastName  @"kClientLastName"
#define kClientEmail  @"kClientEmail"
#define kClientPhone  @"kClientPhone"

@implementation Authentication

- (id)initWithServerResponse:(NSDictionary *)responseObject {
    
    self = [super initWithServerResponse:responseObject];
    if (self) {
        
        NSString *email = [responseObject objectForKey:@"email"];
        
        if (![email isKindOfClass:[NSNull class]]) {
            self.clientEmail = email;
        } else {
            self.clientEmail = @"";
        }
        
        NSNumber *clientId = [responseObject objectForKey:@"id"];
        
        if (![clientId isKindOfClass:[NSNull class]]) {
            self.clientID = clientId;
        }
        
        NSString *name = [responseObject objectForKey:@"name"];
        
        if (![name isKindOfClass:[NSNull class]]) {
            self.clientName = name;
        } else {
            self.clientName = @"";
        }
        
        NSString *lastName = [responseObject objectForKey:@"last_name"];
        
        if (![lastName isKindOfClass:[NSNull class]]) {
            self.clientLastName = lastName;
        } else {
            self.clientLastName = @"";
        }
        
        NSNumber *phone = [responseObject objectForKey:@"phone"];
        
        if (![clientId isKindOfClass:[NSNull class]]) {
            self.clientPhone = phone;
        }
        
        self.result = [[responseObject objectForKey:@"result"]integerValue];
    }
    
    return self;
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.clientID forKey:kClientID];
    [aCoder encodeObject:self.clientName forKey:kClientName];
    [aCoder encodeObject:self.clientLastName forKey:kClientLastName];
    [aCoder encodeObject:self.clientEmail forKey:kClientEmail];
    [aCoder encodeObject:self.clientPhone forKey:kClientPhone];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init]))
    {
        self.clientID = [aDecoder decodeObjectForKey:kClientID];
        self.clientName = [aDecoder decodeObjectForKey:kClientName];
        self.clientLastName = [aDecoder decodeObjectForKey:kClientLastName];
        self.clientEmail = [aDecoder decodeObjectForKey:kClientEmail];
        self.clientPhone = [aDecoder decodeObjectForKey:kClientPhone];
    }
    return self;
}

@end

