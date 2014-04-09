//
//  CardViewController.h
//  LifeWorksTurck
//
//  Created by Alex Kafer on 3/23/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, retain) IBOutlet UIButton *button;

-(id)initWithTitle: (NSString *)string discription: (NSString *)description;

@end
