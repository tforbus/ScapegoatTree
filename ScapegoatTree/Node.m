//
//  Node.m
//  BSTree
//
//  Created by Tristin Forbus on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Node.h"

// Private methods
@interface Node()
-(int)sizeOf:(Node*)current;
@end

@implementation Node
@synthesize value, left, right;

#pragma mark - Initialization --------------------------------------------------

-(id) init
{
    [self setLeft:nil];
    [self setRight:nil];
    return self;
}

-(id) initWithValue:(LogEntity*)_value
{
    [self setLeft:nil];
    [self setRight:nil];
    [self setValue:_value];
    
    return self;
}

-(id) initWithNode:(Node *)node
{
    [self setLeft:nil];
    [self setRight:nil];
    [self setValue:node.value];
    return self;
}

#pragma mark - Size ------------------------------------------------------------

-(NSNumber*)size
{
    return [NSNumber numberWithInt:[self sizeOf:self]];
}

-(int)sizeOf:(Node*)current
{
    if(current == nil)
        return 0;
    else
        return [self sizeOf:current.left] + [self sizeOf:current.right] + 1;
}


-(NSComparisonResult)compare:(Node*)other
{    
    return [self.value.date compare:other.value.date];
}


-(BOOL)isLeaf
{
    return self.left == nil && self.right == nil;
}


-(BOOL)hasOnlyOneSubtree
{
    BOOL hasLeft = self.left != nil && self.right == nil;
    BOOL hasRight = self.left == nil && self.right != nil;
    
    return (hasLeft || hasRight);
}


-(BOOL)hasTwoSubtrees
{
    return ![self isLeaf] && ![self hasOnlyOneSubtree];
}


-(BOOL)doesFallBetweenNodes:(Node*)lower and:(Node*)upper
{
    BOOL greaterThanLowerBound  = [self compare:lower] == NSOrderedDescending;
    BOOL equalToLowerBound      = [self compare:lower] == NSOrderedSame;
    BOOL lowerThanUpperBound    = [self compare:upper] == NSOrderedAscending;
    BOOL equalToUpperBound      = [self compare:upper] == NSOrderedSame;
    
    BOOL inLower = greaterThanLowerBound || equalToLowerBound;
    BOOL inUpper = lowerThanUpperBound || equalToUpperBound;
    
    return inLower && inUpper;
}


-(BOOL)doesDateFallBetweenDates:(NSDate*)lower and:(NSDate*)upper
{
    BOOL greaterThanLowerBound  = [self.value.date compare:lower] == NSOrderedDescending;
    BOOL equalToLowerBound      = [self.value.date compare:lower] == NSOrderedSame;
    BOOL lowerThanUpperBound    = [self.value.date compare:upper] == NSOrderedAscending;
    BOOL equalToUpperBound      = [self.value.date compare:upper] == NSOrderedSame;
    
    BOOL inLower = greaterThanLowerBound || equalToLowerBound;
    BOOL inUpper = lowerThanUpperBound || equalToUpperBound;
    
    return inLower && inUpper;
}


@end
