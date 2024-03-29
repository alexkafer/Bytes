//
//  AKMenu.h
//  AKMenu
//
//  Created by Alex Kafer on 2/5/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKButton.h"

@class AKMenu;

///protocol delegate for the data source
@protocol AKMenuDelegate <NSObject>

/**
 * when called with this message delegate's should return the number of items that will be displayed
 * @return number of items to display
 * @param radialMenu the radial menu object making the request
 */
- (NSInteger) numberOfItemsInRadialMenu:(AKMenu *)radialMenu;

/** 
 * when called with this message delegate's should return the size of the arc (how far the objects are spread) the items will be draw in
 * @return size of the arc
 * @param radialMenu the radial menu object making the request
 */
 - (NSInteger) arcSizeForRadialMenu:(AKMenu *)radialMenu;

/** 
 * when called with this message delegate's should return the arc radius (distance between the button and objects final resting spot)
 * @return radius for the arc
 * @param radialMenu the radial menu object making the request
 */
- (NSInteger) arcRadiusForRadialMenu:(AKMenu *)radialMenu;


/** 
 * delegate's should return the image to be displayed at the the given index
 * @return image to be displayed
 * @param radialMenu the radial menu object making the request
 * @param index the item to be displayed
 */
- (UIImage *) radialMenu:(AKMenu *)radialMenu imageForIndex:(NSInteger) index;

/**
 * this method will notify the delegates any time a button from the radial menu is pressed
 * @param radialMenu the radial menu object that the button appeared from
 * @param index the index of the button that was touched
 */
- (void) radialMenu:(AKMenu *)radialMenu didSelectItemAtIndex:(NSInteger) index;

- (void) radialMenu:(AKMenu *)radialMenu didReleaseButton: (AKButton *)button AfterDragAtIndex:(NSInteger) index;

@optional

/**
 * when called with this message delegate's should return the start of the arc.
 * @return start of the arc
 * @param radialMenu the radial menu object making the request
 */
- (NSInteger) arcStartForRadialMenu:(AKMenu *)radialMenu;


/**
 * when called with this message delegate's should return the size of the button.
 * @return size of the button
 * @param radialMenu the radial menu object making the request
 */
- (float) buttonSizeForRadialMenu:(AKMenu *)radialMenu;

@end


//FIXME: write this doc
/**
 * ALRadial is meant to replicate the radial menu's found in the path ios app. a central button is used to display many others eminating out in a circle.
 *
 * to use it in your project just add the ALRadialMenu and ALRadialButton files to your project, include ALRadialMenu.h, and implement the 5 ALRadialMenuDelegate methods.
 */
@interface AKMenu : UIView <AKButtonDelegate>

///@name Tasks
/** 
 * method that flings the item's into view
 * @param button the UIButton the items should appear from
 * @param view the view the buttons will be added to
 * @param frame the frame to for the calculations
 */
- (void)itemsWillAppearFromButton:(UIButton *) button withFrame:(CGRect)frame inView:(UIView *)view;

/** 
 * method that removes the item's from view
 * @param button the UIButton the items should recoil into
 */
- (void)itemsWillDisapearIntoButton:(UIButton *) button;

/**
 * helper method to display or hide the buttons
 * @param sender the button that was pressed to initial the action, the child buttons appear behind this object and animate out
 * @param view the UIView the buttons will appear in
 * @param frame the frame to for the calculations
 */
- (void)buttonsWillAnimateFromButton:(id)sender withFrame:(CGRect)frame inView:(UIView *)view;


///@name Properites

///data source delegate
@property (nonatomic, weak) id <AKMenuDelegate> delegate;

///property to store the next item to be animated into/out of view
@property (nonatomic) NSInteger itemIndex;

///timer to stagger the animations for displaying and removing items
@property (nonatomic, strong) NSTimer *animationTimer;

///array storing the buttons to be displayed
@property (nonatomic, strong) NSMutableArray *items;
@end



@interface AKMenu (Private)
/**
 * rotate a button in place for a given duration
 * @param button the button that will be rotated
 * @param duration how long the button will rotate for
 * @param direction whether to rotate forward or backward
 */
- (void)shouldRotateButton:(UIButton *)button forDuration:(float)duration forwardDirection:(BOOL)direction;

///this method is called from the nstimer to fling the next item into view
- (void)willFlingItem;

///this method is called from the nstimer to recoil the next item from view
- (void)willRecoilItem;

/**
 * this method is called by the button when its pressed
 * @param sender the button that was pressed
 */
- (void)buttonPressed:(id)sender;
@end

