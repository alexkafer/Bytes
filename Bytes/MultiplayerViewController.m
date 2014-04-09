//
//  MainViewController.m
//  Bytes
//
//  Created by Alex Kafer on 2/5/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "MultiplayerViewController.h"
#import "CardViewController.h"
#import "GameSetupViewController.h"
#import "UIView+Genie.h"
#import "AKStyler.h"

//#import "UIView+swipeVertical.h"

@interface MultiplayerViewController ()

@end

@implementation MultiplayerViewController

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
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [tap setNumberOfTapsRequired:1];
        [obj.view addGestureRecognizer:tap];
        [obj.view setTag:idx];
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
    //pageControl.currentPage = page;
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

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    // single tap handling
    //NSLog(@"All the single taps");
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
   // CardViewController *selectedCard = [cardViewControllers objectAtIndex:gestureRecognizer.view.tag];
//
//    GameSetupViewController *setup = (GameSetupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"setupGame"];
//    [setup.navigationController setTitle:[selectedCard.titleLabel text]];
//    [setup setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//    
//    UIView *emptyView = [[UIView alloc] initWithFrame:self.view.frame];
//    [emptyView setBackgroundColor:[UIColor whiteColor]];
//    
//    [UIView animateWithDuration:0.5
//                     animations:^{
//                         [scrollView setBackgroundColor:[UIColor whiteColor]];
//                         [segControl setAlpha:0];
//                         [whatAreBytesBtn setAlpha:0];
//                         //[self.view setBackgroundColor:[UIColor whiteColor]];
//                         [scrollView setBounds:CGRectMake(scrollView.bounds.origin.x, scrollView.bounds.origin.y, scrollView.bounds.size.width, scrollView.bounds.size.height + 150)];
//                         [scrollView setCenter:CGPointMake(scrollView.center.x, scrollView.center.y+70)];
//                     } completion:^(BOOL finished) {
//                         [segControl setHidden:YES];
//                         [whatAreBytesBtn setHidden:YES];
//                     }];
//    
//    [UIView transitionFromView:gestureRecognizer.view toView:nil
//                      duration:.5
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    completion:^(BOOL finished) {
//                        [UIView animateWithDuration:4 animations:nil completion:^(BOOL finished) {
//                            [self presentViewController:setup animated:NO completion:nil];
//                        }];
//                    }];
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
                                                  NSLog(@"Switch new gameset");
                                              }];
                                          }];
    
//    [setup transitionFromViewController:self toViewController:setup duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight
//                            animations:^(void) {
//                                [selectedCard.view setBackgroundColor:[UIColor redColor]];
//    }completion:^(BOOL finished) {
//        NSLog(@"Finished");
//    }];
}

@end
