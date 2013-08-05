//
//  MLVPieChartView.m
//  AnimatedPieChart
//
//  Created by Lance Velasco on 8/4/13.
//  Copyright (c) 2013 MLV Group. All rights reserved.
//

#import "MLVPieChartView.h"
#import "MLVPieSlice.h" 

typedef enum
{
    STATE_IDLE,
    STATE_ROTATING,
    STATE_SEPARATING,
    STATE_SEPARATED,
    STATE_JOINING
}   state;


@implementation MLVPieChartView

{
    float xPos, yPos, radius;
    float rotationAngle;
    state animationState;
    BOOL isAnimating;
    
    float startAngle;   //starting angle for rotation
    float destAngle;    //ending angle for rotation
    
    MLVPieSlice *selectedSlice;
    MLVPieSlice *nextSelectedSlice;
    float selectionYPos;
    
    int totalAnimFrames;
    int currentFrame;
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
        rotationAngle = 0;
        startAngle = destAngle = 0;
        nextSelectedSlice = nil;
        
        [self setState: STATE_IDLE];
    }
    return self;
}

- (void) setState:(state) newState
{
    animationState = newState;
    switch (newState) {
        case STATE_IDLE:
            isAnimating = NO;
            break;
        case STATE_ROTATING:
            isAnimating = YES;
            totalAnimFrames = 20;
            currentFrame = 1;
            break;
        case STATE_SEPARATING:
            isAnimating = YES;
            break;
        case STATE_SEPARATED:
            isAnimating = NO;
            break;
        case STATE_JOINING:
            isAnimating = YES;
            break;
    }
}

- (void) tick
{
    switch (animationState)
    {
        case STATE_ROTATING:
            if (currentFrame > totalAnimFrames)
            {
                startAngle = rotationAngle = destAngle;
                [self setState: STATE_IDLE];
            }
            else
            {
                //t:current time b: beginning value c: change in value d: duration
                rotationAngle = easeInOutBack(currentFrame++, startAngle, (destAngle - startAngle), totalAnimFrames);
            }
            break;
        case STATE_SEPARATING:
            
            break;
        case STATE_JOINING:
            
            break;
        default:
            break;
    }
}

- (void) drawRect:(CGRect)rect
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


- (void) drawPieSlice:(MLVPieSlice *) slice withStartingAngle:(float)startingAngle withContext:(CGContextRef) context
{
    float endAngle = startingAngle + (slice.pct / 100) * (M_PI*2);

    float adjY = yPos;
    float rad = radius;
    
    CGContextSetFillColorWithColor(context, [MLVPieChartView colorFromHexString: slice.color].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, xPos, adjY);
    CGContextAddArc(context, xPos, adjY, rad, startingAngle, endAngle, 0);
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void) touchedPoint:(CGPoint)point
{
    if (isAnimating) return;
    
    float a = [self getAngleFromPoint: point];
    if (a < 0)
        a += 2*M_PI;
    
    //determine which slice was touched
    float first = startAngle;
    float last;
    MLVPieSlice *slice;
    for (slice in pieChart.slices) {
        last = first + (slice.pct/100) * (M_PI *2);
        if (last > M_PI*2) {
            if (a > first || a < last-(M_PI*2))
                break;
        }
        else if (a >= first && a <= last)
            break;
        first = last;
        if (first > M_PI*2)
            first -= M_PI*2;
    }

         
         //center this slice upwards
         float targetAngle = 1.5*M_PI - (last-first)/2.0;

    
         destAngle += (targetAngle - first);
         if (destAngle < 0) destAngle += M_PI*2;
         nextSelectedSlice = slice;
         selectionYPos = yPos;
         
         selectedSlice = nextSelectedSlice;
         [self setState: STATE_ROTATING];
}
         
- (float) getAngleFromPoint: (CGPoint) point
{
    float adjY = yPos;
     
    float deltaY = point.y - adjY;
    float deltaX = point.x - xPos;
    
    return atan2(deltaY, deltaX);
}


float easeInOutBack(float t, float b, float c, float d) {
    // t: current time, b: begInnIng value, c: change In value, d: duration
    float s = 1.70158;
    if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
    return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
}

float easeOutBounce(float t, float b, float c, float d) {
    if ((t/=d) < (1/2.75)) {
        return c*(7.5625*t*t) + b;
    } else if (t < (2/2.75)) {
        return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
    } else if (t < (2.5/2.75)) {
        return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
    } else {
        return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
    }
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:((rgbValue & 0xFF)/255.0) alpha:1.0];
}


@end
