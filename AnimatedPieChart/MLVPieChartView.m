//
//  MLVPieChartView.m
//  AnimatedPieChart
//
//  Created by Lance Velasco on 8/4/13.
//  Copyright (c) 2013 MLV Group. All rights reserved.
//

#import "MLVPieChartView.h"
#import "MLVPieSlice.h" 



@implementation MLVPieChartView

{
    float xPos, yPos, radius;
    float rotationAngle;
}

@synthesize pieChart;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        pieChart = [[MLVPieChart alloc] init];
        xPos = 320/2;
        yPos = 330;
        radius = 120;
        rotationAngle = 4;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawPieChart: context];
}


- (void) drawPieChart:(CGContextRef) context
{
    //clear the screen
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 320, 480));
    
    //draw all slices
    float a = rotationAngle;
    for (MLVPieSlice *slice in pieChart.slices) {
        [self drawPieSlice:slice withStartingAngle:a withContext:context];
        a += (slice.pct/100) * (M_PI * 2);
    }
}


- (void) drawPieSlice:(MLVPieSlice *) slice withStartingAngle:(float)startAngle withContext:(CGContextRef) context
{
    float endAngle = startAngle + (slice.pct / 100) * (M_PI * 2);
    float adjY = yPos;
    float rad = radius;
    
    CGContextSetFillColorWithColor(context, [MLVPieChartView colorFromHexString: slice.color].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, xPos, adjY);
    CGContextAddArc(context, xPos, adjY, rad, startAngle, endAngle, 0);
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:((rgbValue & 0xFF)/255.0) alpha:1.0];
}


@end
