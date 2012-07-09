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

#pragma mark - Initialization
-(id) init
{
    [self setLeft:nil];
    [self setRight:nil];
    return self;
}

-(id) initWithValue:(NSDate*)_value
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

#pragma mark - Size
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
    // JUST TESTING
    //return [[self.value integerValue] compare:[other.value integerValue]];
    /*if([self.value integerValue] < [other.value integerValue])
        return NSOrderedAscending;
    else if([self.value integerValue] > [other.value integerValue])
        return NSOrderedDescending;
    else
        return NSOrderedSame;*/
    
    // COMPARING OBJECTS
    /*if([self.value compare:other.value] == NSOrderedSame)
        NSLog(@"%@ and %@ are the same", self.value, other.value);
    else if([self.value compare:other.value] == NSOrderedAscending)
             NSLog(@"%@ and %@ are ascending", self.value, other.value);
    else
        NSLog(@"%@ and %@ are descending", self.value, other.value);
    */
    
    return [self.value compare:other.value];
}

-(NSString*)description
{
    return nil;
    //return [self value].description;
}

-(BOOL)isLeaf
{
    return self.left == nil && self.right == nil;
}

@end
