//
//  Tree.h
//  BSTree
//
//  Created by Tristin Forbus on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
// -----------------------------------------------------------------------------
//
// Tree is somewhat of a misnomer. This is a Scapegoat tree, a self-balancing 
// binary search tree. More information available on Wikipedia, dogg.

#import <Foundation/Foundation.h>
#import "Node.h"

@interface Tree : NSObject

@property(nonatomic, retain) Node* root;
@property int numberOfNodes;                // Size of the tree
@property int maxNodeCount;                 // Used for scapegoat methods
@property float alpha;                      // How strict is the balancing?
@property BOOL wasDuplicateDetected;        // Used to throw away duplicate nodes


// Singleton stuff
+(void)initialize;                          // Only called once ever, guaranteed
+(Tree*)instance;                           // Return the instance of the Tree

// Initialization
-(id)init;
-(id)initWithAlpha:(float)a;
-(id)initWithAlpha:(float)a andBuildFromList:(NSMutableArray*)list;


// Insertion
-(void)insertNode:(Node*)node;
-(void)insertValue:(id)value;
-(void)buildRootFromList:(NSMutableArray*)list;


// Deletion
-(void)deleteNode:(Node*)node;
-(void)deleteValue:(id)value;


// Search
-(Node*)search:(id)value;


// Display
-(void)print;


// Methods specific for the WorkoutApp project.
-(NSMutableArray*)allLogsBetween:(NSDate*)date1 and:(NSDate*)date2;



@end
