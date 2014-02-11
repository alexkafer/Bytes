//
//  MediaCollectionViewController.m
//  Bytes
//
//  Created by Alex Kafer on 2/5/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "MediaCollectionViewController.h"

@implementation MediaCollectionViewController
@synthesize mediaCells;

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return mediaCells.count; //TODO Change this number with how many cells are in the array
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddCell" forIndexPath:indexPath];
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath == 0) {
        [mediaCells addObject:@"Data"];
        return false;
    }
    
    return true;
}

- (void)viewWillAppear:(BOOL)animated {
    [mediaCells removeAllObjects];
    [mediaCells addObject:@"Add"];
    NSLog(@"Added");
}


@end
