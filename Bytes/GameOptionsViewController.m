//
//  GameOptionsViewController.m
//  Bytes
//
//  Created by Alex Kafer on 4/8/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "GameOptionsViewController.h"

@interface GameOptionsViewController ()

@end

@implementation GameOptionsViewController

-(id)initWithGameOptions: (NSString *)stringTitle discription: (NSString *)stringDescription {
    if (self = [super initWithNibName:@"GameOptionsView" bundle:nil])
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
