//
//  CardViewController.m
//  LifeWorksTurck
//
//  Created by Alex Kafer on 3/23/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "CardViewController.h"
#import "AKStyler.h"
#import <QuartzCore/QuartzCore.h>

@interface CardViewController ()
{
    NSString *title;
    NSString *description;
}

@end

@implementation CardViewController
@synthesize titleLabel, descriptionLabel, button;

-(id)initWithTitle: (NSString *)stringTitle discription: (NSString *)stringDescription {
    if (self = [super initWithNibName:@"CardView" bundle:nil])
    {
        title = stringTitle;
        description = stringDescription;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.text = title;
    self.descriptionLabel.text = description;
    
    CALayer *layer = self.view.layer;
    
    layer.cornerRadius = 4.0f;
    layer.shadowOffset =  CGSizeMake(1, 1);
    layer.shadowColor = [[UIColor blackColor] CGColor];
    layer.shadowRadius = 4.0f;
    layer.shadowOpacity = 0.30f;
    //layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
    layer.shadowPath = [AKStyler fancyShadowForRect:layer.bounds distance:15.0f];
    // Do any additional setup after loading the view from its nib.
    
    CALayer *buttonLayer = button.layer;
    
    buttonLayer.cornerRadius = 4.0f;
    buttonLayer.shadowOffset =  CGSizeMake(1, 1);
    buttonLayer.shadowColor = [[UIColor blackColor] CGColor];
    buttonLayer.shadowRadius = 4.0f;
    buttonLayer.shadowOpacity = 0.50f;
    //buttonLayer.shadowPath = [[UIBezierPath bezierPathWithRect:buttonLayer.bounds] CGPath];
    buttonLayer.shadowPath = [AKStyler fancyShadowForRect:buttonLayer.bounds distance:5.0f];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
