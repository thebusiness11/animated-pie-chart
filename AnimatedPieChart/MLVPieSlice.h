//
//  MLVPieSlice.h
//  AnimatedPieChart
//
//  Created by Lance Velasco on 8/4/13.
//  Copyright (c) 2013 MLV Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLVPieSlice : NSObject

@property float pct;
@property NSString *title;
@property NSString *description;
@property NSString *color;

- (id) initWithPercent:(float) pct andTitle:(NSString *)title andDescription:(NSString *)description andColor:(NSString *)color;

@end
