//
//  GamePlayViewController.m
//  Bytes
//
//  Created by Alex Kafer on 4/12/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "GamePlayViewController.h"
#import "UIView+Slidable.h"
#import "AKGravatar.h"
#import "AKStyler.h"
#import <Parse/Parse.h>

@interface GamePlayViewController ()

@end

@implementation GamePlayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [addBtn.imageView.layer setCornerRadius:addBtn.frame.size.width/2];
    
    self.mediaMenu = [[ALRadialMenu alloc] init];
    self.mediaMenu.delegate = self;
    
    [mediaView enableSliding];
    [mediaView setSlidable:YES direction:@"vertical"];
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
- (NSInteger) numberOfItemsInRadialMenu:(ALRadialMenu *)radialMenu {
	return 4;
}


- (NSInteger) arcSizeForRadialMenu:(ALRadialMenu *)radialMenu {
	return 180;
}


- (NSInteger) arcRadiusForRadialMenu:(ALRadialMenu *)radialMenu {
	return 80;
}


- (UIImage *) radialMenu:(ALRadialMenu *)radialMenu imageForIndex:(NSInteger) index {
	UIImage *originalImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[AKGravatar getGravatarURL:[[PFUser currentUser] email] withSize:500]]];
    UIImage *newImage = [AKStyler circularScaleAndCropImage:originalImage frame:addBtn.frame];
    return newImage;
}


- (void) radialMenu:(ALRadialMenu *)radialMenu didSelectItemAtIndex:(NSInteger)index {
	[self.mediaMenu itemsWillDisapearIntoButton:addBtn];
    
		if (index == 1) {
			NSLog(@"email");
		} else if (index == 2) {
			NSLog(@"google+");
		} else if (index == 3) {
			NSLog(@"facebook");
		}
    
}

- (void) radialMenu:(ALRadialMenu *)radialMenu didReleaseButton:(ALRadialButton *)button AfterDragAtIndex:(NSInteger)index {
    NSLog(@"DO MY SHIT");
    self.mediaMenu = [[ALRadialMenu alloc] init];
    self.mediaMenu.delegate = self;
}

-(NSInteger)arcStartForRadialMenu:(ALRadialMenu *)radialMenu {
    return 180;
}

-(float)buttonSizeForRadialMenu:(ALRadialMenu *)radialMenu {
    return addBtn.frame.size.width/1.25;
}

@end
