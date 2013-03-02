//
//  LocationManager.h
//  weather
//
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kLocationDidChangeNotificationKey;

@interface LocationManager : NSObject

@property (nonatomic, readonly) CLLocation *currentLocation;
@property (nonatomic, readonly) BOOL       isMonitoringLocation;

+ (instancetype)sharedManager;

- (void)startMonitoringLocationChanges;
- (void)stopMonitoringLocationChanges;

@end
