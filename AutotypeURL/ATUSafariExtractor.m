//
//  ATUSafariExtractor.m
//  AutotypeURL
//
//  Created by Michael Starke on 10.05.19.
//  Copyright © 2019 HicknHack Software GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ATUSafariExtractor.h"

static NSString *ATUSafariBundleIdentifier = @"com.apple.Safari";

@implementation ATUSafariExtractor

- (NSString *)supportedBundleIdentifier {
  return ATUSafariBundleIdentifier;
}

- (nonnull NSString *)URLForRunningApplication:(nonnull NSRunningApplication *)runningApplication {
  if(![runningApplication.bundleIdentifier isEqualToString:self.supportedBundleIdentifier]) {
    return @"";
  }
  NSAppleScript *script = [[NSAppleScript alloc] initWithSource:@"tell application \"Safari\" to get URL of front document"];
  NSAppleEventDescriptor *aed = [script executeAndReturnError:NULL];
  NSString *urlString = aed.stringValue;
  return urlString == nil ? @"" : urlString;
}

@end
