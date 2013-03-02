//
//  Observation.m
//  weather
//
//  Created by NSCookbook on 2/24/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "Observation.h"

@implementation Observation

+ (NSDictionary *)keyMapping
{
    static NSDictionary *keyMapping = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        keyMapping = @{
                        @"display_location"             : @"location",
                        @"observation_location"         : @"observationLocation",
                        @"image"                        : @"weatherUndergroundImageInfo",
                        @"observation_time"             : @"timeString",
                        @"observation_time_rfc822"      : @"timeStringRFC822",
                        @"weather"                      : @"weatherDescription",
                        @"wind_string"                  : @"windDescription",
                        @"temperature_string"           : @"temperatureDescription",
                        @"feelslike_string"             : @"feelsLikeTemperatureDescription",
                        @"relative_humidity"            : @"relativeHumidity",
                        @"dewpoint_string"              : @"dewpointDescription",
                        @"icon"                         : @"iconName",
                        @"icon_url"                     : @"iconUrl",
                        @"temp_f"                       : @"temperatureF",
                        @"temp_c"                       : @"temperatureC",
                        @"feelslike_f"                  : @"feelsLikeTemperatureF",
                        @"feelslike_c"                  : @"feelsLikeTemperatureC"
                      };
    });
    
    return keyMapping;
}

+ (instancetype)observationWithDictionary:(NSDictionary *)dictionary
{
    Observation *observation = nil;
    if (dictionary)
    {
        observation = [[Observation alloc] init];
        NSDictionary *keyMapping = [self keyMapping];
        for (NSString *key in keyMapping)
        {
            id value = dictionary[key];
            if (value)
            {
                [observation setValue:value forKey:keyMapping[key]];
            }
        }
    }

    return observation;
}

@end
