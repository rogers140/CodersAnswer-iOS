//
//  MainViewController.m
//  CodersAnswer
//
//  Created by rogers on 3/11/14.
//  Copyright (c) 2014 com.rogers140. All rights reserved.
//
#import "MainViewController.h"

@interface MainViewController ()

@property(nonatomic, strong)UIBarButtonItem *menuButton;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// set color of navigation bar
    self.navigationBar.barTintColor = [UIColor colorWithRed:183.0f / 255.0f green:24.0f / 255.0f blue:24.0f / 255.0f alpha:1.0f];
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configuring the view’s layout behavior

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - ICSDrawerControllerPresenting

- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}

#pragma mark - Open drawer action

- (void)openDrawer:(id)sender
{
    [self.drawer open];
}
@end
