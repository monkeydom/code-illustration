//
//  RBLAppDelegate.m
//  RecursiveBlocks
//
//  Created by Dominik Wagner on 21.06.13.
//  Copyright (c) 2013 TheCodingMonkeys. All rights reserved.
//

#import "RBLAppDelegate.h"
#import "RBLAsynchronousCompletionThingy.h"


@interface RBLAppDelegate ()
@property (nonatomic, strong) NSMutableSet *thingiesSet;
@end

@implementation RBLAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
	
	RBLAsynchronousCompletionThingy *thingy = [RBLAsynchronousCompletionThingy new];
	
	[thingy calculateHardOnRandomNumberCompletion:^(BOOL didFinish) {
		NSLog(@"%s test finished!",__FUNCTION__);
	}];
	
	self.thingiesSet = [NSMutableSet new];
}

- (IBAction)startRecursiveLoop:(id)sender {
	RBLAsynchronousCompletionThingy *thingy = [RBLAsynchronousCompletionThingy new];
	[self.thingiesSet addObject:thingy]; // we use existance in the set to check if we need to stop
	
	__weak NSSet *weakThingies = self.thingiesSet; // this is done so the block doesn't retain self
	__block void(^loop)(BOOL didFinish) = ^(BOOL didFinish) {
		if ([weakThingies containsObject:thingy]) {
			[thingy calculateHardOnRandomNumberCompletion:loop];
		} else {
			loop = nil; // release ourselves
		}
	};
	loop(YES);
}

- (IBAction)stopRecursiveLoop:(id)sender {
	id object = self.thingiesSet.anyObject;
	if (object) {
		[self.thingiesSet removeObject:object];
	}
}
@end
