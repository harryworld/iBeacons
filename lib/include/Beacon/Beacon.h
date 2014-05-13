//
//  Beacon.h
//  Beacon
//
//  Copyright (c) 2014 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;
@import CoreBluetooth;

static NSString * const kUUID = @"B9407F30-F5F8-466E-AFF9-25556B57FE6D";
static NSString * const kIdentifier = @"SomeIdentifier";

static NSUInteger const kMajor = 1000;
static NSUInteger const kMinor = 2000;

@protocol BeaconNotificationDelegate <NSObject>

- (void)NotifyWhenEntry;
- (void)NotifyWhenExit;

@end


@interface Beacon : NSObject<CLLocationManagerDelegate>

@property (nonatomic,assign) id<BeaconNotificationDelegate> delegate;

- (void) startMonitorBeacon;

@end
