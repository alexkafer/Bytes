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
#import "AKTeam.h"
#import "AKStyler.h"
#import "UIView+draggable.h"
#import "UIImageView+movable.h"

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
    
    players = [[NSMutableArray alloc] init];
    
    AKPlayer *host = [[AKPlayer alloc] initWithUsername:@"Usernmame" andGravatarEmail:@"alexkafer@gmail.com"];
    [players addObject:host];
    
    [players enumerateObjectsUsingBlock:^(AKPlayer *obj, NSUInteger idx, BOOL *stop) {
        GameSetupPlayerView *playerCard = [obj getPlayerProfileView];
        [playerCard setTag:idx];
        [playerCard setCenter:self.view.center];
        [playerCard enableDragging];
        [playerCard setDraggable:YES];
        [self.view addSubview:playerCard];
    }];
    // Do any additional setup after loading the view.
}

//-(void)addPlayer: (NSString *)detail withProfilePic: (UIImage *)profile {
//    GameSetupPlayerView *playerProfile = [[GameSetupPlayerView alloc] initWithPlayerDetail:@"You (Host)" withUncroppedProfilePicture:profile];
//    [playerProfile loadView];
//    
//    UITapGestureRecognizer *playerTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playerTapped:)];
//    [playerTap setNumberOfTapsRequired:1];
//    [playerProfile addGestureRecognizer:playerTap];
//    
//    [playerProfile enableDragging];
//    [playerProfile setDraggable:YES];
//    [players addObject:playerProfile];
//}

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

#pragma mark - Listeners

-(void)playerTapped:(UIGestureRecognizer *)recognizer
{
    if ([recognizer.view isKindOfClass:[GameSetupPlayerView class]]) {
        NSInteger tag = recognizer.view.tag;
        AKPlayer *player = [players objectAtIndex:tag];
        //AKTeam *oldTeam = [player currentTeam];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Keyboard
//#define kOFFSET_FOR_KEYBOARD 80.0
//
//-(void)keyboardWillShow {
//    [self moveAuthWithKeyboard];
//    isAdding = YES;
//}
//
//-(void)hideKeyboard {
//    [inviteView endEditing:YES];
//    isAdding = NO;
//}
//
////method to move the auth up whenever the keyboard would get in the way
//-(void)moveAuthWithKeyboard
//{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
//    NSLog(@"Orgin min, %f", inviteView.center.y);
//    if (inviteView.center.y > 280) {
//        [inviteView setCenter:CGPointMake(inviteView.center.x, inviteView.center.y+(280 - inviteView.center.y))];
//    }
//    
//    [UIView commitAnimations];
//}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
@end
