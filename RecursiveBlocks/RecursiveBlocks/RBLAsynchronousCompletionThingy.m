//
//  RBLAsynchronousCompletionThingy.m
//  RecursiveBlocks
//
//  Created by Dominik Wagner on 21.06.13.
//  Copyright (c) 2013 TheCodingMonkeys. All rights reserved.
//

#import "RBLAsynchronousCompletionThingy.h"

@implementation RBLAsynchronousCompletionThingy

- (void)finishCalculationCompletion:(void(^)(BOOL didFinish))aCompletion {
	NSLog(@"%s random number is: %u",__FUNCTION__, arc4random());
	aCompletion(YES);
}

- (void)calculateHardOnRandomNumberCompletion:(void(^)(BOOL didFinish))aCompletion {
	// just to make it asynchrounously enough
	[self performSelector:@selector(finishCalculationCompletion:) withObject:aCompletion afterDelay:3.0];
}

@end
