//
//  Tree.m
//  BSTree
//
//  Created by Tristin Forbus on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Tree.h"

// Methods that nobody needs to see, but require some documentation anyway.
@interface Tree()

@end


@implementation Tree
@synthesize root, numberOfNodes, alpha;
@synthesize maxNodeCount;
@synthesize wasDuplicateDetected;

#pragma mark - Constructors ----------------------------------------------------
-(id)init
{
    [self setRoot:nil];
    [self setAlpha:0.5];
    return self;
}


-(id)initWithAlpha:(float)a
{
    [self setRoot:nil];
    [self setAlpha:a];
    return self;
}


#pragma mark - Retrieving interval ---------------------------------------------
-(NSMutableArray*)allBetween:(id)value1 and:(id)value2
{
    NSMutableArray* results = [[NSMutableArray alloc] init];
    Node* node1 = [[Node alloc] initWithValue:value1];
    Node* node2 = [[Node alloc] initWithValue:value2];
    
    [self allBetween:node1 and:node2 start:[self root] list:results];
    return results;
}


-(void)allBetween:(Node*)value1 and:(Node*)value2 start:(Node*)node 
             list:(NSMutableArray*)list
{
    BOOL one = [node compare:value1] == NSOrderedDescending || [node compare:value1] == NSOrderedSame;
    BOOL two = [node compare:value2] == NSOrderedAscending || [node compare:value2] == NSOrderedSame;
    if(node.left != nil)
        [self allBetween:value1 and:value2 start:node.left list:list];
    if(one && two)
        [list addObject:node];
    if(node.right != nil)
        [self allBetween:value1 and:value2 start:node.right list:list];
}


#pragma mark - Insertion -------------------------------------------------------

-(void)insertNode:(Node *)node
{
    [self setWasDuplicateDetected:NO];
    [self insertNode:node currentNode:[self root]];
    //self.numberOfNodes++;
    
    if(!self.wasDuplicateDetected)
    {
        numberOfNodes++;
        [self updateMaxNodeCount];
    }
}


-(void)insertNode:(Node*)node currentNode:(Node *)current
{
    if(self.root == nil)
    {
        root = node;
    }
    
    else if([node compare:current] == NSOrderedDescending)
    {
        if(current.right != nil)
            [self insertNode:node currentNode:current.right];
        else
        {
            current.right = node;
        }
    }
    
    else if([node compare:current] == NSOrderedAscending) 
    {
        if(current.left != nil)
            [self insertNode:node currentNode:current.left];
        else
        {
            current.left = node;
        }
    }
    
    // Trying to insert a duplicate. Just return.
    else
    {
        //numberOfNodes--;
        [self setWasDuplicateDetected:YES];
        return;
    }
    
    // Found a problem.
    // Rebalance is necessary.
    if([self isScapegoat:current])
    {
        [self rebuildWithScapegoat:current];
    }
}

// When inserting the value object, put it in a node, and then insert.
-(void)insertValue:(id)value
{
    Node* node = [[Node alloc] initWithValue:value];
    [self insertNode:node currentNode:[self root]];
}


#pragma mark - Scapegoat Tree methods ------------------------------------------
-(void)updateMaxNodeCount
{
    if([self numberOfNodes] > [self maxNodeCount])
    {
        self.maxNodeCount = self.numberOfNodes;
    }
}


-(BOOL)isScapegoat:(Node*)node
{
    if(node == nil)
        return false;
    
    int nodeSize = [[node size] integerValue];
    int sizeLeft = node.left == nil ? 0 : [[node.left size] integerValue];
    int sizeRight = node.right == nil ? 0 : [[node.right size] integerValue];
    bool isBalanced = sizeLeft <= alpha*nodeSize && sizeRight <= alpha*nodeSize;
    return !isBalanced;
}


-(void*)flatten:(Node*)node withList:(NSMutableArray*)nodes
{
    if(node.left != nil)
        [self flatten:node.left withList:nodes];
    
    [nodes addObject:node];
    
    if(node.right != nil)
        [self flatten:node.right withList:nodes];
    
    node.right = nil;
    node.left = nil;
}


-(Node*)buildTreeWithList:(NSMutableArray*)list
{
    Node* subroot = [self buildTreeWithList:list min:0 max:[list count]-1];
    return subroot;
}



-(Node*)buildTreeWithList:(NSMutableArray*)list min:(int)minIndex max:(int)maxIndex
{
    if(maxIndex < minIndex)
        return nil;
    
    else if(maxIndex == minIndex)
        return [list objectAtIndex:maxIndex];
    
    else
    {
        int middle = ceil((maxIndex + minIndex) / 2);
        Node* troot = [list objectAtIndex:middle];
        troot.left = [self buildTreeWithList:list min:minIndex max:middle - 1];
        troot.right = [self buildTreeWithList:list min:middle+1 max:maxIndex];
        
        return troot;
    }
}


-(void)rebuildWithScapegoat:(Node*)goat
{
    NSMutableArray* flattened = [[NSMutableArray alloc] init];
    [self flatten:goat withList:flattened];
    Node* balancedRoot = [self buildTreeWithList:flattened];
    
    if(root == goat)
    {
        root = balancedRoot;
    }
    
    else
    {
        Node* goatParent = [self parentOf:goat start:[self root]];
        if([goat compare:goatParent] == NSOrderedAscending)
            goatParent.left = balancedRoot;
        else
            goatParent.right = balancedRoot;
    }
}



