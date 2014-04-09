//
//  MediaCollectionViewController.h
//  Bytes
//
//  Created by Alex Kafer on 2/5/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaCollectionViewController : UICollectionViewController {
    NSMutableArray *mediaCells;
}

@property (nonatomic, retain) NSMutableArray *mediaCells;

@end
