//
//  Problem.h
//  CodersAnswer
//
//  Created by rogers on 3/13/14.
//  Copyright (c) 2014 com.rogers140. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Problem : NSObject
@property (strong, nonatomic) NSString *problemName;
@property (strong, nonatomic) NSString *iconName;
@property (strong, nonatomic) NSString *details;
- (id) initWithInfo: (NSString *)name : (NSString *)icon : (NSString *)detailText;
@end
