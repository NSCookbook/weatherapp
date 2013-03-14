//
//  WeatherAPITest.m
//  Weather
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


#import "WeatherClient.h"
#import "GHUnit.h"

#define kNetworkTimeout 30.0f

@interface WeatherAPITest : GHAsyncTestCase

@end

@implementation WeatherAPITest

- (void)testObservation
{
    [self prepare];
    
    __block NSError     *responseError      = nil;
    __block Observation *resposeObservation = nil;
    
    WeatherClient *sharedClient = [WeatherClient sharedClient];
    
    // Known Location (San Francisco)
    CLLocation *knownLocation = [[CLLocation alloc] initWithLatitude:37.7750 longitude:122.4183];

    [sharedClient getCurrentWeatherObservationForLocation:knownLocation completion:^(Observation *observation, NSError *error) {
    
        responseError = error;
        resposeObservation = observation;
        
        [self notify:kGHUnitWaitStatusSuccess forSelector:_cmd];
    }];
    
    // Wait for the async activity to complete
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];
    
    // Check for Observation Object & Error
    GHAssertNil(responseError, @"");
    GHAssertNotNil(resposeObservation, @"Response Observation is nil");
    
    // Validate (some) data
    GHAssertNotNil(resposeObservation.location, @"Response Observation.location is nil");
    GHAssertNotNil(resposeObservation.timeString, @"Response Observation.timeString is nil");
    GHAssertNotNil(resposeObservation.temperatureDescription, @"Response Observation.temperatureDescription is nil");
}

@end
