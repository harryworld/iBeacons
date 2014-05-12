//
//  FSFirstViewController.m
//  TestBeacon
//
//  Created by Forrest Shi on 5/9/14.
//  Copyright (c) 2014 Request. All rights reserved.
//

#import "FSFirstViewController.h"
#import "Beacon.h"

@interface FSFirstViewController ()<BeaconNotificationDelegate>


@end

@implementation FSFirstViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    Beacon *b = [Beacon new];
    b.delegate = self;
    

//    [b startMonitorBeacon];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)NotifyWhenEntry{
    [self sendLocalNotificationWithMessage:@"Weclome !"];
}
- (void)NotifyWhenExit{
    [self sendLocalNotificationWithMessage:@"Goodbye"];
}


#pragma mark - Local notifications
- (void)sendLocalNotificationWithMessage:(NSString*)message
{
    UILocalNotification *notification = [UILocalNotification new];
    
    // Notification details
    notification.alertBody = message;
   // notification.alertBody = [NSString stringWithFormat:@"Entered beacon region for UUID: %@",
     //                         region.proximityUUID.UUIDString];   // Major and minor are not available at the monitoring stage
    notification.alertAction = NSLocalizedString(@"View Details", nil);
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}



@end
