//
//  BNRReminderViewController.m
//  C_HypnoNerd
//
//  Created by yl on 2022/1/31.
//

#import <UserNotifications/UserNotifications.h>
#import "BNRReminderViewController.h"

@interface BNRReminderViewController()
@property (nonatomic,weak) IBOutlet UIDatePicker *datePicker;
@end

@implementation BNRReminderViewController

- (IBAction)addReminder:(id)sender
{
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a remember for %@",date);
    
    // 推送本地通知 参考:
    // https://stackoverflow.com/questions/37938771/uilocalnotification-is-deprecated-in-ios-10
    // https://www.jianshu.com/p/bed37cfe7386
    //https://betterprogramming.pub/how-to-send-push-notifications-to-the-ios-simulator-2988092ba931
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.badge = [NSNumber numberWithInt:1];
    content.title = @"HypnotizeTitle";
    content.body = @"Hypnotize me!";
    content.sound = [UNNotificationSound defaultSound];
    // 间隔多久推送一次
    // 设置时间方法一: 当前时间之后的没分钟推送一次(如果重复的话时间要大于等于60s)
    //            UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:60 repeats:YES];
    // 设置时间方法二: 定时推送
    //              NSDateComponents *dateCom = [[NSDateComponents alloc] init];
    //              // 每天下午两点五十五分推送
    //              dateCom.hour = 2;
    //              dateCom.minute = 55;
    
    // 设置时间方法三: NSDate 转 NSDateComponents
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateCom = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateCom repeats:YES];
    
    UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:@"request1" content:content trigger:trigger];
    [center addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
    }];
    
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        // 设置标签项的标题
        self.tabBarItem.title = @"Reminder";
        
        // 从图像文件创建一个UIImage对象
        UIImage *i = [UIImage imageNamed:@"Time.png"];
        
        // 将UIImage对象赋给标签项的image属性
        self.tabBarItem.image = i;
        
    }
    return self;
}

@end
