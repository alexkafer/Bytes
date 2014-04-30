//
//  UIView+Slidable.h
//  Bytes
//
//  Created by Alex Kafer on 4/12/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

@interface UIView (slidable)

/**-----------------------------------------------------------------------------
 * @name UIView+slidable Properties
 * -----------------------------------------------------------------------------
 */

/** The pan gestures that handles the view sliding
 *
 * @param panGesture The tint color of the blurred view. Set to nil to reset.
 */
@property (nonatomic) UIPanGestureRecognizer *panGesture;
@property (nonatomic) NSString *direction;

/**-----------------------------------------------------------------------------
 * @name UIView+draggable Methods
 * -----------------------------------------------------------------------------
 */

/** Enables the sliding
 *
 * Enables the sliding state of the view
 */
- (void)enableSliding;

/** Disable or enable the view sliding
 *
 * @param sliding The boolean that enables or disables the sliding state
 * @param dir The direction that sets the direction the view can slide
 */
- (void)setSlidable:(BOOL)slidable direction:(NSString *)dir;

@end

