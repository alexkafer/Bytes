//
//  GameSetupPlayerView.h
//  Bytes
//
//  Created by Alex Kafer on 4/12/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameSetupPlayerView : UIView {
    IBOutlet UIImageView *profilePictureView;
    IBOutlet UILabel *subTextLabel;
}

@property (nonatomic, retain) UIImage *profileImage;
@property (nonatomic, retain) NSString *playerDetail;


-(id)initWithPlayerDetail: (NSString *)detail withUncroppedProfilePicture: (UIImage *)profile;
- (void)loadView;
@end
