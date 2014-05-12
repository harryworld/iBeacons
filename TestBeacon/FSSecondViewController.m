//
//  FSSecondViewController.m
//  TestBeacon
//
//  Created by Forrest Shi on 5/9/14.
//  Copyright (c) 2014 Request. All rights reserved.
//

#import "FSSecondViewController.h"
#import "Beacon.h"

@interface FSSecondViewController ()<BeaconNotificationDelegate>{

    Beacon *b;
}


@end

@implementation FSSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if (!b) {
        b = [Beacon new];
        b.delegate = self;
        
    }
    [b startMonitorBeacon];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)NotifyWhenEntry{
    [self sendLocalNotificationWithMessage:@"Weclome !"];
    
    self.view.backgroundColor = [UIColor redColor];
}
- (void)NotifyWhenExit{
    [self sendLocalNotificationWithMessage:@"Goodbye"];
    
    
    self.view.backgroundColor = [UIColor blueColor];
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
