//
//  GameSetupViewController.m
//  Bytes
//
//  Created by Alex Kafer on 4/8/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "GameSetupViewController.h"
#import "AKGravatar.h"
#import "AKPlayer.h"
#import "AKStyler.h"
#import "UIView+draggable.h"
#import "UIImageView+movable.h"
#import <Parse/Parse.h>

@interface GameSetupViewController ()

@end

@implementation GameSetupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [managerView enableDragging];
    [managerView setDraggable:YES];
    [inviteView enableDragging];
    [inviteView setDraggable:YES];
    [AKStyler styleLayer:managerView.layer opacity:0.0 fancy:NO];
    [AKStyler styleLayer:inviteView.layer opacity:0.0 fancy:NO];
    [AKStyler styleLayer:managerButton.layer opacity:0.1 fancy:NO];
    
    players = [[NSMutableArray alloc] init];
    
    [inviteSearch addTarget:self
                     action:@selector(searchForPlayer)
       forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [addPlayer setUserInteractionEnabled:YES];
    
    [addPlayer setImage:[AKGravatar circularScaleAndCropImage:[UIImage imageNamed:@"AddPlayer"] frame:addPlayer.bounds]];
    UITapGestureRecognizer *addPlayerTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPlayer:)];
    [addPlayerTap setNumberOfTapsRequired:1];
    [addPlayer addGestureRecognizer:addPlayerTap];
    
    float radius = (profileView.bounds.size.width+profileView.bounds.size.height)/4;
    [profileView.layer setCornerRadius:radius];
    [profileView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [profileView.layer setBorderWidth:5];
    
    //[profileView.layer setMasksToBounds:YES];
    UIImage *originalImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[AKGravatar getGravatarURL:[[PFUser currentUser] email] withSize:radius*4]]];
    UIImage *newImage = [AKGravatar circularScaleAndCropImage:originalImage frame:profileView.bounds];
    [profileView setImage:newImage];
    [profileView setTag:1];
    
    [profileView.layer setShadowOffset:CGSizeMake(1, -1) ];
    [profileView.layer setShadowColor: [[UIColor blackColor] CGColor]];
    [profileView.layer setShadowRadius: 4.0f];
    [profileView.layer setShadowPath:[[UIBezierPath bezierPathWithRoundedRect:profileView.layer.bounds cornerRadius:radius] CGPath]];
    
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapping:)];
    [singleTap setNumberOfTapsRequired:1];
    [profileView addGestureRecognizer:singleTap];
    
    [profileView enableDragging];
    [profileView setDraggable:YES];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    
    if (isAdding) {
        UIView *touchedView = [touch view];
        if ([touchedView isEqual:self.view]) {
            [self.view.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
                [obj endEditing:YES];
            }];
        }
    }
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

#pragma mark - Listeners

-(void)searchForPlayer {
    NSString *searchquary = [inviteSearch text];
    NSLog(@"Searched for: %@", searchquary);
}

-(void)singleTapping:(UIGestureRecognizer *)recognizer
{
    if (profileView.tag > 0) {
        int newTag = (int)profileView.tag + 1;
        if (newTag >= 3) {
            
        } else {
            [profileView setTag:newTag];
        }
        
    }
}

-(void)addPlayer:(UIGestureRecognizer *)recognizer
{
    [inviteView setHidden:NO];
    [inviteView enableDragging];
    [inviteView setDraggable:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Keyboard
#define kOFFSET_FOR_KEYBOARD 80.0

-(void)keyboardWillShow {
    [self moveAuthWithKeyboard];
    isAdding = YES;
}

-(void)hideKeyboard {
    [inviteView endEditing:YES];
    isAdding = NO;
}

//method to move the auth up whenever the keyboard would get in the way
-(void)moveAuthWithKeyboard
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    NSLog(@"Orgin min, %f", inviteView.center.y);
    if (inviteView.center.y > 280) {
        [inviteView setCenter:CGPointMake(inviteView.center.x, inviteView.center.y+(280 - inviteView.center.y))];
    }
    
    [UIView commitAnimations];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
@end
