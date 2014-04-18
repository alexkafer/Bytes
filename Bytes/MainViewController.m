//
//  MainViewController.m
//  Bytes
//
//  Created by Alex Kafer on 2/5/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "MainViewController.h"
#import "CardView.h"
#import "UIView+Genie.h"
#import "AKStyler.h"
#import "BytesCard.h"

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 4,
                                        scrollView.frame.size.height);
    scrollView.pagingEnabled=YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    
    [scrollView setCanCancelContentTouches:YES];
    
    [AKStyler styleLayer:upperView.layer opacity:0.2 fancy:NO];
    
    [self createCards];
    
    [cardViewControllers enumerateObjectsUsingBlock:^(CardView* obj, NSUInteger idx, BOOL *stop) {
        [obj setCenter:CGPointMake(scrollView.center.x + 320*idx, scrollView.center.y/1.5+20)];
        [obj loadView];
        // add gesture recognizers to the image view
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCardActive:)];
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
    [stem loadView];
    [scrollView addSubview:stem];
}

#pragma mark - Delegate Methods

-(void)scrollViewWillBeginDragging:(UIScrollView *)currentScrollView {
    [currentScrollView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[BytesCard class]]) {
            CardView *replacedCard = [(BytesCard *)obj replacedCard];
            [UIView transitionFromView:obj toView:replacedCard duration:0.25 options:UIViewAnimationOptionTransitionFlipFromTop completion:nil];
        }
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)currentScrollView {
    CGFloat width = currentScrollView.frame.size.width;
    NSInteger page = (currentScrollView.contentOffset.x + (0.5f * width)) / width;
    [segControl setSelectedSegmentIndex:page];
    if (page == 3) {
        [segControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
    }
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
    CardView *replacedCard = [(BytesCard *)gestureRecognizer.view replacedCard];
    
    CGPoint location = [gestureRecognizer locationInView:gestureRecognizer.view];
    [UIView transitionFromView:gestureRecognizer.view toView:replacedCard duration:0.5 options:[MainViewController optionForLocation:location inView:gestureRecognizer.view] completion:nil];
}

- (void)handleCardActive:(UITapGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.view.tag > 0) {
        UIView *originalView = [gestureRecognizer view];
        BytesCard *bytesCard = [[BytesCard alloc] initFromNib];
        [bytesCard setReplacedCard:(CardView *)originalView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCardReturn:)];
        [tap setNumberOfTapsRequired:1];
        [bytesCard addGestureRecognizer:tap];
        
        [bytesCard loadView];
        [bytesCard setCenter:[originalView center]];
        
        CGPoint location = [gestureRecognizer locationInView:originalView];
        [UIView transitionFromView:originalView toView:bytesCard duration:0.5 options:[MainViewController optionForLocation:location inView:originalView] completion:nil];
    }
    
}

- (void) cardButtonPressed: (id)sender {
    CardView *card = (CardView *)[sender superview];
    NSLog(@"Identifier: %@", [card gamePlayControllerIdentifier]);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *play = [storyboard instantiateViewControllerWithIdentifier:[card gamePlayControllerIdentifier]];
    [self animateViewOut:card toViewController:play];
}

#pragma mark - Utility Methods

-(void)animateViewOut: (UIView *)view toViewController: (UIViewController *)endView {
    UIView *newView = [[UIView alloc] initWithFrame:view.frame];
    [newView setBackgroundColor:[UIColor whiteColor]];
    [newView.layer setCornerRadius:4];
    [UIView transitionFromView:view toView:newView duration:0.7 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished)
    {
        UIView *newView2 = [[UIView alloc] initWithFrame:view.frame];
        [newView2 setBackgroundColor:[UIColor whiteColor]];
        [newView2.layer setCornerRadius:8];
        [UIView transitionFromView:newView toView:newView2 duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished)
        {
            UIView *newView3 = [[UIView alloc] initWithFrame:view.frame];
            [newView3 setBackgroundColor:[UIColor whiteColor]];
            [newView3.layer setCornerRadius:12];
            [UIView transitionFromView:newView2 toView:newView3 duration:0.3 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished)
            {
                UIView *newView4 = [[UIView alloc] initWithFrame:view.frame];
                [newView4 setBackgroundColor:[UIColor whiteColor]];
                [newView4.layer setCornerRadius:16];
                [UIView transitionFromView:newView3 toView:newView4 duration:0.2 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished)
                {
                    UIView *newView5 = [[UIView alloc] initWithFrame:view.frame];
                    [newView5 setBackgroundColor:[UIColor whiteColor]];
                    [newView5.layer setCornerRadius:24];
                    [UIView transitionFromView:newView4 toView:newView5 duration:0.2 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished)
                    {
                        CGRect destRect = CGRectMake( self.view.frame.size.width/4, self.view.frame.size.height+5, self.view.frame.size.width/2, 20);
                        
                        
                        [newView5 genieInTransitionWithDuration:0.1
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
                    }];
                }];
            }];
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
