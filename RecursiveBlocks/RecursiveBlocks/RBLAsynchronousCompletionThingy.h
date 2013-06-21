//
//  RBLAsynchronousCompletionThingy.h
//  RecursiveBlocks
//
//  Created by Dominik Wagner on 21.06.13.
//  Copyright (c) 2013 TheCodingMonkeys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBLAsynchronousCompletionThingy : NSObject

- (void)calculateHardOnRandomNumberCompletion:(void(^)(BOOL didFinish))aCompletion;

@end
