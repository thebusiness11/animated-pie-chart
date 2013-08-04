//
//  MLVPieSlice.m
//  AnimatedPieChart
//
//  Created by Lance Velasco on 8/4/13.
//  Copyright (c) 2013 MLV Group. All rights reserved.
//

#import "MLVPieSlice.h"

@implementation MLVPieSlice

- (id) initWithPercent:(float) pct andTitle:(NSString *)title andDescription:(NSString *) description andColor:(NSString *) color
{
    self = [super init];
    if (self) {
        self.pct = pct;
        self.title = title;
        self.description = description;
        self.color = color;
    }
    return self;
}


@end
