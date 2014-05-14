//
//  FSSecondViewController.m
//  TestBeacon
//
//  Created by Forrest Shi on 5/9/14.
//  Copyright (c) 2014 Request. All rights reserved.
//

#import "FSSecondViewController.h"
#import "Beacon.h"
#import <AFNetworking/AFNetworking.h>

#define kRequestActivity @"http://www.reque.st/api/activity"


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

- (void)viewWillAppear:(BOOL)animated{
    
    NSArray *objects = [NSArray arrayWithObjects:@"user1@1q2w3e", @"1q2w3e", nil];
    NSArray *keys = [NSArray arrayWithObjects:@"beaconId", @"strength", nil];
    NSDictionary *questionDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObject:questionDict forKey:@"question"];
    
    NSError *error;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:jsonDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
    
    NSLog(@"jsonRequest is %@", jsonString);
    
    NSURL *url = [NSURL URLWithString:kRequestActivity];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (connection) {
        [connection start];
    }
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
