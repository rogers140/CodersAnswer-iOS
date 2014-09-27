//
//  AppDelegate.m
//  CodersAnswer
//
//  Created by rogers on 3/11/14.
//  Copyright (c) 2014 com.rogers140. All rights reserved.
//

#import "AppDelegate.h"
#import "ICSDrawerController.h"
#import "MainViewController.h"
#import "DrawerViewController.h"
#import "ProblemListViewController.h"
#import "FileHandler.h"
#import "Problem.h"
#import "LaunchImageTransition.h"
#import "CodeViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    //init problemList
    self.problemList = [[NSArray alloc] initWithObjects:
                        //1-10
                        [[Problem alloc]initWithInfo:@"Two Sum" :@"level_2.png" :@"array, sort, hash"],
                        [[Problem alloc]initWithInfo:@"Median of Two Sorted Arrays" :@"level_5.png" :@"array, binary search"],
                        [[Problem alloc]initWithInfo:@"Longest Substring Without Repeating Characters" :@"level_3.png" :@"hash"],
                        [[Problem alloc]initWithInfo:@"Add Two Numbers" :@"level_3.png" :@"linked list"],
                        [[Problem alloc]initWithInfo:@"Longest Palindromic Substring" :@"level_4.png" :@"string"],
                        [[Problem alloc]initWithInfo:@"ZigZag Conversion" :@"level_3.png" :@"string"],
                        [[Problem alloc]initWithInfo:@"Reverse Integer" :@"level_2.png" :@"math"],
                        [[Problem alloc]initWithInfo:@"String to Integer" :@"level_2.png" :@"string, math"],
                        [[Problem alloc]initWithInfo:@"Palindrome Number" :@"level_2.png" :@"math"],
                        [[Problem alloc]initWithInfo:@"Regular Expression Matching" :@"level_5.png" :@"string, recursion"],
                        //11-20
                        [[Problem alloc]initWithInfo:@"Container With Most Water" :@"level_3.png" :@"array"],
                        [[Problem alloc]initWithInfo:@"Integer to Roman" :@"level_3.png" :@"math"],
                        [[Problem alloc]initWithInfo:@"Roman to Integer" :@"level_2.png" :@"math"],
                        [[Problem alloc]initWithInfo:@"Longest Common Prefix" :@"level_2.png" :@"string"],
                        [[Problem alloc]initWithInfo:@"3Sum" :@"level_3.png" :@"array"],
                        [[Problem alloc]initWithInfo:@"3Sum Closest" :@"level_3.png" :@"array"],
                        [[Problem alloc]initWithInfo:@"4Sum" :@"level_3.png" :@"array"],
                        [[Problem alloc]initWithInfo:@"Letter Combinations of a Phone Number" :@"level_3.png" :@"DFS"],
                        [[Problem alloc]initWithInfo:@"Remove Nth Node From End of List" :@"level_2.png" :@"linked list"],
                        [[Problem alloc]initWithInfo:@"Longest Common Prefix" :@"level_1.png" :@"string"],
                        //21-30
                        [[Problem alloc]initWithInfo:@"Valid Parentheses" :@"level_2.png" :@"stack"],
                        [[Problem alloc]initWithInfo:@"Generate Parentheses" :@"level_4.png" :@"string, DFS"],
                        [[Problem alloc]initWithInfo:@"Merge k Sorted Lists" :@"level_3.png" :@"linked list, heap, merge"],
                        [[Problem alloc]initWithInfo:@"Swap Nodes in Pairs" :@"level_2.png" :@"linked list"],
                        [[Problem alloc]initWithInfo:@"Reverse Nodes in k-Group" :@"level_4.png" :@"linked list"],
                        [[Problem alloc]initWithInfo:@"Remove Duplicates from Sorted Array" :@"level_1.png" :@"array"],
                        [[Problem alloc]initWithInfo:@"Remove Element" :@"level_1.png" :@"array"],
                        [[Problem alloc]initWithInfo:@"Implement strStr()" :@"level_4.png" :@"string, KMP, hash"],
                        [[Problem alloc]initWithInfo:@"Divide Two Integers" :@"level_4.png" :@"binary search"],
                        [[Problem alloc]initWithInfo:@"Substring with Concatenation of All Words" :@"level_3.png" :@"string"],
                        //31-40
                        [[Problem alloc]initWithInfo:@"Next Permutation" :@"level_5.png" :@"array"],
                        [[Problem alloc]initWithInfo:@"Longest Valid Parentheses" :@"level_4.png" :@"string, DP"],
                        [[Problem alloc]initWithInfo:@"Search in Rotated Sorted Array" :@"level_4.png" :@"binary search"],
                        [[Problem alloc]initWithInfo:@"Search for a Range" :@"level_4.png" :@"binary search"],
                        [[Problem alloc]initWithInfo:@"Search Insert Position" :@"level_2.png" :@"array"],
                        [[Problem alloc]initWithInfo:@"Valid Sudoku" :@"level_2.png" :@"array"],
                        [[Problem alloc]initWithInfo:@"Sudoku Solver" :@"level_4.png" :@"recursive, DFS"],
                        [[Problem alloc]initWithInfo:@"Count and Say" :@"level_2.png" :@"two pointer"],
                        [[Problem alloc]initWithInfo:@"Combination Sum" :@"level_3.png" :@"combination"],
                        [[Problem alloc]initWithInfo:@"Combination Sum II" :@"level_4.png" :@"combination"],
                        //41-50
                        [[Problem alloc]initWithInfo:@"First Missing Positive" :@"level_5.png" :@"math"],
                        [[Problem alloc]initWithInfo:@"Trapping Rain Water" :@"level_5.png" :@""],
                        [[Problem alloc]initWithInfo:@"Multiply Strings" :@"level_4.png" :@"math"],
                        [[Problem alloc]initWithInfo:@"Wildcard Matching" :@"level_5.png" :@"DP"],
                        [[Problem alloc]initWithInfo:@"Jump Game II" :@"level_4.png" :@"array"],
                        [[Problem alloc]initWithInfo:@"Permutations" :@"level_3.png" :@"DFS"],
                        [[Problem alloc]initWithInfo:@"Permutations II" :@"level_4.png" :@"DFS"],
                        [[Problem alloc]initWithInfo:@"Rotate Image" :@"level_4.png" :@"math, recursive"],
                        [[Problem alloc]initWithInfo:@"Anagrams" :@"level_3.png" :@"hash"],
                        [[Problem alloc]initWithInfo:@"Pow(x, n)" :@"level_3.png" :@"binary"],
                        nil];
    
    self.drawerViewController = [[DrawerViewController alloc] init];
    
    self.problemListMain = [[MainViewController alloc] init];
    
    self.mainViewController = self.problemListMain;
    
    
    self.mainViewController.view.backgroundColor = [UIColor whiteColor];
    self.drawer = [[ICSDrawerController alloc] initWithLeftViewController:self.drawerViewController
                                                     centerViewController:self.mainViewController];
    self.problemListViewController = [[ProblemListViewController alloc]init];
    self.problemListViewController.title = @"Problem List";
    
    
    [self.problemListMain pushViewController:self.problemListViewController animated:YES];
    
    //self.window.rootViewController = self.drawer;
    self.window.rootViewController = [[LaunchImageTransition alloc] initWithViewController:self.drawer animation:UIModalTransitionStyleCrossDissolve delay:0.0];
    FileHandler *fileHandler;
    fileHandler = [FileHandler getInstance];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//dealing rotate
//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
//{
//    NSUInteger orientations = UIInterfaceOrientationMaskPortrait;
//    NSLog(@"judge");
//    if([[self.mainViewController topViewController] isKindOfClass:[CodeViewController class]])
//    {
//        orientations = UIInterfaceOrientationMaskAllButUpsideDown;
//    }
//    else {
//        orientations = UIInterfaceOrientationMaskPortrait;
//    }
//    return orientations;
//}
@end
