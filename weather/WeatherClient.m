//
//  WeatherClient.m
//  Weather
//
//  Created by NSCookbook on 2/17/13.
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
#import "WeatherAPIKey.h"

static NSString * const kWeatherUndergroundAPIBaseURLString = @"http://api.wunderground.com/api/";

@implementation WeatherClient

#pragma mark - Singleton

+ (instancetype)sharedClient
{
    static WeatherClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *baseURLString = [kWeatherUndergroundAPIBaseURLString stringByAppendingString:kWeatherUndergroundAPIKey];
        sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseURLString]];
    });
    
    return sharedClient;
}

#pragma mark - Initialization

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self)
    {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }

    return self;
}

#pragma mark - Public API

- (void)getCurrentWeatherObservationForLocation:(CLLocation *)location completion:(void(^)(Observation *observation, NSError *error))completion
{
    if (location)
    {
        // We have to do this because their API is not exactly rest
        NSString *getPath = [NSString stringWithFormat:@"conditions/q/%.6f,%.6f.json", location.coordinate.latitude, location.coordinate.longitude];
        WeatherClient *client = [WeatherClient sharedClient];
        [client getPath:getPath
             parameters:nil
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    Observation *observation = [Observation observationWithDictionary:responseObject[@"current_observation"]];
                    completion(observation, nil);
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    completion(nil, error);
                }
         ];
    }
    else
    {
        completion(nil, [NSError errorWithDomain:@"Invalid Location as argument" code:-1 userInfo:nil]);
    }
}

@end
