//
//  main.m
//  AutotypeURLHelper
//
//  Created by Michael Starke on 09.05.19.
//  Copyright © 2019 HicknHack Software GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ATUAppDelegate.h"

int main(int argc, const char * argv[]) {
  @autoreleasepool
  {
    /*
     NSArray<NSString *> *args = NSProcessInfo.processInfo.arguments;
     TODO validate args count
     */
    NSApplication *application = [NSApplication sharedApplication];
    ATUAppDelegate *delegate = [[ATUAppDelegate alloc] init];
    application.delegate = delegate;
    [application run];
  }
  return EXIT_SUCCESS;
}