#pragma mark - Search ----------------------------------------------------------
-(Node*)search:(id)value
{
    if(root == nil || root.value == value)
    {
        return root;
    }
    else
    {
        return [self search:value start:[self root]];
    }
    
}


-(Node*)search:(id)value start:(Node*)current
{
    if(value > current.value)
    {
        return [self search:value start:current.right];
    }
    
    else if(value < current.value)
    {
        return [self search:value start:current.left];
    }
    
    else 
    {
        return current;
    }
}


-(Node*)parentOf:(Node*)node start:(Node*)current
{
    if([self root] == nil)
        return nil;
    
    //if(node > current)
    if([node compare:current] == NSOrderedDescending)
    {
        if(current.right != nil)
        {
            if(current.right == node)
                return current;
            else
                return [self parentOf:node start:current.right];
        }
    }
    
    //else if(node < current)
    else if([node compare:current] == NSOrderedAscending)
    {
        if(current.left != nil)
        {
            if(current.left == node)
                return current;
            else
                return [self parentOf:node start:current.left];
        }
    }
    
    else
        return nil;
}


#pragma mark - Deleting --------------------------------------------------------
-(void)deleteNode:(Node*)node
{
    Node* parent = [self parentOf:node start:[self root]];
    
    // The node is a leaf.
    if([node isLeaf])
        [self deleteLeafNode:node withParent:parent];
    
    // The node has only 1 subtree
    else if((node.left == nil && node.right != nil) || (node.left != nil && node.right == nil))
        [self deleteNodeWithOneSubtree:node withParent:parent];
    
    // The node has 2 subtrees
    else
        [self deleteNodeWithTwoSubtrees:node];
    
    self.numberOfNodes--;
    
    // check rebalance
    if(self.numberOfNodes <= self.maxNodeCount/2)
    {
        self.maxNodeCount = self.numberOfNodes;
        NSMutableArray* allNodes = [[NSMutableArray alloc] init];
        [self flatten:self.root withList:allNodes];
        [self buildTreeWithList:allNodes];
    }
}


-(void)deleteLeafNode:(Node*)node withParent:(Node*)parent
{
    if(node == [self root])
        [self setRoot:nil];
    
    if(node < parent)
        parent.left = nil;
    else
        parent.right = nil;
}


// Man, I am sure I could get rid of some of these IFs, but I'm hungry.
-(void)deleteNodeWithOneSubtree:(Node*)node withParent:(Node*)parent
{    
    // has only right subtree
    if(node.left == nil)
    {
        // special case for root
        if(node == [self root])
        {
            [self setRoot:node.right];
        }
        
        else
        {
            if(node < parent)
                [parent setLeft:node.right];
            else
                [parent setRight:node.right];
        }
    }
    
    // has only left subtree
    else
    {
        if(node == [self root])
        {
            [self setRoot:node.left];
        }
        
        else
        {
            if(node < parent)
                [parent setLeft:node.left];
            else
                [parent setRight:node.left];
        }
    }
}


-(void)deleteNodeWithTwoSubtrees:(Node*)node
{
    // Step 1) Find minimum element in right subtree (minRight)
    Node* minNode = [self minNodeFrom:node.right];
    
    // Step 2) Store minRight's value
    id temp = minNode.value;
    
    // Step 3) Delete minRight from the tree
    [self deleteNode:minNode];
    
    // Step 4) Put minRight's value into node
    [node setValue:temp];
}


-(Node*)minNodeFrom:(Node*)start
{
    Node* marker = start;
    
    while(marker.left != nil)
        marker = marker.left;
    
    return marker;
}


#pragma mark - Height ----------------------------------------------------------
-(NSNumber*)height
{
    return [NSNumber numberWithInt:[self heightOf:[self root]]];
}


-(int)heightOf:(Node*)current
{
    if(current == nil)
        return 0;
    else
        return fmax([self heightOf:current.left], [self heightOf:current.right]) + 1;
}


-(NSNumber*)alphaHeight
{
    // need to convert to base 1/alpha
    // log_a(x) = log_b(x) / log_b(a)
    double ans = log(numberOfNodes) / log(1 / alpha);
    return [NSNumber numberWithDouble:ans];
}


-(NSNumber*)alphaHeightOf:(Node*)current
{
    double ans = log([[current size] doubleValue]) / log(1 / alpha);
    return [NSNumber numberWithDouble:ans];
}


-(BOOL)isAlphaBalanced
{
    return [[self height] doubleValue] <= [[self alphaHeight] doubleValue] + 1;
}


-(BOOL)isAlphaBalancedAt:(Node *)current
{
    return [self heightOf:current] <= [[self alphaHeightOf:current] doubleValue] + 1;
}


#pragma mark - Printing --------------------------------------------------------
-(void)print
{
    [self print:[self root]];
}

-(void)print:(Node*)start
{
    if(start.left != nil)
        [self print:start.left];
    NSLog(@"%@", start.value);
    if(start.right != nil)
        [self print:start.right];
}

@end
