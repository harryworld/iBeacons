//
//  Beacon.h
//  Beacon
//
//  Copyright (c) 2014 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;
@import CoreBluetooth;

@protocol BeaconNotificationDelegate <NSObject>

- (void)NotifyWhenEntry;
- (void)NotifyWhenExit;

@end


@interface Beacon : NSObject<CLLocationManagerDelegate>

@property (nonatomic,assign) id<BeaconNotificationDelegate> delegate;

- (void) startMonitorBeacon;

@end
