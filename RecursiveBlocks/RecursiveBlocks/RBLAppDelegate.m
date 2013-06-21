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
	__block void (__weak ^weakLoop)(BOOL); // this is the weak reference, so the block isn't retained by us
	void (^loop)(BOOL) = [^(BOOL didFinish) {
		if ([weakThingies containsObject:thingy]) {
			[thingy calculateHardOnRandomNumberCompletion:weakLoop]; // this makes the retaining of this block the business of thingy - in case of cancellation we will be released as no one is holding on to us anymore
		}
	} copy];
	weakLoop = loop;
	loop(YES); // as loop is a strong variable, it is retnained until after this call
}

- (IBAction)stopRecursiveLoop:(id)sender {
	id object = self.thingiesSet.anyObject;
	if (object) {
		[self.thingiesSet removeObject:object];
	}
}
@end
