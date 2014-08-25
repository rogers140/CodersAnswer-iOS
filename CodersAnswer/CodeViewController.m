//
//  CodeViewController.m
//  CodersAnswer
//
//  Created by rogers on 3/11/14.
//  Copyright (c) 2014 com.rogers140. All rights reserved.
//

#import "CodeViewController.h"
#import "FileHandler.h"

@interface CodeViewController ()
@property (strong, nonatomic) NSURL *filePath;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

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
    UIBarButtonItem *starButton = [[UIBarButtonItem alloc] initWithCustomView:customizedStarButton];
    self.navigationItem.rightBarButtonItem = starButton;

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
    UIBarButtonItem *starButton = [[UIBarButtonItem alloc] initWithCustomView:customizedStarButton];
    self.navigationItem.rightBarButtonItem = starButton;
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
    UIBarButtonItem *starButton = [[UIBarButtonItem alloc] initWithCustomView:customizedStarButton];
    self.navigationItem.rightBarButtonItem = starButton;
}


@end
