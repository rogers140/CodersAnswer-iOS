//
//  PickOneViewController.m
//  CodersAnswer
//
//  Created by rogers on 3/11/14.
//  Copyright (c) 2014 com.rogers140. All rights reserved.
//

#import "PickOneViewController.h"
#import "AppDelegate.h"
#import "FileHandler.h"
#import "Problem.h"

@interface PickOneViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSArray *problemList;
@property (strong, nonatomic) NSString *problemName;

@end

@implementation PickOneViewController
{
    BOOL isStarred;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //set title color
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    //add menu button
    UIImage *menuIcon = [UIImage imageNamed:@"icon_menu.png"];
    CGRect frameMenuIcon = CGRectMake(0, 0, menuIcon.size.width, menuIcon.size.height);
    UIButton *customizedButton = [[UIButton alloc]initWithFrame:frameMenuIcon];
    [customizedButton setBackgroundImage:menuIcon forState:UIControlStateNormal];
    [customizedButton addTarget:self action:@selector(menuClicker:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:customizedButton];
    [self.navigationItem setLeftBarButtonItem:menuButton];
    
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.problemList = [[NSArray alloc]initWithArray:delegate.problemList];
    int index = [self generateRandom:(int)[self.problemList count]];
    Problem *problem = [self.problemList objectAtIndex:index];
    self.problemName = problem.problemName;
    NSURL *filePath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:self.problemName ofType:@"html" ]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:filePath]];
    
    //add star button
    UIImage *starIcon;
    isStarred = [self isStarred:self.problemName];
    if (isStarred) {
        starIcon = [UIImage imageNamed:@"icon_full_star.png"];
    }
    else {
        starIcon = [UIImage imageNamed:@"icon_empty_star.png"];
    }
    CGRect frameStarIcon = CGRectMake(0, 0, starIcon.size.width, starIcon.size.height);
    UIButton *customizedStarButton = [[UIButton alloc]initWithFrame:frameStarIcon];
    [customizedStarButton setBackgroundImage:starIcon forState:UIControlStateNormal];
    if (!isStarred) {
        [customizedStarButton addTarget:self action:@selector(starClicker:) forControlEvents:UIControlEventTouchUpInside];
        isStarred = YES;
    }
    else {
        [customizedStarButton addTarget:self action:@selector(unStarClicker:) forControlEvents:UIControlEventTouchUpInside];
        isStarred = NO;
    }
    UIBarButtonItem *starButton = [[UIBarButtonItem alloc] initWithCustomView:customizedStarButton];
    self.navigationItem.rightBarButtonItem = starButton;


    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int)generateRandom: (int)count
{
    return arc4random() % count;
}
- (BOOL)isStarred: (NSString *)problemName
{
    //check whether it is starred or not
    FileHandler *fileHandler = [FileHandler getInstance];
    return [fileHandler starCheck:self.problemName];
}
- (IBAction)menuClicker:(id)sender
{
    //open drawer
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.drawer open];
}
- (IBAction)starClicker:(id)sender
{
    //change the star state of this problem
    FileHandler *fileHandler = [FileHandler getInstance];
    [fileHandler addToStarList:self.problemName];
    
    //change the picture icon of starButton
    UIImage *starIcon;
    starIcon = [UIImage imageNamed:@"icon_full_star.png"];
    CGRect frameStarIcon = CGRectMake(0, 0, starIcon.size.width, starIcon.size.height);
    UIButton *customizedStarButton = [[UIButton alloc]initWithFrame:frameStarIcon];
    [customizedStarButton setBackgroundImage:starIcon forState:UIControlStateNormal];
    [customizedStarButton addTarget:self action:@selector(unStarClicker:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *starButton = [[UIBarButtonItem alloc] initWithCustomView:customizedStarButton];
    self.navigationItem.rightBarButtonItem = starButton;
}
- (IBAction)unStarClicker:(id)sender
{
    //change the star state of this problem
    FileHandler *fileHandler = [FileHandler getInstance];
    [fileHandler deleteFromStarList:self.problemName];
    //change the picture icon of starButton
    UIImage *starIcon;
    
    starIcon = [UIImage imageNamed:@"icon_empty_star.png"];
    CGRect frameStarIcon = CGRectMake(0, 0, starIcon.size.width, starIcon.size.height);
    UIButton *customizedStarButton = [[UIButton alloc]initWithFrame:frameStarIcon];
    [customizedStarButton setBackgroundImage:starIcon forState:UIControlStateNormal];
    [customizedStarButton addTarget:self action:@selector(starClicker:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *starButton = [[UIBarButtonItem alloc] initWithCustomView:customizedStarButton];
    self.navigationItem.rightBarButtonItem = starButton;
}
@end
