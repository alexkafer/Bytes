//
//  GameSetupPlayerView.h
//  Bytes
//
//  Created by Alex Kafer on 4/12/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ObjectView : UIView

@property (nonatomic, retain) IBOutlet UIImageView *profilePictureView;
@property (nonatomic, retain) IBOutlet UILabel *subTextLabel;
@property (nonatomic) NSInteger *bytesLeftForObj;


-(id)initWithPlayerDetail: (NSString *)detail withUncroppedProfilePicture: (UIImage *)profile;
- (void)loadView;
@end
