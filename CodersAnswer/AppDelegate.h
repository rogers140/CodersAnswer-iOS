//
//  AppDelegate.h
//  CodersAnswer
//
//  Created by rogers on 3/11/14.
//  Copyright (c) 2014 com.rogers140. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"
#import "DrawerViewController.h"
#import "MainViewController.h"
#import "ProblemListViewController.h"
#import "CodeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ICSDrawerController *drawer;
@property (strong, nonatomic) DrawerViewController *drawerViewController;
@property (strong, nonatomic) MainViewController *mainViewController;
@property (strong, nonatomic) MainViewController *problemListMain;
@property (strong, nonatomic) MainViewController *pickOneMain;
@property (strong, nonatomic) MainViewController *starMain;
@property (strong, nonatomic) MainViewController *aboutMain;
@property (strong, nonatomic) MainViewController *feedBackMain;
@property (strong, nonatomic) ProblemListViewController *problemListViewController;
@property (strong, nonatomic) NSArray *problemList;


@end
