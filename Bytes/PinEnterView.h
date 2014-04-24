//
//  PinEnterView.h
//  Bytes
//
//  Created by Alex Kafer on 4/24/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PinEnterView : UIView

@property (nonatomic, retain) IBOutlet UIButton *submitCode;
@property (nonatomic, retain) IBOutlet UIButton *cancelCode;
@property (nonatomic, retain) IBOutlet UITextField *codeFielder;

- (id)initFromNib;
- (void)loadView;


@end
