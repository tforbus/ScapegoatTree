//
//  Node.h
//  BSTree
//
//  Created by Tristin Forbus on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
// -----------------------------------------------------------------------------
// TODO: To make this fit the type of data being used, change the type of 
// value, and also the compare method.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

// The object inserted into the node
@property(nonatomic, strong) NSDate* value;

// Node's left and right children
@property(nonatomic, strong) Node* left;
@property(nonatomic, strong) Node* right;

-(id)init;
-(id)initWithValue:(id)_value;
-(id)initWithNode:(Node*)node;  // Copy constructor (testing purpoes)
-(NSNumber*)size;
-(BOOL)isLeaf;

-(NSComparisonResult)compare:(Node*)other;
@end
