//
//  GradientView.m
//  weather
//
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "GradientView.h"

#define GRADIENT_COLOR_1    [[UIColor colorWithRed:80/255.0 green:148/255.0 blue:180/255.0 alpha:1.0] CGColor]
#define GRADIENT_COLOR_2    [[UIColor colorWithRed:13/255.0 green:94/255.0 blue:180/255.0 alpha:1.0] CGColor]

@implementation GradientView

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (void)awakeFromNib
{
    CAGradientLayer *gradientLayer  = (CAGradientLayer *)self.layer;
    gradientLayer.colors            = @[(id)GRADIENT_COLOR_1,(id)GRADIENT_COLOR_2];
}

@end
