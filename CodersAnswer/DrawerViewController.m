//
//  DrawerViewController.m
//  CodersAnswer
//
//  Created by rogers on 3/11/14.
//  Copyright (c) 2014 com.rogers140. All rights reserved.
//

#import "DrawerViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "ProblemListViewController.h"
#import "PickOneViewController.h"
#import "StarViewController.h"
#import "AboutViewController.h"
#import "FeedBackViewController.h"
static NSString * const kICSColorsViewControllerCellReuseId = @"kICSColorsViewControllerCellReuseId";

@interface DrawerViewController ()

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, assign) NSInteger previousRow;
@property (nonatomic, strong) NSArray *menuItems;


@end

@implementation DrawerViewController

- (id)init
{
    
    self = [super initWithStyle:UITableViewStyleGrouped];
    self.menuItems = [[NSArray alloc]initWithObjects:@"Problem List", @"Pick One", @"Noted",
                      @"About", @"Feedback", nil];
    return self;
}

- (id)initWithColors:(NSArray *)colors
{
    NSParameterAssert(colors);
    
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _colors = colors;
    }
    return self;
}


#pragma mark - Managing the view

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kICSColorsViewControllerCellReuseId];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor colorWithRed:91.0f / 255.0f green:91.0f / 255.0f blue:91.0f / 255.0f alpha:1.0f];
    UIImageView *header = [self headerWithColor:[UIColor colorWithRed:91.0f / 255.0f green:91.0f / 255.0f blue:91.0f / 255.0f alpha:1.0f]];
    self.tableView.tableHeaderView = header;
}

#pragma mark - generate a pure color header
-(UIImageView *)headerWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.bounds.size.width,
                             [[UIApplication sharedApplication] statusBarFrame].size.height + 44);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = [UIImage imageNamed:@"drawer_header.png"];
    UIGraphicsEndImageContext();
    UIImageView *imageHolder = [[UIImageView alloc] initWithFrame:rect];
    imageHolder.image = image;
    return imageHolder;
}

#pragma mark - Configuring the view’s layout behavior

- (UIStatusBarStyle)preferredStatusBarStyle
{
    // Even if this view controller hides the status bar, implementing this method is still needed to match the center view controller's
    // status bar style to avoid a flicker when the drawer is dragged and then left to open.
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSParameterAssert(self.colors);
    //return self.colors.count;
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kICSColorsViewControllerCellReuseId forIndexPath:indexPath];
    cell.textLabel.text = self.menuItems[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    UIImage *sourceIcon;
    switch (indexPath.row) {
        case 0:
            sourceIcon = [UIImage imageNamed:@"drawer_problem_list.png"];
            break;
        case 1:
            sourceIcon = [UIImage imageNamed:@"drawer_pick_one.png"];
            break;
        case 2:
            sourceIcon = [UIImage imageNamed:@"drawer_noted.png"];
            break;
        case 3:
            sourceIcon = [UIImage imageNamed:@"drawer_about.png"];
            break;
        case 4:
            sourceIcon = [UIImage imageNamed:@"drawer_feedback.png"];
            break;
        default:
            break;
    }
    [cell.imageView setContentMode:UIViewContentModeCenter];
    [cell.imageView setImage:sourceIcon];

    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.previousRow && indexPath.row != 1) {
        // Close the drawer without no further actions on the center view controller
        [self.drawer close];
    }
    else {
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        PickOneViewController *pickOneViewController;
        StarViewController *starViewController;
        AboutViewController *aboutViewController;
        FeedBackViewController *feedBackViewController;
        switch (indexPath.row) {
            case 0:
                [self.drawer replaceCenterViewControllerWithViewController:delegate.problemListMain];
                delegate.mainViewController = delegate.problemListMain;
                break;
            case 1:
                pickOneViewController = [[PickOneViewController alloc]init];
                delegate.pickOneMain = [[MainViewController alloc]init];
                [self.drawer replaceCenterViewControllerWithViewController:delegate.pickOneMain];
                pickOneViewController.title = @"Lucky!";
                delegate.mainViewController = delegate.pickOneMain;
                [delegate.pickOneMain pushViewController:pickOneViewController animated:YES];
                break;
            case 2:
                starViewController = [[StarViewController alloc]init];
                delegate.starMain = [[MainViewController alloc]init];
                [self.drawer replaceCenterViewControllerWithViewController:delegate.starMain];
                starViewController.title = @"Noted Problems";
                delegate.mainViewController = delegate.starMain;
                [delegate.starMain pushViewController:starViewController animated:YES];
                break;
            case 3:
                aboutViewController = [[AboutViewController alloc]init];
                delegate.aboutMain = [[MainViewController alloc]init];
                [self.drawer replaceCenterViewControllerWithViewController:delegate.aboutMain];
                aboutViewController.title = @"About";
                delegate.mainViewController = delegate.aboutMain;
                [delegate.aboutMain pushViewController:aboutViewController animated:YES];
                break;
                
            case 4:
                feedBackViewController = [[FeedBackViewController alloc]init];
                delegate.feedBackMain = [[MainViewController alloc]init];
                [self.drawer replaceCenterViewControllerWithViewController:delegate.feedBackMain];
                feedBackViewController.title = @"Feedback";
                delegate.mainViewController = delegate.feedBackMain;
                [delegate.feedBackMain pushViewController:feedBackViewController animated:YES];
                break;
            default:
                break;
        }
    }
    self.previousRow = indexPath.row;
    //[self.drawer close];
}

#pragma mark - ICSDrawerControllerPresenting

- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}

- (void)drawerControllerWillClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}

@end

