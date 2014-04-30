//
//  CardTapCestureRecognizer.m
//  Bytes
//
//  Created by Alex Kafer on 4/20/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "CardTapGestureRecognizer.h"

@implementation CardTapGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    if ([self.delegate respondsToSelector:@selector(gestureRecognizer:touched:andEvent:)]) {
        [(id)self.delegate gestureRecognizer:self touched:touches andEvent:event];
    }
    
}
@end
