//
//  MLVViewController.m
//  AnimatedPieChart
//
//  Created by Lance Velasco on 8/4/13.
//  Copyright (c) 2013 MLV Group. All rights reserved.
//

#import "MLVViewController.h"
#import "MLVPieChartView.h"
#import "MLVPieSlice.h"

@interface MLVViewController ()
{
    MLVPieChartView *pieChartView;
    NSTimer *timer;
}
@end

@implementation MLVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    pieChartView = [[MLVPieChartView alloc] initWithFrame: self.view.frame];
                    [self.view addSubview:pieChartView];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1/30.0 target:self selector:@selector(nextFrame) userInfo:NULL repeats:YES];
             
}

- (void) nextFrame
{
//    [pieChartView tick];
    [pieChartView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
