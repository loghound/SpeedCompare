//
//  SpeedCompareAppDelegate.m
//  SpeedCompare
//
//  Created by John McLaughlin on 8/22/10.
//  Copyright 2010 Loghound.com. All rights reserved.
//

#import "SpeedCompareAppDelegate.h"

@implementation SpeedCompareAppDelegate

@synthesize window;
@synthesize items;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	printf("size\tLinear\tblocks\n");
	for (int i=1;i<20;i++) {
		NSInteger size=(NSInteger)pow(2, i);
		[self populateItemsOfSize:size];
		NSString *itemToFind=[self.items objectAtIndex:size-1]; // half way
		__block BOOL foundIt=FALSE;
		NSDate *ref=[NSDate date];
		if ([self.items containsObject:itemToFind]) foundIt=true;;
		NSTimeInterval time=[[NSDate date] timeIntervalSinceDate:ref];
		BOOL foundItLin=foundIt;
		float timeLin=(float)time;
		
		
		foundIt=FALSE;
		ref=[NSDate date];
		[self.items enumerateObjectsWithOptions:NSEnumerationConcurrent
									 usingBlock:^(id s,NSUInteger idx,BOOL *stop){
										 
										 if ([(NSString*)s isEqual:itemToFind]) {
											 foundIt=TRUE;
											 *stop=TRUE;
											 
										 }
										 return;
										 
									 }]; // 		 <#(void (^)(id obj, NSUInteger idx, BOOL *stop))block#>
		
		time=[[NSDate date] timeIntervalSinceDate:ref];
		BOOL foundItBlocks=foundIt;
		float timeBlock=(float)time;
		
		if (foundItBlocks!=TRUE || foundItLin!=TRUE)
			NSLog(@"didn't find it!?!?!");
		
		printf([[NSString stringWithFormat:@"%6d\t%f\t%f\n",size,timeLin,timeBlock]UTF8String]);

		 

		
		
	
	}
	
}


-(void) populateItemsOfSize:(NSInteger)size {

	self.items=[NSMutableArray array];
	for (int i=0;i<size;i++) {
		[self.items addObject:[self UUIDString]];
	}
	
}
			 
			 
-(NSString*)UUIDString {
	CFUUIDRef theUUID = CFUUIDCreate(NULL);
	CFStringRef string = CFUUIDCreateString(NULL, theUUID);
	CFRelease(theUUID);
	return [(NSString *)string autorelease];
}


@end
