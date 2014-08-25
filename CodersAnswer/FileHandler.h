//
//  FileHandler.h
//  CodersAnswer
//
//  Created by rogers on 3/12/14.
//  Copyright (c) 2014 com.rogers140. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHandler : NSObject
- (BOOL) starCheck:(NSString *)problemName;
- (void) addToStarList: (NSString *)problemName;
- (void) deleteFromStarList: (NSString *)problemName;
- (NSMutableArray *) getStarList;
+ (FileHandler *) getInstance;
@end
