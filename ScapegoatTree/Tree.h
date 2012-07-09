//
//  Tree.h
//  BSTree
//
//  Created by Tristin Forbus on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface Tree : NSObject

@property(nonatomic, retain) Node* root;
@property int numberOfNodes;
@property int maxNodeCount;
@property float alpha;
@property BOOL wasDuplicateDetected;

-(id)init;
-(id)initWithAlpha:(float)a;

-(void)insertNode:(Node*)node;
-(void)insertValue:(id)value;

-(void)deleteNode:(Node*)node;
-(void)deleteValue:(id)value;

-(void)updateMaxNodeCount;

-(void)print;
-(Node*)search:(id)value;
-(NSNumber*)height;
-(NSMutableArray*)allBetween:(id)value1 and:(id)value2;

@end
