//
//  main.m
//  ScapegoatTree
//
//  Created by Tristin Forbus on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tree.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        Tree* tree = [[Tree alloc] initWithAlpha:0.57];
        /*Node* n1 = [[Node alloc] initWithValue:[NSDate date]];
        Node* n2 = [[Node alloc] initWithValue:[NSDate date]];
        Node* n3 = [[Node alloc] initWithValue:[NSDate date]];
        Node* n4 = [[Node alloc] initWithNode:n1];*/
        
        Node* n1 = [[Node alloc] initWithValue:[NSNumber numberWithInt:1]];
        Node* n2 = [[Node alloc] initWithValue:[NSNumber numberWithInt:2]];
        Node* n3 = [[Node alloc] initWithValue:[NSNumber numberWithInt:3]];
        Node* n4 = [[Node alloc] initWithValue:[NSNumber numberWithInt:4]];
        
        [tree insertNode:n2];
        [tree insertNode:n3];
        //[tree insertNode:n1];
        [tree insertNode:n4];
        
        NSLog(@"printing tree > > > > > > >");
        [tree print];
        
        NSLog(@"deleting 3 > > > > > > > > >");
        [tree deleteNode:n3];
        [tree print];
        
    }
    return 0;
}

