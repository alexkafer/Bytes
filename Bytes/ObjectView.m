//
//  GameSetupPlayerView.m
//  Bytes
//
//  Created by Alex Kafer on 4/12/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "ObjectView.h"
#import "UIView+InitNib.h"
#import "AKStyler.h"

@implementation ObjectView
@synthesize subTextLabel, profilePictureView, bytesLeftForObj;

-(id)initWithPlayerDetail: (NSString *)detail withUncroppedProfilePicture: (UIImage *)profile {
    self = [super initWithNibName:@"ObjectView"];
    if (self) {
        subTextLabel.text = detail;
        profilePictureView.image = [AKStyler circularScaleAndCropImage:profile frame:profilePictureView.frame];;
    }
    return self;
}

-(void)loadView {
    CALayer *layer = profilePictureView.layer;
    
    [layer setCornerRadius:self.frame.size.width/2];
    [layer setBorderColor:[UIColor whiteColor].CGColor];
    [layer setBorderWidth:5];
    
    [layer setShadowOffset:CGSizeMake(1, -1) ];
    [layer setShadowColor: [[UIColor blackColor] CGColor]];
    [layer setShadowRadius: 4.0f];
    [layer setShadowPath:[[UIBezierPath bezierPathWithRoundedRect:layer.bounds cornerRadius:self.frame.size.width/2] CGPath]];
}

@end
