//
//  ABServerObject.h
//  Erpico
//
//  Created by Александр on 29.07.16.
//  Copyright © 2016 Alex Bukharov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerObject : NSObject

- (id)initWithServerResponse:(NSDictionary *)responseObject;

- (id)initWithServerResponseGoogle:(NSDictionary *)responseObject;

@end
