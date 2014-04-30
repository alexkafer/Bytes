//
//  CardTapCestureRecognizer.h
//  Bytes
//
//  Created by Alex Kafer on 4/20/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface CardTapGestureRecognizer : UITapGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@protocol CardTapGestureRecognizerDelegate <UIGestureRecognizerDelegate>
- (void) gestureRecognizer:(UIGestureRecognizer *)gr touched:(NSSet*)touches andEvent:(UIEvent *)event;
@end
