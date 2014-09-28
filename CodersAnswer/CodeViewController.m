//
//  CodeViewController.m
//  CodersAnswer
//
//  Created by rogers on 3/11/14.
//  Copyright (c) 2014 com.rogers140. All rights reserved.
//

#import "CodeViewController.h"
#import "FileHandler.h"
#import "AppDelegate.h"

@interface CodeViewController ()
@property (strong, nonatomic) NSURL *filePath;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) UIBarButtonItem *starButton;
@property (strong, nonatomic) UIBarButtonItem *rotateButton;
@property float heightofNaviStatus;

@end

@implementation CodeViewController
{
    BOOL isStarred;
}

@synthesize problemName;

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
    //self.webView.scalesPageToFit = YES;
    //calculate the height of navigationbar and status bar
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    self.heightofNaviStatus = self.navigationController.navigationBar.frame.size.height + statusBarFrame.size.height;
    
    float width = self.view.bounds.size.width;
    float height = self.view.bounds.size.height;
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self.view insertSubview:self.webView atIndex:0];
    //finish
    
    self.filePath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:self.problemName ofType:@"html" ]]; //inDirectory:@"www/code"]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.filePath]];
    
    
    //star button
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
    self.starButton = [[UIBarButtonItem alloc] initWithCustomView:customizedStarButton];
    
    //rotate button
    UIImage *rotateIcon = [UIImage imageNamed:@"icon_landscape.png"];
    CGRect frameRotateIcon = CGRectMake(0, 0, rotateIcon.size.width, rotateIcon.size.height);
    UIButton *customizedRotateButton = [[UIButton alloc]initWithFrame:frameRotateIcon];
    [customizedRotateButton setBackgroundImage:rotateIcon forState:UIControlStateNormal];
    [customizedRotateButton addTarget:self action:@selector(rotate:) forControlEvents:UIControlEventTouchUpInside];
    self.rotateButton = [[UIBarButtonItem alloc] initWithCustomView:customizedRotateButton];
    
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:self.rotateButton, self.starButton, nil];
    self.navigationItem.rightBarButtonItems = buttonArray;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (BOOL)isStarred: (NSString *)problemName
{
    //check whether it is starred or not
    FileHandler *fileHandler = [FileHandler getInstance];
    return [fileHandler starCheck:self.problemName];
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
    self.starButton = [[UIBarButtonItem alloc] initWithCustomView:customizedStarButton];
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:self.rotateButton, self.starButton, nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
    //pop up info
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
    self.starButton = [[UIBarButtonItem alloc] initWithCustomView:customizedStarButton];
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:self.rotateButton, self.starButton, nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
}
- (IBAction)rotate:(id)sender
{
    float width = self.view.bounds.size.width;
    float height = self.view.bounds.size.height;
    self.webView.transform = CGAffineTransformMakeRotation(M_PI_2);
    NSLog(@"%f", self.heightofNaviStatus);
    self.webView.frame = CGRectMake(0, self.heightofNaviStatus, width + self.heightofNaviStatus, height - self.heightofNaviStatus);
    [self.webView stopLoading];
    [self.webView reload];
    //change icon of the button
    UIImage *rotateIcon = [UIImage imageNamed:@"icon_portrait.png"];
    CGRect frameRotateIcon = CGRectMake(0, 0, rotateIcon.size.width, rotateIcon.size.height);
    UIButton *customizedRotateButton = [[UIButton alloc]initWithFrame:frameRotateIcon];
    [customizedRotateButton setBackgroundImage:rotateIcon forState:UIControlStateNormal];
    [customizedRotateButton addTarget:self action:@selector(unrotate:) forControlEvents:UIControlEventTouchUpInside];
    self.rotateButton = [[UIBarButtonItem alloc] initWithCustomView:customizedRotateButton];
    
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:self.rotateButton, self.starButton, nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
    
}
- (IBAction)unrotate:(id)sender
{
    float width = self.view.bounds.size.width;
    float height = self.view.bounds.size.height;
    self.webView.transform = CGAffineTransformMakeRotation(0); //rotate back
    self.webView.frame = CGRectMake(0, 0, width, height);
    //change icon of the button
    UIImage *rotateIcon = [UIImage imageNamed:@"icon_landscape.png"];
    CGRect frameRotateIcon = CGRectMake(0, 0, rotateIcon.size.width, rotateIcon.size.height);
    UIButton *customizedRotateButton = [[UIButton alloc]initWithFrame:frameRotateIcon];
    [customizedRotateButton setBackgroundImage:rotateIcon forState:UIControlStateNormal];
    [customizedRotateButton addTarget:self action:@selector(rotate:) forControlEvents:UIControlEventTouchUpInside];
    self.rotateButton = [[UIBarButtonItem alloc] initWithCustomView:customizedRotateButton];
    
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:self.rotateButton, self.starButton, nil];
    self.navigationItem.rightBarButtonItems = buttonArray;

}
//-(void) viewWillDisappear:(BOOL)animated //press back button
//{
//    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
//        NSLog(@"BACK");
//    }
//    [super viewWillDisappear:animated];
//}
@end
