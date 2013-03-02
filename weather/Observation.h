//
//  Observation.h
//  weather
//
//  Created by NSCookbook on 2/24/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Observation : NSObject

@property (nonatomic, strong) NSDictionary  *location;
@property (nonatomic, strong) NSDictionary  *observationLocation;
@property (nonatomic, strong) NSDictionary  *weatherUndergroundImageInfo;

@property (nonatomic, strong) NSString      *timeString;
@property (nonatomic, strong) NSString      *timeStringRFC822;
@property (nonatomic, strong) NSString      *weatherDescription;
@property (nonatomic, strong) NSString      *windDescription;
@property (nonatomic, strong) NSString      *temperatureDescription;
@property (nonatomic, strong) NSString      *feelsLikeTemperatureDescription;
@property (nonatomic, strong) NSString      *relativeHumidity;
@property (nonatomic, strong) NSString      *dewpointDescription;
@property (nonatomic, strong) NSString      *iconName;
@property (nonatomic, strong) NSString      *iconUrl;

@property (nonatomic, strong) NSNumber      *temperatureF;
@property (nonatomic, strong) NSNumber      *temperatureC;
@property (nonatomic, strong) NSNumber      *feelsLikeTemperatureF;
@property (nonatomic, strong) NSNumber      *feelsLikeTemperatureC;

+ (instancetype)observationWithDictionary:(NSDictionary *)dictionary;

@end
