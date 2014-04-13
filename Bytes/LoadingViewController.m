//
//  LoadingViewController.m
//  Bytes
//
//  Created by Alex Kafer on 3/27/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "LoadingViewController.h"
#import "MainViewController.h"
#import "AKStyler.h"
#import "UIView+draggable.h"
#import "AuthView.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [authView setHidden:YES];
    [authView setCenter:self.view.center];
    
    [authView enableDragging];
    [authView setDraggable:YES];
    
    loadingLabel.alpha = 1;
    loadingLabel.text = @"1";
    loadingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                    target:self
                                                  selector:@selector(typeALetter:)
                                                  userInfo:nil
                                                   repeats:YES];
    //FIXME loading label FIXME
    loadingIndex = 0;
    
    [AKStyler styleLayer:authView.layer opacity:0.1 fancy:NO];
    [AKStyler styleLayer:authView.loginButton.layer opacity:0.1 fancy:NO];
    [AKStyler styleLayer:authView.cancelButton.layer opacity:0.1 fancy:NO];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    [UIView animateWithDuration:0.5
                          delay:0.2
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [bytesImage setTransform:CGAffineTransformMakeTranslation(0, -140)];
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                         
                         
                         [self startLoadingSequence];
                     }];
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

#pragma mark - Internal Loading Methods

- (void)typeALetter:(id)sender {
    NSString *nextDigit;
    if ([self getYesOrNo]) {
        nextDigit = @"1";
    } else {
        nextDigit = @"0";
    }
    loadingLabel.text = [loadingLabel.text stringByAppendingFormat:@"%@", nextDigit];
    if (loadingIndex < 100) {
        loadingIndex++;
        loadingLabel.alpha =- 0.01;
    } else {
        loadingIndex = 0;
        loadingLabel.alpha = 1;
        loadingLabel.text = @"";
    }
    
}

-(BOOL) getYesOrNo
{
    int tmp = arc4random_uniform(2);
    if (tmp >= 1) {
        return YES;
    }
    return NO;
}

-(void)completed {
    
    [UIView animateWithDuration:0.5 animations:^{
        loadingLabel.center = CGPointMake(loadingLabel.center.x, loadingLabel.center.y+120);
        [bytesImage setCenter:CGPointMake(bytesImage.center.x, bytesImage.center.y-120)];
    } completion:^(BOOL finished) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        MainViewController *main = (MainViewController *)[storyboard instantiateViewControllerWithIdentifier:@"mainView"];
        [self presentViewController:main animated:NO completion:nil];
    }];
    
    
}



#pragma mark Authentication

- (void) showAuthentication {
        [authView setCenter:self.view.center];
        [authView setHidden:NO];
        isAuthing = YES;
    NSLog(@"Test");
}

-(void) startLoadingSequence {
    if (/*Gamecenter is not Authed */ true) {
        [self showAuthentication];
    } else {
        [self userAuthenticated];
    }
}

-(void)userAuthenticated {
    if (/*Gamecenter is not Authed */ true) {
        [authView setHidden:YES];
        isAuthing = NO;
        [self completed];
    } else {
        [self showAuthentication];
    }
}

#pragma mark - IBActions

-(IBAction)loginWithGameCenter:(id)sender {
    NSLog(@"Login");
}

-(IBAction)cancelWithGameCenter:(id)sender {
    NSLog(@"Cancel");
}

@end
