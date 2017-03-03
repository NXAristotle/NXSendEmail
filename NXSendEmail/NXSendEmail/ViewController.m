//
//  ViewController.m
//  NXSendEmail
//
//  Created by linyibin on 2017/3/3.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController ()<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)sendEmail:(UIButton *)sender {
   
    if ([MFMailComposeViewController canSendMail]) { // 用户已设置邮件账户
        
        [self setupEmailContent];
    }
    
}


#pragma mark - 设置email的内容
//  设置email的内容
- (void)setupEmailContent {
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    //  设置代理
    [picker setMailComposeDelegate:self];
    //  设置主题
    [picker setSubject:@"邮件的主题"];
    
    //  设置收件人
    [picker setToRecipients:[NSArray arrayWithObjects:@"100000@qq.com", nil]];
    //  设置抄送人
    [picker setCcRecipients:[NSArray arrayWithObjects:@"10000@qq.com", nil]];
    //  设置密抄送
    [picker setBccRecipients:[NSArray arrayWithObjects:@"xxx@outlook.com", nil]];
    //  设置邮件的正文内容(内容可以是HTML格式)
    [picker setMessageBody:self.contentTextView.text isHTML:NO];
    //  添加附件内容
        UIImage *image = [UIImage imageNamed:@"star"];
        NSData *imageData = UIImagePNGRepresentation(image);
        [picker addAttachmentData:imageData mimeType:@"" fileName:@"custom.png"];
    NSString *file = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"pdf"];
    NSData *pdf = [NSData dataWithContentsOfFile:file];
    [picker addAttachmentData:pdf mimeType:@"" fileName:@"龙猫钓鱼"];
    
    //  弹出视图
    [self presentViewController:picker animated:YES completion:^{
        
    }];
    
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result)
    {
        case MFMailComposeResultCancelled: // 用户取消编辑
            NSLog(@"Mail send canceled...");
            break;
        case MFMailComposeResultSaved: // 用户保存邮件
            NSLog(@"Mail saved...");
            break;
        case MFMailComposeResultSent: // 用户点击发送
            NSLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed: // 用户尝试保存或发送邮件失败
            NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            break;
    }
    NSLog(@"--==:result :%zd  %@",result,error);
   
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
