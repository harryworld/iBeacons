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

const NSString* kRequestActivity = @"http://www.reque.st/api/activity";


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
//
    // Post always has the issue  unacceptable content-type: text/html",
    
    //AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager alloc] ;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];

    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    manager.requestSerializer = requestSerializer;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    NSDictionary *parameters = @{@"beaconId": @"112233"};
//    [manager POST:@"http://www.reque.st/api/activity" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"Error: %@", error);
//    }];
    
    [manager POST:kRequestActivity parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        //
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];
    
    
    // Get can work fine
    
//    // 1
//    //NSString *string = [NSString stringWithFormat:@"%@weather.php?format=json", BaseURLString];
//    NSURL *url = [NSURL URLWithString:kRequestActivity];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    // 2
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        // 3
//        NSLog(@"%@",responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        // 4
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
//                                                            message:[error localizedDescription]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
//    }];
//    
//    
//    // 5
//    [operation start];
    
    
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
