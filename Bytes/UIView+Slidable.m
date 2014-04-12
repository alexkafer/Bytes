//
//  UIView+Slidable.m
//  Bytes
//
//  Created by Alex Kafer on 4/12/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "UIView+Slidable.h"
#import <objc/runtime.h>

static char const * const PanGestureKey = "PanGestureSlide";
static char const * const DirectionSlideKey = "DirectionSlide";

@implementation UIView (slidable)

- (void)setPanGesture:(UIPanGestureRecognizer*)panGesture
{
	objc_setAssociatedObject(self, PanGestureKey, panGesture, OBJC_ASSOCIATION_RETAIN);
}

- (UIPanGestureRecognizer*)panGesture
{
	return objc_getAssociatedObject(self, PanGestureKey);
}

- (NSString *)direction {
    return objc_getAssociatedObject(self, DirectionSlideKey);
}

- (void)setDirection:(NSString *)newDirection {
    objc_setAssociatedObject(self, DirectionSlideKey, newDirection, OBJC_ASSOCIATION_RETAIN);
}

- (void)handleSlidePan:(UIPanGestureRecognizer*)sender
{
	[self adjustAnchorPointForGestureRecognizer:sender];
	
	CGPoint translation = [sender translationInView:[self superview]];
    if ([[self direction] isEqualToString:@"vertical"]) {
        CGFloat newY = [self center].y + translation.y;
        NSLog(@"New Y: %f center: %f", newY, [self center].y);
        if ([self center].y > 500) {
            newY = 500;
        } else if([self center].y < 200) {
            newY = 200;
        }
        [self setCenter:CGPointMake([self center].x, newY)];
    } else if ([[self direction] isEqualToString:@"horizontal"]) {
        [self setCenter:CGPointMake([self center].x + translation.x, [self center].y)];
    } else {
        [self setCenter:CGPointMake([self center].x + translation.x, [self center].y + translation.y)];
    }
    
	[sender setTranslation:(CGPoint){0, 0} inView:[self superview]];
    
    if (sender.state == UIGestureRecognizerStateBegan && self.layer.shadowRadius > 0) {
        self.layer.shadowOpacity = 0.5f;
    } else if (sender.state == UIGestureRecognizerStateEnded && self.layer.shadowRadius > 0) {
        self.layer.shadowOpacity = 0.1f;
    }
}

- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = self;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}

- (void)setSlidable:(BOOL)slidable direction:(NSString *)dir
{
	[self.panGesture setEnabled:slidable];
    [self setDirection:dir];
}

- (void)enableSliding
{
	self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSlidePan:)];
	[self.panGesture setMaximumNumberOfTouches:1];
	[self.panGesture setMinimumNumberOfTouches:1];
	[self.panGesture setCancelsTouchesInView:NO];
	[self addGestureRecognizer:self.panGesture];
}

@end
