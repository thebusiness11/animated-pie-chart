//
//  MLVPieChart.m
//  AnimatedPieChart
//
//  Created by Lance Velasco on 8/4/13.
//  Copyright (c) 2013 MLV Group. All rights reserved.
//

#import "MLVPieChart.h"
#import "MLVPieSlice.h" 

@implementation MLVPieChart


- (id) init
{
    self = [super init];
    if (slef) {
        self.title = @"Smartphone Market Share";
        self.slices = [[NSMutableArray alloc] init];
        [self.slices addObject: [[MLVPieSlice alloc] initWithPercent:20 andTitle:@"iOS" andDescription:@"iPhone by Apple" andColor:@"B070B0"]];
        [self.slices addObject: [[MLVPieSlice alloc] initWithPercent:67 andTitle:@"Android" andDescription:@"Many Manufactures" andColor:@"9070B0"]];
        [self.slices addObject: [[MLVPieSlice alloc] initWithPercent:13 andTitle:@"Others" andDescription:@"Windows, Blackberry, Other" andColor:@"A0A0D0"]];
    }
return self;
}


@end
