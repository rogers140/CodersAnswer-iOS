//
//  FileHandler.m
//  CodersAnswer
//
//  Created by rogers on 3/12/14.
//  Copyright (c) 2014 com.rogers140. All rights reserved.
//

#import "FileHandler.h"
static FileHandler *instance = Nil;

@implementation FileHandler
{
    NSString *filePath;
    NSMutableArray *starList;
}

+ (FileHandler *) getInstance
{
    if (instance == Nil) {
        instance = [[FileHandler alloc]init];
    }
    return instance;
}

- (id) init
{
    self = [super init];
    NSString *documentsPath =[self dirDoc];
    NSString *appDirectory = [documentsPath stringByAppendingPathComponent:@"CodersAnswer"];
    filePath = [appDirectory stringByAppendingPathComponent:@"StarList.txt"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filePath isDirectory:NO]) {
        NSError *error;
        starList =[[NSMutableArray alloc]initWithArray: [[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error] componentsSeparatedByString:@","]];
        if ([[starList objectAtIndex:0] isEqualToString:@""]) {
            [starList removeObjectAtIndex:0];
        }
    }
    else {
        [self createDir];
        [self createFile];
        starList = [[NSMutableArray alloc]init];
    }
    //filePath = [[NSBundle mainBundle] pathForResource:@"StarList" ofType:@"txt"];
    
    return self;
}

//获取Documents目录
-(NSString *) dirDoc{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"app_home_doc: %@",documentsDirectory);
    return documentsDirectory;
}

//创建文件夹
-(void) createDir{
    NSString *documentsPath =[self dirDoc];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"CodersAnswer"];
    // 创建目录
    BOOL res=[fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    if (res) {
        //NSLog(@"文件夹创建成功");
    }
    else {
        //NSLog(@"文件夹创建失败");
    }
}

//创建文件
-(void) createFile{
    NSString *documentsPath =[self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"CodersAnswer"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testPath = [testDirectory stringByAppendingPathComponent:@"StarList.txt"];
    BOOL res=[fileManager createFileAtPath:testPath contents:nil attributes:nil];
    if (res) {
        //NSLog(@"文件创建成功");
    }
    else {
        //NSLog(@"文件创建失败");
    }
}

- (BOOL) starCheck:(NSString *)problemName
{
    for (NSString *name in starList) {
        if ([name isEqualToString:problemName]) {
            return YES;
        }
    }
    return NO;
}
- (void) addToStarList: (NSString *)problemName
{
    [starList addObject:problemName];
    [self push];
}
- (void) deleteFromStarList: (NSString *)problemName
{
    int i = 0;
    BOOL flag = NO;
    for (NSString *name in starList) {
        if ([name isEqualToString:problemName]) {
            flag = YES;
            break;
        }
        ++i;
    }
    if (flag) {
        [starList removeObjectAtIndex:i];
    }
    [self push];
    
}

- (void)push
{
    NSString *content = [[NSString alloc]init];
    int length = (int)starList.count;
    for (int i = 0; i < length - 1; ++i) {
        content = [content stringByAppendingString:[starList objectAtIndex:i]];
        content = [content stringByAppendingString:@","];
    }
    int last = length - 1;
    if (last >= 0) {
        content = [content stringByAppendingString:[starList objectAtIndex:last]];
    }
//    NSLog(@"length%d", length);
//    NSLog(@"last one:%@", [starList objectAtIndex:last]);
//    NSLog(@"content:%@", content);
    
    BOOL state = [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:Nil];
    if (state) {
        //NSLog(@"%@", @"SUCCESS");
    }
    else {
        //NSLog(@"%@", @"fail");
    }
}

- (NSMutableArray *) getStarList
{
    NSMutableArray *returnArray = [[NSMutableArray alloc]init];
    for (NSString *name in starList) {
        [returnArray addObject:name];
    }
    return returnArray;
}

@end
