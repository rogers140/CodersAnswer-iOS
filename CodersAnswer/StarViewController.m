//
//  StarViewController.m
//  CodersAnswer
//
//  Created by rogers on 3/13/14.
//  Copyright (c) 2014 com.rogers140. All rights reserved.
//

#import "StarViewController.h"
#import "AppDelegate.h"
#import "FileHandler.h"
#import "Problem.h"

@interface StarViewController ()
@property (strong, nonatomic) IBOutlet UITableView *problemListTable;
@property (strong, nonatomic) NSMutableArray *starList;
@end

@implementation StarViewController

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
    
    FileHandler *fileHandler = [FileHandler getInstance];

    self.starList = [fileHandler getStarList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)menuClicker:(id)sender
{
    //open drawer
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.drawer open];
}

- (void) dismissKeyboard
{
    // add
    //[self.searchBar resignFirstResponder];
}

//table define

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"star_cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"star_cell"];
    }
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSArray *problemList = delegate.problemList;
    NSString *problemName = [self.starList objectAtIndex:indexPath.row];
    Problem *problem;
    for (Problem *tmp in problemList) {
        if ([tmp.problemName isEqualToString:problemName]) {
            problem = tmp;
            break;
        }
    }
    UIImage *sourceIcon = [UIImage imageNamed:problem.iconName];
    [cell.imageView setContentMode:UIViewContentModeCenter];
    [cell.imageView setImage:sourceIcon];
    cell.textLabel.text = problem.problemName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.text = problem.details;
    cell.detailTextLabel.textColor = [UIColor grayColor];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.starList count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissKeyboard];
    //NSDictionary *dic = [self.starList objectAtIndex:indexPath.row];
    NSString *problemName = [self.starList objectAtIndex:indexPath.row];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    CodeViewController *codeView = [[CodeViewController alloc]init];
    codeView.problemName = problemName;
    [delegate.mainViewController pushViewController:codeView animated:YES];
}


@end
