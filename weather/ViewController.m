//
//  ViewController.m
//  weather
//
//  Created by NSCookbook on 2/23/13.
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

#import "ViewController.h"

#import <SVProgressHUD/SVProgressHUD.h>

#import "WeatherClient.h"
#import "LocationManager.h"

@implementation ViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
    
    __weak ViewController *weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:kLocationDidChangeNotificationKey
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      NSLog(@"Note: %@", note);
                                                      [weakSelf reloadData];
                                                  }];
    
    [[LocationManager sharedManager] startMonitoringLocationChanges];
}

- (void)viewDidLayoutSubviews
{
    // Need to adjust the shadow path when the views bounds change
    self.shadowContainerView.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:self.shadowContainerView.bounds cornerRadius:6.0f] CGPath];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[LocationManager sharedManager] stopMonitoringLocationChanges];
}

#pragma mark - Private

- (void)setupViews
{
    self.observationContainerView.clipsToBounds = YES;
    self.observationContainerView.layer.cornerRadius = 6.0f;
    self.observationContainerView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.observationContainerView.layer.borderWidth  = 3.0f;
    
    self.shadowContainerView.backgroundColor = [UIColor clearColor];
    self.shadowContainerView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.shadowContainerView.layer.shadowOffset = CGSizeZero;
    self.shadowContainerView.layer.shadowOpacity = 0.65f;
    self.shadowContainerView.layer.shadowRadius = 4.0f;
    self.shadowContainerView.hidden = YES;    
}

- (void)updateUIWithObservation:(Observation *)observation
{
    if (observation)
    {
        self.shadowContainerView.hidden = NO;
        
        [self.currentConditionImageView setImageWithURL:[NSURL URLWithString:observation.iconUrl]];
        [self.weatherUndergroundImageView setImageWithURL:[NSURL URLWithString:observation.weatherUndergroundImageInfo[@"url"]]];
        
        self.locationLabel.text = observation.location[@"full"];
        self.currentTemperatureLabel.text = observation.temperatureDescription;
        self.feelsLikeTemperatureLabel.text = [@"Feels like " stringByAppendingString:observation.feelsLikeTemperatureDescription];
        self.weatherDescriptionLabel.text = observation.weatherDescription;
        self.windDescriptionLabel.text = observation.windDescription;
        self.humidityLabel.text = observation.relativeHumidity;
        self.dewpointLabel.text = observation.dewpointDescription;
        self.lastUpdatedLabel.text = observation.timeString;
    }
    else
    {
        self.shadowContainerView.hidden = YES;
    }
}

- (void)reloadData
{
    WeatherClient *client = [WeatherClient sharedClient];
    CLLocation *location = [[LocationManager sharedManager] currentLocation];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    
    __weak ViewController *weakSelf = self;
    [client getCurrentWeatherObservationForLocation:location completion:^(Observation *observation, NSError *error) {
        if (error)
        {
            NSLog(@"Web Service Error: %@", [error description]);
        }
        else
        {
            [weakSelf updateUIWithObservation:observation];
        }
        
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - Actions

- (IBAction)refresh:(id)sender
{
    [self reloadData];
}

@end
