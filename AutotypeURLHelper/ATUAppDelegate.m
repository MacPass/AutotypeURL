//
//  AppDelegate.m
//  AutotypeURLHelper
//
//  Created by Michael Starke on 09.05.19.
//  Copyright © 2019 HicknHack Software GmbH. All rights reserved.
//

#import "ATUAppDelegate.h"

@implementation ATUAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  NSAppleScript *script = [[NSAppleScript alloc] initWithSource:@"tell application \"Safari\" to get URL of front document"];
  NSDictionary *errorDict;
  NSAppleEventDescriptor *aed = [script executeAndReturnError:&errorDict];
  NSLog(@"%@", aed.stringValue);
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}


@end
