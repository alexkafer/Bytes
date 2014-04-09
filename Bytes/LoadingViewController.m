//
//  LoadingViewController.m
//  Bytes
//
//  Created by Alex Kafer on 3/27/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "LoadingViewController.h"
#import "MultiplayerViewController.h"
#import "AKStyler.h"
#import "UIView+draggable.h"
#import <Parse/Parse.h>

@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [ContactServerLabel setHidden:YES];
    [FetchProfileLabel setHidden:YES];
    [UpdatingContentLabel setHidden:YES];
    [StartingAppLabel setHidden:YES];
    
    [authView enableDragging];
    [authView setDraggable:YES];
    [AKStyler styleLayer:authView.layer opacity:0.5 fancy:YES];
    [AKStyler styleLayer:loginButton.layer opacity:0.1 fancy:NO];
    
    [username addTarget:self
                       action:@selector(focusPassword)
             forControlEvents:UIControlEventEditingDidEndOnExit];
    [password addTarget:self
                 action:@selector(loginFromText)
       forControlEvents:UIControlEventEditingDidEndOnExit];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    [UIView animateWithDuration:0.5
                          delay:0.2
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [bytesImage setCenter:CGPointMake(bytesImage.center.x, bytesImage.center.y-140)];
                         [bytesImage setTransform:CGAffineTransformMakeTranslation(0, -140)];
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                         
                         
                         [self startLoadingSequence];
                         //status = authenticating;
                         //[self updateLoadingBar];
                     }];
    //[self.bytesImage setTransform:CGAffineTransformMakeTranslation(0, -40)];
}

- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    
    if (isAuthing) {
        UIView *touchedView = [touch view];
        if ([touchedView isEqual:self.view]) {
            [self.view.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
                [obj endEditing:YES];
            }];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Animations
#pragma mark Label Animations

-(void) fadeInLabel: (UILabel *) label
{
    [label setAlpha:0];
    [label setHidden:NO];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    //don't forget to add delegate.....
    //[UIView setAnimationDelegate:self];
    
    [UIView setAnimationDuration:1];
    [label setAlpha:1];
    
    //also call this before commit animations......
    //[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
}

-(void) fadeOutLabel: (UILabel *) label
{
    [label setAlpha:1];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    //don't forget to add delegate.....
    //[UIView setAnimationDelegate:self];
    
    [UIView setAnimationDuration:1];
    [label setAlpha:0];
    
    //also call this before commit animations......
    //[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
    //[label setHidden:YES];
}

-(void) slideDownLabel: (UILabel *) label by: (int)amount
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    //don't forget to add delegate.....
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDuration:1];
    [label setBounds:CGRectMake(label.bounds.origin.x, label.bounds.origin.y-amount,
                                label.bounds.size.width, label.bounds.size.height)];
    
    //also call this before commit animations......
    //[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
    //[label setHidden:YES];
}

#pragma mark - Internal Loading Methods

-(void)updateLoadingBar {
    NSString *fullString = @"10101010101010101010101010101010";
    
    NSUInteger loadingPoint = [self currentLoadingCountWithMax:5];
    loadingLabel.text = [fullString substringToIndex: loadingPoint];
    
    if (status > authenticating && [ContactServerLabel isHidden]) {
        [self fadeInLabel:ContactServerLabel];
    }
    
    if (status > fetchingprofile && [FetchProfileLabel isHidden]) {
        [self fadeInLabel:FetchProfileLabel];
    }
    
    if (status > updating && [UpdatingContentLabel isHidden]) {
        [self fadeInLabel:UpdatingContentLabel];
    }
    
    if (status > starting && [StartingAppLabel isHidden]) {
        [self fadeInLabel:StartingAppLabel];
    }
}

-(NSUInteger) currentLoadingCountWithMax: (NSUInteger)max {
    NSUInteger targetedPoint = status;
    NSUInteger currentPoint = loadingCount;
    
    if(targetedPoint > currentPoint) {
        loadingCount = currentPoint + 1;
    }
    
    return MIN(loadingCount, max);
}

-(void)completed {
    [self fadeOutLabel:ContactServerLabel];
    [self fadeOutLabel:FetchProfileLabel];
    [self fadeOutLabel:UpdatingContentLabel];
    [self fadeOutLabel:StartingAppLabel];
    NSLog(@"Completed!");
    [UIView animateWithDuration:0.5 animations:^{
        loadingLabel.center = CGPointMake(loadingLabel.center.x, loadingLabel.center.y+80);
        [bytesImage setCenter:CGPointMake(bytesImage.center.x, bytesImage.center.y-120)];
    } completion:^(BOOL finished) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        MultiplayerViewController *main = (MultiplayerViewController *)[storyboard instantiateViewControllerWithIdentifier:@"mainView"];
        [self presentViewController:main animated:NO completion:nil];
    }];
    
    
}



#pragma mark Authentication

- (void) showAuthentication {
        [authView setCenter:self.view.center];
        [authView setHidden:NO];
        isAuthing = YES;
}

-(void) startLoadingSequence {
    status = authenticating;
    if ([PFUser currentUser] == nil || ![[PFUser currentUser] isAuthenticated]) {
        [self showAuthentication];
    } else {
        [self userAuthenticated];
    }
}

-(void)userAuthenticated {
    if ([PFUser currentUser].isAuthenticated) {
        [authView setHidden:YES];
        isAuthing = NO;
        [self completed];
    } else {
        [self showAuthentication];
    }
}
-(void)loginFromText {
    [self hideKeyboard];
    [PFUser logInWithUsernameInBackground:username.text password:password.text block:^(PFUser *user, NSError *error) {
        if (user) {
            // Do stuff after successful login.
            [self userAuthenticated];
        } else {
            // The login failed. Check error to see why.
            if (error.code == 101) {
                UIColor *oldColor = loginButton.backgroundColor.copy;
                    loginButton.layer.backgroundColor = [UIColor colorWithRed:0.682 green:0.133 blue:0.141 alpha:1.000].CGColor;
                [UIView animateWithDuration:1 animations:^{
                    loginButton.layer.backgroundColor = oldColor.CGColor;
                }];
                
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
                [animation setDuration:0.05];
                [animation setRepeatCount:3];
                [animation setAutoreverses:YES];
                [animation setFromValue:[NSValue valueWithCGPoint:
                                         CGPointMake([authView center].x - 5.0f, [authView center].y)]];
                [animation setToValue:[NSValue valueWithCGPoint:
                                       CGPointMake([authView center].x + 5.0f, [authView center].y)]];
                [[authView layer] addAnimation:animation forKey:@"position"];
            }
        }
    }];
}

#pragma mark - Keyboard
#define kOFFSET_FOR_KEYBOARD 80.0

-(void)keyboardWillShow {
    [self moveAuthWithKeyboard];
}

-(void)focusPassword {
    [password becomeFirstResponder];
}

-(void)hideKeyboard {
    [authView endEditing:YES];
}

//method to move the auth up whenever the keyboard would get in the way
-(void)moveAuthWithKeyboard
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    NSLog(@"Orgin min, %f", authView.center.y);
    if (authView.center.y > 185) {
        [authView setCenter:CGPointMake(authView.center.x, authView.center.y+(185 - authView.center.y))];
    }
    
    [UIView commitAnimations];
}

#pragma mark - IBActions
- (IBAction) registerAccount:(id)sender {
    NSLog(@"Register");
}

- (IBAction)login:(id)sender {
    [self loginFromText];
}

@end
