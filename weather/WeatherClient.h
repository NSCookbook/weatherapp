//
//  WeatherClient.h
//  Weather
//
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "Observation.h"

@interface WeatherClient : AFHTTPClient

+ (instancetype)sharedClient;

- (void)getCurrentWeatherObservationForLocation:(CLLocation *)location completion:(void(^)(Observation *observation, NSError *error))completion;
        
@end
