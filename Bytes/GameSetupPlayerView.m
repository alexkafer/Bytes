//
//  GameSetupPlayerView.m
//  Bytes
//
//  Created by Alex Kafer on 4/12/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "GameSetupPlayerView.h"
#import "UIView+InitNib.h"
#import "AKStyler.h"

@implementation GameSetupPlayerView
@synthesize playerDetail, profileImage;

-(id)initWithPlayerDetail: (NSString *)detail withUncroppedProfilePicture: (UIImage *)profile {
    self = [super initWithNibName:@"PlayerView"];
    if (self) {
        playerDetail = detail;
        profileImage = profile;
    }
    return self;
}

-(void)loadView {
    [subTextLabel setText:playerDetail];
    
    UIImage *newImage = [AKStyler circularScaleAndCropImage:profileImage frame:profilePictureView.frame];
    [profilePictureView setImage:newImage];
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
