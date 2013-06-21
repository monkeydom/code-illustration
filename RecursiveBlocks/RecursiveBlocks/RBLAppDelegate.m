//
//  RBLAppDelegate.m
//  RecursiveBlocks
//
//  Created by Dominik Wagner on 21.06.13.
//  Copyright (c) 2013 TheCodingMonkeys. All rights reserved.
//

#import "RBLAppDelegate.h"
#import "RBLAsynchronousCompletionThingy.h"


@implementation RBLAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
	
	RBLAsynchronousCompletionThingy *thingy = [RBLAsynchronousCompletionThingy new];
	
	[thingy calculateHardOnRandomNumberCompletion:^(BOOL didFinish) {
		NSLog(@"%s test finished!",__FUNCTION__);
	}];
}

@end
