//
//  FeedBackViewController.m
//  CodersAnswer
//
//  Created by rogers on 3/13/14.
//  Copyright (c) 2014 com.rogers140. All rights reserved.
//

#import "FeedBackViewController.h"
#import "AppDelegate.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

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
    
    //open mail
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil)
    {
        if ([mailClass canSendMail])
        {
            [self sendEmail];   // 调用发送邮件的方法
        }
        else {
            [self launchMailAppOnDevice];   // 调用客户端邮件程序
        }
    }
    else {
        [self launchMailAppOnDevice];    // 调用客户端邮件程序
    }
    
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

- (void)sendEmail
{
    MFMailComposeViewController *sendMailViewController = [[MFMailComposeViewController alloc] init];
    sendMailViewController.mailComposeDelegate = self;
    
    // 设置邮件主题
    [sendMailViewController setSubject:@"Feedback of CodersAnswer"];
    
    /*
     * 设置收件人，收件人有三种
     */
    // 设置主收件人
    [sendMailViewController setToRecipients:[NSArray arrayWithObject:@"rogers140@me.com"]];
    // 设置CC
    //[sendMailViewController setCcRecipients:[NSArray arrayWithObject:@"example@hotmail.com"]];
    // 设置BCC
    //[sendMailViewController setBccRecipients:[NSArray arrayWithObject:@"example@gmail.com"]];
    
    /*
     * 设置邮件主体，有两种格式
     */
    // 一种是纯文本
    [sendMailViewController setMessageBody:@"" isHTML:NO];
    // 一种是HTML格式（HTML和纯文本两种格式按需求选择一种即可）
    //[mailVC setMessageBody:@"<HTML><B>Hello World!</B><BR/>Is everything OK?</HTML>" isHTML:YES];
    
    // 添加附件
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"feedback" ofType:@"png"];
    //NSData *data = [NSData dataWithContentsOfFile:path];
    //[sendMailViewController addAttachmentData:data mimeType:@"image/png" fileName:@"feedback"];
    
    // 视图呈现
    [self presentViewController:sendMailViewController animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultCancelled: {
            //NSLog(@"Mail send canceled.");
            break;
        }
        case MFMailComposeResultSaved: {
            //NSLog(@"Mail saved.");
            break;
        }
        case MFMailComposeResultSent: {
            //NSLog(@"Mail sent.");
            break;
        }
        case MFMailComposeResultFailed: {
            //NSLog(@"Mail sent Failed.");
            break;
        }
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)launchMailAppOnDevice
{
    NSString *recipients = @"mailto:rogers140@me.com&subject=Feedback of CodersAnswer";
    NSString *body = @"&body= sent from my iphone.";
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
}
@end
