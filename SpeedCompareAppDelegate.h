//
//  SpeedCompareAppDelegate.h
//  SpeedCompare
//
//  Created by John McLaughlin on 8/22/10.
//  Copyright 2010 Loghound.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SpeedCompareAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	NSMutableArray *items;
}

@property (assign) IBOutlet NSWindow *window;
@property (retain) NSMutableArray *items;
-(NSString*)UUIDString ;
-(void) populateItemsOfSize:(NSInteger)size;
@end
