//
//  BytesOverlay.h
//  Bytes
//
//  Created by Alex Kafer on 4/19/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BytesOverlay : UIView {
    IBOutlet UIView *tabView;
    IBOutlet UIView *bodyContent;
}

-(id)initFromNib;
-(void)loadView;

@end
