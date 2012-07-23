//
//  Node.h
//  BSTree
//
//  Created by Tristin Forbus on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
// -----------------------------------------------------------------------------
//
// A node holds a value of some type of object. Useful for Binary Search Trees.

#import <Foundation/Foundation.h>
#import "LogEntity.h"

@interface Node : NSObject

// The object inserted into the node
@property(nonatomic, strong) LogEntity* value;

// Node's left and right children
@property(nonatomic, strong) Node* left;
@property(nonatomic, strong) Node* right;

-(id)init;
-(id)initWithValue:(LogEntity*)_value;
-(id)initWithNode:(Node*)node;  // Copy constructor
-(NSNumber*)size;
-(BOOL)isLeaf;
-(BOOL)hasOnlyOneSubtree;
-(BOOL)hasTwoSubtrees;


-(NSComparisonResult)compare:(Node*)other;
-(BOOL)doesFallBetweenNodes:(Node*)lower and:(Node*)upper;
-(BOOL)doesDateFallBetweenDates:(NSDate*)lower and:(NSDate*)upper;
@end
