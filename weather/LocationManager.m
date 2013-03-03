//
//  LocationManager.m
//  weather
//
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "LocationManager.h"

NSString * const kLocationDidChangeNotificationKey = @"locationManagerlocationDidChange";

@interface LocationManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, readwrite) BOOL           isMonitoringLocation;

@end

@implementation LocationManager

+ (instancetype)sharedManager
{
    static LocationManager *_sharedLocationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedLocationManager = [[LocationManager alloc] init];
    });
    
    return _sharedLocationManager;
}

#pragma mark - Public API

- (void)startMonitoringLocationChanges
{
    if ([CLLocationManager locationServicesEnabled])
    {
        if (!self.isMonitoringLocation)
        {
            self.isMonitoringLocation = YES;
            self.locationManager.delegate = self;
            [self.locationManager startMonitoringSignificantLocationChanges];
        }
    }
    else
    {
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled" message:@"This app requires location services to be enabled" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [servicesDisabledAlert show];
    }
}

- (void)stopMonitoringLocationChanges
{
    if (_locationManager)
    {
        [self.locationManager stopMonitoringSignificantLocationChanges];
        self.locationManager.delegate = nil;
        self.isMonitoringLocation = NO;
        self.locationManager = nil;
    }
}

#pragma mark - Accessors

- (CLLocationManager *)locationManager
{
    if (!_locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];
//        [_locationManager setDistanceFilter:1000];
//        [_locationManager setDesiredAccuracy: kCLLocationAccuracyThreeKilometers];
    }
    
    return _locationManager;
}

- (CLLocation *)currentLocation
{
    return self.locationManager.location;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:2];
    if (newLocation) {
        userInfo[@"newLocation"] = newLocation;
    }
    if (oldLocation) {
        userInfo[@"oldLocation"] = oldLocation;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLocationDidChangeNotificationKey
                                                        object:self
                                                      userInfo:userInfo];
}

- (void)locationManager:(CLLocationManager*)manager didFailWithError:(NSError*)error
{
    if ([error code]== kCLErrorDenied)
    {
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Denied" message:@"This app requires location services to be allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [servicesDisabledAlert show];
    }
}

@end
