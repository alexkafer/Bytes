//
//  MainViewController.m
//  Bytes
//
//  Created by Alex Kafer on 2/5/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "MainViewController.h"
#import "CardViewController.h"
#import "GameSetupViewController.h"
#import "UIView+Genie.h"
#import "AKStyler.h"

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self styleLayer:whatAreBytesBtn.layer];
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 4,
                                        scrollView.frame.size.height);
    scrollView.pagingEnabled=YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    
    [scrollView setCanCancelContentTouches:YES];
    
    [self createCards];
    
    [cardViewControllers enumerateObjectsUsingBlock:^(CardViewController* obj, NSUInteger idx, BOOL *stop) {
        [obj.view setCenter:CGPointMake(scrollView.center.x + 320*idx, scrollView.center.y/1.5+20)];
        // add gesture recognizers to the image view
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCardActive:)];
        [tap setNumberOfTapsRequired:2];
        [obj.view addGestureRecognizer:tap];
        [obj.view setTag:idx+1];
        //[obj.view enableDragging];
        //[obj.view setScrollViewPriority:scrollView];
        [scrollView addSubview:obj.view];
    }];
    
    CardViewController *stem = [[CardViewController alloc] initWithTitle:@"STEM" discription:@"Student App"];
    [stem.view setCenter:CGPointMake(scrollView.center.x + 320*cardViewControllers.count, scrollView.center.y/1.5+20)];
    [scrollView addSubview:stem.view];
}

- (void)scrollViewDidScroll:(UIScrollView *)currentScrollView {
    CGFloat width = currentScrollView.frame.size.width;
    NSInteger page = (currentScrollView.contentOffset.x + (0.5f * width)) / width;
    [segControl setSelectedSegmentIndex:page];
    if (page == 4) {
        [UIView animateWithDuration:0.5 animations:^{
            [whatAreBytesBtn setAlpha:0];
        } completion:^(BOOL finished) {
            [whatAreBytesBtn setHidden:YES];
        }];
    } else {
        [whatAreBytesBtn setHidden:NO];
        [UIView animateWithDuration:0.5 animations:^{
            [whatAreBytesBtn setAlpha:1];
        }];
    }
    //pageControl.currentPage = page;
}

+ (CGPathRef)fancyShadowForRect:(CGRect)rect distance:(float)distance {
    CGSize size = rect.size;
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    //right
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(size.width, 0.0f)];
    [path addLineToPoint:CGPointMake(size.width, size.height + distance)];
    
    //curved bottom
    [path addCurveToPoint:CGPointMake(0.0, size.height + distance)
            controlPoint1:CGPointMake(size.width - distance, size.height)
            controlPoint2:CGPointMake(distance, size.height)];
    
    [path closePath];
    
    return path.CGPath;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods

- (void)createCards {
    cardViewControllers = [[NSMutableArray alloc] init];
    
    CardViewController *poolPlay = [[CardViewController alloc] initWithTitle:@"Pool Play" discription:@"Race with friends!"];
    [cardViewControllers addObject:poolPlay];
    
    CardViewController *competitive = [[CardViewController alloc] initWithTitle:@"Competitive" discription:@"Race against friends!"];
    [cardViewControllers addObject:competitive];
    
    CardViewController *defensive = [[CardViewController alloc] initWithTitle:@"Defensive" discription:@"Attack and Defend!"];
    [cardViewControllers addObject:defensive];
}

- (void)styleLayer: (CALayer *)layer {
    layer.cornerRadius = 4.0f;
    layer.shadowOffset =  CGSizeMake(1, 1);
    layer.shadowColor = [[UIColor blackColor] CGColor];
    layer.shadowRadius = 4.0f;
    layer.shadowOpacity = 0.30f;
    //layer.shadowPath = [[UIBezierPath bezierPathWithRect:buttonLayer.bounds] CGPath];
    layer.shadowPath = [AKStyler fancyShadowForRect:layer.bounds distance:5.0f];
}

#pragma mark - IBActions

-(IBAction)scrollWith:(id)sender {
    [scrollView setContentOffset:CGPointMake(320*segControl.selectedSegmentIndex, scrollView.contentOffset.y) animated:YES];
}

- (void)handleCardActive:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"Singled you out, %ld", (long)gestureRecognizer.view.tag);
    if (gestureRecognizer.view.tag > 0) {
        CGRect destRect = CGRectMake(whatAreBytesBtn.frame.origin.x+5, whatAreBytesBtn.frame.origin.y, whatAreBytesBtn.frame.size.width-10, whatAreBytesBtn.frame.size.height);
        [gestureRecognizer.view setCenter:CGPointMake(scrollView.center.x, scrollView.center.y/1.5+20)];
        [gestureRecognizer.view genieInTransitionWithDuration:1
                                          destinationRect:destRect
                                          destinationEdge:BCRectEdgeTop completion:^{
                                              NSLog(@"Done!");
                                              [scrollView setHidden:YES];
                                              [UIView animateWithDuration:0.2 animations:^{
                                                  [segControl setAlpha:0];
                                              } completion:^(BOOL finished) {
                                                  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
                                                  GameSetupViewController *setup = (GameSetupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"gameSetup"];
                                                  [self presentViewController:setup animated:NO completion:nil];
                                              }];
                                          }];
    }
}

@end
