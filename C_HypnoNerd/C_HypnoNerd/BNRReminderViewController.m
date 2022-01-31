//
//  BNRReminderViewController.m
//  C_HypnoNerd
//
//  Created by yl on 2022/1/31.
//

#import "BNRReminderViewController.h"
@interface BNRReminderViewController()
@property (nonatomic,weak) IBOutlet UIDatePicker *datePicker;
@end

@implementation BNRReminderViewController

- (IBAction)addReminder:(id)sender
{
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a remember for %@",date);
}

@end
