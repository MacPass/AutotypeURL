//
//  ATUSafariExtractor.m
//  AutotypeURL
//
//  Created by Michael Starke on 10.05.19.
//  Copyright © 2019 HicknHack Software GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ATUFirefoxExtractor.h"

static NSString *ATUFirefoxBundleIdentifier = @"org.mozilla.firefox";

@implementation ATUFirefoxExtractor

- (NSArray<NSString *>*)supportedBundleIdentifiers {
  return @[ATUFirefoxBundleIdentifier];
}

- (nonnull NSString *)URLForRunningApplication:(nonnull NSRunningApplication *)runningApplication {
  if(![self.supportedBundleIdentifiers containsObject:runningApplication.bundleIdentifier]) {
    return @"";
  }
  NSAppleScript *script = [[NSAppleScript alloc] initWithSource:@"tell application \"System Events\"\n \
                           tell application \"Firefox\" to activate\n \
                           tell application \"System Events\"\n \
                               keystroke \"l\" using command down\n \
                               keystroke \"c\" using command down\n \
                           end tell\n\
                           delay 0.5\n\
                           return the clipboard\n\
                       end tell"];
  NSAppleEventDescriptor *aed = [script executeAndReturnError:NULL];
  NSString *urlString = aed.stringValue;
  return urlString == nil ? @"" : urlString;
}

@end
