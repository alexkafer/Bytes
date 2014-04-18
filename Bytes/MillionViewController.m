//
//  MillionViewController.m
//  Bytes
//
//  Created by Alex Kafer on 4/16/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "MillionViewController.h"
#import "UIView+Slidable.h"
#import "AKGravatar.h"
#import "AKStyler.h"

@implementation MillionViewController
@synthesize mediaMenu;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [addBtn.imageView.layer setCornerRadius:addBtn.frame.size.width/2];
    
    self.mediaMenu = [[AKMenu alloc] init];
    self.mediaMenu.delegate = self;
    
    //[scoreView setFont:[UIFont fontWithName:@"Lobster 1.4" size:42]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
	//the button that brings the items into view was pressed
	[self.mediaMenu buttonsWillAnimateFromButton:sender withFrame:addBtn.frame inView:self.view];
}

#pragma mark - radial menu delegate methods
- (NSInteger) numberOfItemsInRadialMenu:(AKMenu *)radialMenu {
	return 4;
}


- (NSInteger) arcSizeForRadialMenu:(AKMenu *)radialMenu {
	return 180;
}


- (NSInteger) arcRadiusForRadialMenu:(AKMenu *)radialMenu {
	return 80;
}


- (UIImage *) radialMenu:(AKMenu *)radialMenu imageForIndex:(NSInteger) index {
	UIImage *originalImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[AKGravatar getGravatarURL:@"alexkafer@gmail.com" withSize:200]]];
    UIImage *newImage = [AKStyler circularScaleAndCropImage:originalImage frame:addBtn.frame];
    return newImage;
}


- (void) radialMenu:(AKMenu *)radialMenu didSelectItemAtIndex:(NSInteger)index {
	[self.mediaMenu itemsWillDisapearIntoButton:addBtn];
    
    if (index == 1) {
        NSLog(@"email");
    } else if (index == 2) {
        NSLog(@"google+");
    } else if (index == 3) {
        NSLog(@"facebook");
    }
    
}

- (void) radialMenu:(AKMenu *)radialMenu didReleaseButton:(AKButton *)button AfterDragAtIndex:(NSInteger)index {
    NSLog(@"DO MY SHIT");
    self.mediaMenu = [[AKMenu alloc] init];
    self.mediaMenu.delegate = self;
}

-(NSInteger)arcStartForRadialMenu:(AKMenu *)radialMenu {
    return 180;
}

-(float)buttonSizeForRadialMenu:(AKMenu *)radialMenu {
    return addBtn.frame.size.width/1.25;
}

//Use your captured image
#pragma mark - DBCameraViewControllerDelegate

- (void) captureImageDidFinish:(UIImage *)image withMetadata:(NSDictionary *)metadata
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [imageView setImage:image];
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
