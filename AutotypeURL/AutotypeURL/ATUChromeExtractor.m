//
//  ATUChromeExtractor.m
//  AutotypeURL
//
//  Created by Michael Starke on 10.05.19.
//  Copyright © 2019 HicknHack Software GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ATUChromeExtractor.h"

static NSString *ATUChromeBundleIdentifier = @"com.google.Chrome";

@implementation ATUChromeExtractor

- (NSString *)supportedBundleIdentifier {
  return ATUChromeBundleIdentifier;
}

- (nonnull NSString *)URLForRunningApplication:(nonnull NSRunningApplication *)runningApplication { 
  if(![runningApplication.bundleIdentifier isEqualToString:self.supportedBundleIdentifier]) {
    return @"";
  }
  NSAppleScript *script = [[NSAppleScript alloc] initWithSource:@"tell application \"Google Chrome\" to get URL of active tab of front window"];
  NSAppleEventDescriptor *aed = [script executeAndReturnError:NULL];
  NSString *urlString = aed.stringValue;
  return urlString == nil ? @"" : urlString;
}

@end
