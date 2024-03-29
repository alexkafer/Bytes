//
//  CardViewController.h
//  LifeWorksTurck
//
//  Created by Alex Kafer on 3/23/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIView

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, retain) IBOutlet UIButton *startButton;

@property (nonatomic, retain) NSString *gamePlayControllerIdentifier;

- (id)initWithTitle: (NSString *)string discription: (NSString *)description;
- (void)loadView;

@end
