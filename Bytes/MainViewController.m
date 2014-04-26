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
#import "LeaderboardsCard.h"
#import "GCHelper.h"
#import "PinPointCodeView.h"
#import "PinPointViewController.h"

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
                [obj.startButton addTarget:self action:@selector(cardButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        if ([obj isKindOfClass:[PinPointCodeView class]]) {
            PinPointCodeView *pin = (PinPointCodeView *)obj;
            [[pin useCodeBtn] addTarget:self action:@selector(useButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [[pin randomCode] addTarget:self action:@selector(randomButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            CardTapGestureRecognizer *tap = [[CardTapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCardActive:)];
            [tap setNumberOfTapsRequired:2];
            [obj addGestureRecognizer:tap];

        }
        
        [obj setTag:idx+1];
        //[obj.view enableDragging];
        //[obj.view setScrollViewPriority:scrollView];
        [scrollView addSubview:obj];
    }];
    
    CardView *stem = [[CardView alloc] initWithTitle:@"STEM" discription:@"Student App"];
    [stem setCenter:CGPointMake(scrollView.center.x + 320*cardViewControllers.count, scrollView.center.y/1.5+20)];
    [[stem startButton] setHidden:YES];
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
    
    if ([[GCHelper sharedInstance] userAuthenticated]) {
        [accountName setText:[[GKLocalPlayer localPlayer] alias]];
    } else {
        [accountName setText:@"Guest"];
    }
    
    [self randomButtonPressed:nil];
}

#pragma mark - Delegate Methods

-(void)scrollViewWillBeginDragging:(UIScrollView *)currentScrollView {
    if ([currentScrollView isEqual:scrollView])
    {
        [currentScrollView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[LeaderboardsCard class]]) {
                CardView *replacedCard = [(LeaderboardsCard *)obj replacedCard];
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
}

#pragma mark - Custom Methods

- (void)createCards {
    cardViewControllers = [[NSMutableArray alloc] init];
    
    CardView *countDown = [[CardView alloc] initWithTitle:@"Countdown" discription:@"Gather as many bytes as you can in 30 seconds!"];
    [countDown setGamePlayControllerIdentifier:@"countDownPlay"];
    [cardViewControllers addObject:countDown];
    
    pinPointCard = [[PinPointCodeView alloc] initWithPinPointTitle:@"Pinpoint" discription:@"Use a code to race against friends!"];
    [pinPointCard setGamePlayControllerIdentifier:@"pinPointPlay"];
    [[pinPointCard codeField] setHidden:YES];
    [cardViewControllers addObject:pinPointCard];
    
    CardView *million = [[CardView alloc] initWithTitle:@"Race to a Gig" discription:@"Speed your way to a billion bytes!"];
    [million setGamePlayControllerIdentifier:@"billionPlay"];
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
        UIView *replacedCard = [(LeaderboardsCard *)gestureRecognizer.view replacedCard];
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
            LeaderboardsCard *leaderboard = [[LeaderboardsCard alloc] initFromNib];
            [leaderboard setReplacedCard:(CardView *)originalView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCardReturn:)];
            [tap setNumberOfTapsRequired:1];
            [leaderboard addGestureRecognizer:tap];
            
            [leaderboard loadView];
            [leaderboard setCenter:[originalView center]];
            CGPoint location = [lastCardTouch locationInView:[gestureRecognizer view]];
            [UIView transitionFromView:originalView toView:leaderboard duration:0.5 options:[MainViewController optionForLocation:location inView:originalView] completion:^(BOOL finished) {
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
    UIViewController *play = nil;
    if ([identifier isEqualToString:@"pinPointPlay"]) {
        play = (PinPointViewController *)[storyboard instantiateViewControllerWithIdentifier:identifier];
        PinPointViewController *pinPlay = (PinPointViewController *)play;
        [pinPlay setTargetGoal:(NSInteger *)[pinPointCard getBytesForGame]];
    } else {
        play = [storyboard instantiateViewControllerWithIdentifier:identifier];
    }
    [card setCenter:CGPointMake([scrollView center].x, [card center].y)];
    [self animateViewOut:card toViewController:play];
}

#pragma mark - Pin Actions
#pragma mark IBActions

- (IBAction) randomButtonPressed: (id)sender {
    NSInteger randomNumb = [self getRandomNumberBetween:1000000 maxNumber:1000000000]; //About 1 MB to 1 GB
    [pinPointCard setBytesTo:randomNumb];
}

- (IBAction)useButtonPressed: (id)sender {
    UIAlertView *pinAlert = [[UIAlertView alloc] initWithTitle:@"Enter Code:" message:@"Codes are used to get the same random number as a friend. Ask for theirs!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Sumbit", nil];
    pinAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[pinAlert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [pinAlert show];
}

#pragma mark Alert View Delegate Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) return;
    NSInteger codeInput = [[[alertView textFieldAtIndex:0] text] integerValue];
    if (!codeInput) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Code must only be numbers" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    } else {
        [pinPointCard setCodeTo:codeInput];
        
    }
}

#pragma mark - Utility Methods

-(void)animateViewOut: (UIView *)view toViewController: (UIViewController *)endView {
    CGRect destRect = CGRectMake( self.view.frame.size.width/4, self.view.frame.size.height+5, self.view.frame.size.width/2, 20);
    
    [view genieInTransitionWithDuration:1
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

- (NSInteger)getRandomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max
{
    return min + arc4random() % (max - min + 1);
}
@end
