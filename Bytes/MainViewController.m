//
//  MainViewController.m
//  Bytes
//
//  Created by Alex Kafer on 2/5/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "MainViewController.h"
#import "CardView.h"
#import "BytesOverlay.h"
#import "UIView+Genie.h"
#import "AKStyler.h"
#import "BytesCard.h"

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [scrollView setCanCancelContentTouches:YES];
    
    upperView.layer.shadowOpacity = 0.5;
    upperView.layer.shadowPath = CGPathCreateWithRect(upperView.frame, nil);
    
    
    [self createCards];
    
    [cardViewControllers enumerateObjectsUsingBlock:^(CardView* obj, NSUInteger idx, BOOL *stop) {
        [obj setCenter:CGPointMake(scrollView.center.x + 320*idx, scrollView.center.y/1.5+20)];
        [obj loadView];
        // add gesture recognizers to the image view
        CardTapGestureRecognizer *tap = [[CardTapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCardActive:)];
        [tap setNumberOfTapsRequired:2];
        [obj addGestureRecognizer:tap];
        [obj.button addTarget:self action:@selector(cardButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [obj setTag:idx+1];
        //[obj.view enableDragging];
        //[obj.view setScrollViewPriority:scrollView];
        [scrollView addSubview:obj];
    }];
    
    CardView *stem = [[CardView alloc] initWithTitle:@"STEM" discription:@"Student App"];
    [stem setCenter:CGPointMake(scrollView.center.x + 320*cardViewControllers.count, scrollView.center.y/1.5+20)];
    [[stem button] setHidden:YES];
    [[stem doubleTapLabel] setHidden:YES];
    [stem loadView];
    [scrollView addSubview:stem];
    
    bytesScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    overlayCenter = [bytesScroller center];
    [scrollView addSubview:bytesScroller];
    
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 4,
                                        scrollView.frame.size.height);
    scrollView.pagingEnabled=YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    
    BytesOverlay *tabOverylay = [[BytesOverlay alloc] initFromNib];
    [tabOverylay setCenter:CGPointMake([tabOverylay center].x, [tabOverylay center].y-230)];
    [tabOverylay loadView];
    [bytesScroller addSubview:tabOverylay];
    
    bytesScroller.contentSize = CGSizeMake(tabOverylay.frame.size.width,
                                        tabOverylay.frame.size.height*1.41);
    
    bytesScroller.showsHorizontalScrollIndicator = NO;
    bytesScroller.showsVerticalScrollIndicator = NO;
    bytesScroller.delegate = self;
    bytesScroller.pagingEnabled = YES;
    [bytesScroller setCanCancelContentTouches:YES];
    
    [bytesScroller setContentOffset:CGPointMake(0, 279)];
}

#pragma mark - Delegate Methods

-(void)scrollViewWillBeginDragging:(UIScrollView *)currentScrollView {
    if ([currentScrollView isEqual:scrollView])
    {
        
        [currentScrollView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[BytesCard class]]) {
                CardView *replacedCard = [(BytesCard *)obj replacedCard];
                [UIView transitionFromView:obj toView:replacedCard duration:0.25 options:UIViewAnimationOptionTransitionFlipFromTop completion:nil];
            }
        }];
        
    }
    else
    {
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)currentScrollView {
    if ([currentScrollView isEqual:scrollView])
    {

        if (extended) {
            [scrollView setContentOffset:(currentExtendedPoint)];
        } else {
            CGFloat width = currentScrollView.frame.size.width;
            NSInteger page = (currentScrollView.contentOffset.x + (0.5f * width)) / width;
            [segControl setSelectedSegmentIndex:page];
            if (page == 3) {
                [segControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
                [UIView animateWithDuration:0.5 animations:^{
                    [scrollView setBackgroundColor:[UIColor colorWithRed:0.122 green:0.569 blue:0.451 alpha:1.000]];
                }];
            } else {
                [UIView animateWithDuration:0.5 animations:^{
                    [scrollView setBackgroundColor:[UIColor clearColor]];
                }];
            }
            [bytesScroller setCenter:CGPointMake(overlayCenter.x + currentScrollView.contentOffset.x, overlayCenter.y)];
        }
        
    }
    else
    {
        
        if (currentScrollView.contentOffset.y < 255) {
            [scrollView bringSubviewToFront:bytesScroller];
            [segControl setUserInteractionEnabled:NO];
            extended = YES;
            currentExtendedPoint = scrollView.contentOffset;
        } else {
            [scrollView sendSubviewToBack:bytesScroller];
            [segControl setUserInteractionEnabled:YES];
            extended = NO;
        }
        
    }
}

#pragma mark TapGesture

- (void) gestureRecognizer:(UIGestureRecognizer *)gr touched:(NSSet*)touches andEvent:(UIEvent *)event {
    lastCardTouch = [touches anyObject];
    NSLog(@"Tapped");
}

#pragma mark - Custom Methods

- (void)createCards {
    cardViewControllers = [[NSMutableArray alloc] init];
    
    CardView *countDown = [[CardView alloc] initWithTitle:@"Countdown" discription:@"Gather as many bytes as you can in 30 seconds!"];
    [countDown setGamePlayControllerIdentifier:@"countDownPlay"];
    [cardViewControllers addObject:countDown];
    
    CardView *pinpoint = [[CardView alloc] initWithTitle:@"Pinpoint" discription:@"Use a code to race against friends!"];
    [pinpoint setGamePlayControllerIdentifier:@"pinPointPlay"];
    [cardViewControllers addObject:pinpoint];
    
    CardView *million = [[CardView alloc] initWithTitle:@"Race to a Million" discription:@"Speed your way to a million bytes!"];
    [million setGamePlayControllerIdentifier:@"millionPlay"];
    [cardViewControllers addObject:million];
}

#pragma mark - Selectors and IBActions

-(IBAction)scrollWith:(id)sender {
    [scrollView setContentOffset:CGPointMake(320*segControl.selectedSegmentIndex, scrollView.contentOffset.y) animated:YES];
}

- (void)handleCardReturn: (UITapGestureRecognizer *)gestureRecognizer {
    [UIView animateWithDuration:1 animations:^{
        [bytesScroller setCenter:CGPointMake([bytesScroller center].x, [bytesScroller center].y-200)];
    } completion:^(BOOL finished) {
        UIView *replacedCard = [(BytesCard *)gestureRecognizer.view replacedCard];
        CGPoint location = [gestureRecognizer locationInView:gestureRecognizer.view];
        [UIView transitionFromView:gestureRecognizer.view toView:replacedCard duration:0.5 options:[MainViewController optionForLocation:location inView:gestureRecognizer.view] completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                [bytesScroller setCenter:CGPointMake([bytesScroller center].x, [bytesScroller center].y+200)];
            }];
        }];
    }];
}

