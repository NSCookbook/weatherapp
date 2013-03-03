//
//  ViewController.h
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

#import <UIKit/UIKit.h>
#import "GradientView.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView       *shadowContainerView;
@property (strong, nonatomic) IBOutlet GradientView *observationContainerView;

@property (strong, nonatomic) IBOutlet UILabel      *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel      *currentTemperatureLabel;
@property (strong, nonatomic) IBOutlet UILabel      *feelsLikeTemperatureLabel;
@property (strong, nonatomic) IBOutlet UILabel      *weatherDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel      *windDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel      *humidityLabel;
@property (strong, nonatomic) IBOutlet UILabel      *dewpointLabel;
@property (strong, nonatomic) IBOutlet UILabel      *lastUpdatedLabel;

@property (strong, nonatomic) IBOutlet UIImageView  *currentConditionImageView;
@property (strong, nonatomic) IBOutlet UIImageView  *weatherUndergroundImageView;

- (IBAction)refresh:(id)sender;

@end
