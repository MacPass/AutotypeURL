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
static NSString *ATUBraveBundleIdentifier = @"com.brave.Browser";
static NSString *ATUEdgeBundleIdentifier = @"com.microsoft.edgemac";
static NSString *ATUChromiumBundleIdentifier = @"org.chromium.Chromium";

@implementation ATUChromeExtractor

- (NSArray<NSString *> *)supportedBundleIdentifiers {
  return @[ATUChromeBundleIdentifier, ATUBraveBundleIdentifier, ATUEdgeBundleIdentifier, ATUChromiumBundleIdentifier];
}

- (nonnull NSString *)URLForRunningApplication:(nonnull NSRunningApplication *)runningApplication {
  if(![self.supportedBundleIdentifiers containsObject:runningApplication.bundleIdentifier]) {
    return @"";
  }
  NSString *source = [NSString stringWithFormat:@"tell application \"%@\" to get URL of active tab of front window", runningApplication.localizedName];
  NSAppleScript *script = [[NSAppleScript alloc] initWithSource:source];
  NSAppleEventDescriptor *aed = [script executeAndReturnError:NULL];
  NSString *urlString = aed.stringValue;
  return urlString == nil ? @"" : urlString;
}

@end