- (void)handleCardActive:(UITapGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.view.tag > 0) {
        [UIView animateWithDuration:0.2 animations:^{
            [bytesScroller setCenter:CGPointMake([bytesScroller center].x, [bytesScroller center].y-200)];
        } completion:^(BOOL finished) {
            UIView *originalView = [gestureRecognizer view];
            BytesCard *bytesCard = [[BytesCard alloc] initFromNib];
            [bytesCard setReplacedCard:(CardView *)originalView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCardReturn:)];
            [tap setNumberOfTapsRequired:1];
            [bytesCard addGestureRecognizer:tap];
            
            [bytesCard loadView];
            [bytesCard setCenter:[originalView center]];
            CGPoint location = [lastCardTouch locationInView:[gestureRecognizer view]];
            NSLog(@"Location Active: %f, %f", location.x, location.y);
            [UIView transitionFromView:originalView toView:bytesCard duration:0.5 options:[MainViewController optionForLocation:location inView:originalView] completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    [bytesScroller setCenter:CGPointMake([bytesScroller center].x, [bytesScroller center].y+200)];
                }];
            }];
        }];
        
    }
    
}

- (void) cardButtonPressed: (id)sender {
    CardView *card = (CardView *)[sender superview];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    NSString *identifier = [card gamePlayControllerIdentifier];
    if ([identifier isEqualToString:@"pinPointPlay"]) {
        NSLog(@"Bring forth the code dialog");
    } else {
        UIViewController *play = [storyboard instantiateViewControllerWithIdentifier:identifier];
        [self animateViewOut:card toViewController:play];
        
        UIView *newView = [[UIView alloc] initWithFrame:card.frame];
        [newView setBackgroundColor:[UIColor whiteColor]];
        [newView.layer setCornerRadius:4];
        
        [UIView transitionFromView:card toView:newView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom completion:^(BOOL finished) {
            
        }];
    }
    
}

#pragma mark - Utility Methods

-(void)animateViewOut: (UIView *)view toViewController: (UIViewController *)endView {
    CGRect destRect = CGRectMake( self.view.frame.size.width/4, self.view.frame.size.height+5, self.view.frame.size.width/2, 20);
    
    [view genieInTransitionWithDuration:0.1
                            destinationRect:destRect
                            destinationEdge:BCRectEdgeTop completion:^{
                                NSLog(@"Done!");
                                [scrollView setHidden:YES];
                                [UIView animateWithDuration:0.2 animations:^{
                                    [segControl setAlpha:0];
                                } completion:^(BOOL finished) {
                                    [self presentViewController:endView animated:NO completion:nil];
                                }];
                            }];
}

+(UIViewAnimationOptions) optionForLocation: (CGPoint)location inView: (UIView *)view {
    CGFloat y = location.y-view.frame.size.height/2;
    CGFloat x = location.x-view.frame.size.width/2;
    
    if (y > 0 && fabsf(x) < fabsf(y)) {
        return UIViewAnimationOptionTransitionFlipFromBottom;
    } else if (y < 0 && fabsf(x) < fabsf(y)) {
        return UIViewAnimationOptionTransitionFlipFromTop;
    } else if (x > 0) {
        return UIViewAnimationOptionTransitionFlipFromLeft;
    } else {
        return UIViewAnimationOptionTransitionFlipFromRight;
    }
    
}
@end
