//
//  ProblemListViewController.m
//  CodersAnswer
//
//  Created by rogers on 3/12/14.
//  Copyright (c) 2014 com.rogers140. All rights reserved.
//

#import "ProblemListViewController.h"
#import "AppDelegate.h"
#import "Problem.h"

@interface ProblemListViewController ()

@property (strong, nonatomic) NSArray *problemList;
@property (strong, nonatomic) NSMutableArray *filteredProblemList;

@end

@implementation ProblemListViewController

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
    self.filteredProblemList = [[NSMutableArray alloc]initWithArray:self.problemList];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)menuClicker:(id)sender
{
    //open drawer
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.drawer open];
}

- (void) dismissKeyboard
{
    // add self
    [self.searchBar resignFirstResponder];
}

#pragma mark define table

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"problem_cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"problem_cell"];
    }
    Problem *problem;
    if (self.filteredProblemList != Nil && self.filteredProblemList.count != 0) {
        problem = [self.filteredProblemList objectAtIndex:indexPath.row];
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
    return [self.filteredProblemList count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissKeyboard];
    //NSDictionary *dic = [self.problemList objectAtIndex:indexPath.row];
    Problem *problem = [self.problemList objectAtIndex:indexPath.row];
    NSString *problemName = problem.problemName;
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    CodeViewController *codeView = [[CodeViewController alloc]init];
    codeView.problemName = problemName;
    
    [delegate.mainViewController pushViewController:codeView animated:YES];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
{
    if (searchText!=nil && searchText.length>0) {
        self.filteredProblemList= [NSMutableArray array];
        for (Problem *problem in self.problemList) {
            if ([problem.problemName rangeOfString:searchText options:NSCaseInsensitiveSearch].length > 0 ) {
                [self.filteredProblemList addObject:problem];
            }
        }
        [self.problemListTable reloadData];
    }
    else
    {
        self.filteredProblemList = [NSMutableArray arrayWithArray:self.problemList];
        [self.problemListTable reloadData];
    }
    
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //[self searchBar:self.searchBar textDidChange:nil];
    [_searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    //[self searchBar:self.searchBar textDidChange:nil];
    [_searchBar resignFirstResponder];
}
@end
