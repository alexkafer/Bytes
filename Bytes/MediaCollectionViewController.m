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
    return mediaCells.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"NormalCell" forIndexPath:indexPath];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Index: %li", (long)indexPath.item);
    
    return true;
}

-(void)saveNewMedia {
    NSArray *newData = [[NSArray alloc] initWithObjects:@"otherData", nil];
    
    [self.collectionView performBatchUpdates:^{
        int resultsSize = [self.mediaCells count]; //data is the previous array of data
        [self.mediaCells addObjectsFromArray:newData];
        NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
        for (int i = resultsSize; i < resultsSize + newData.count; i++)
        {
            [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow:i-1 inSection:0]];
        }
        
        [self.collectionView insertItemsAtIndexPaths:arrayWithIndexPaths];
    } completion:nil];
    
}

- (void)viewDidLoad {
    self.mediaCells = [[NSMutableArray alloc] init];
    [mediaCells addObject:@"AddCell"];
    
    NSLog(@"Added");
}


@end
