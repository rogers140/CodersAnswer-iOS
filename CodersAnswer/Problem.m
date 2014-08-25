//
//  Problem.m
//  CodersAnswer
//
//  Created by rogers on 3/13/14.
//  Copyright (c) 2014 com.rogers140. All rights reserved.
//

#import "Problem.h"

@implementation Problem
@synthesize problemName;
@synthesize iconName;
@synthesize details;
- (id) initWithInfo: (NSString *)name : (NSString *)icon : (NSString *)detailText
{
    self = [super init];
    problemName = name;
    iconName = icon;
    details = detailText;
    return self;
}
@end
