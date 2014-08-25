//
//  PickOneViewController.h
//  CodersAnswer
//
//  Created by rogers on 3/11/14.
//  Copyright (c) 2014 com.rogers140. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"

@interface PickOneViewController : UIViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting>
@property(nonatomic, weak) ICSDrawerController *drawer;
@end
