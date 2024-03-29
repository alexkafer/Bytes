//
//  UIImageView+movable.m
//  Bytes
//
//  Created by Alex Kafer on 4/9/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "UIImageView+movable.h"
#import <objc/runtime.h>

@implementation UIImageView (movable)

- (void)setPanGesture:(UIPanGestureRecognizer*)panGesture
{
	objc_setAssociatedObject(self, @selector(panGesture), panGesture, OBJC_ASSOCIATION_RETAIN);
}

- (UIPanGestureRecognizer*)panGesture
{
	return objc_getAssociatedObject(self, @selector(panGesture));
}

- (void)handlePan:(UIPanGestureRecognizer*)sender
{
	[self adjustAnchorPointForGestureRecognizer:sender];
	
	CGPoint translation = [sender translationInView:[self superview]];
	[self setCenter:CGPointMake([self center].x + translation.x, [self center].y + translation.y)];
    
	[sender setTranslation:(CGPoint){0, 0} inView:[self superview]];
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.layer.shadowOpacity = 0.5f;
        NSLog(@"Test");
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        self.layer.shadowOpacity = 0.0f;
        NSLog(@"End Test");
    }
}

- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIImageView *piece = self;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}

- (void)setDraggable:(BOOL)draggable
{
	[self.panGesture setEnabled:draggable];
}

- (void)enableDragging
{
    [self setUserInteractionEnabled:YES];
	self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
	[self.panGesture setMaximumNumberOfTouches:1];
	[self.panGesture setMinimumNumberOfTouches:1];
	[self.panGesture setCancelsTouchesInView:NO];
	[self addGestureRecognizer:self.panGesture];
}

@end
