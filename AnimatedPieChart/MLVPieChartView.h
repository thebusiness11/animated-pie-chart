//
//  MLVPieChartView.h
//  AnimatedPieChart
//
//  Created by Lance Velasco on 8/4/13.
//  Copyright (c) 2013 MLV Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLVPieChart.h" 

@interface MLVPieChartView : UIView

@property MLVPieChart *pieChart;

- (void) tick;
- (void) touchedPoint: (CGPoint) point;
- (float) getAngleFromPoint: (CGPoint) point;

+ (UIColor *)colorFromHexString:(NSString *)hexString;

@end
