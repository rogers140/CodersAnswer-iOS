//
//  ProblemListViewController.h
//  CodersAnswer
//
//  Created by rogers on 3/12/14.
//  Copyright (c) 2014 com.rogers140. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProblemListViewController : UIViewController <UISearchBarDelegate, UISearchDisplayDelegate,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *problemListTable;
@end
