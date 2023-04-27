//
//  ATUSafariTechnologyPreviewExtractor.m
//  AutotypeURL
//
//  Created by Advers on 27.04.2023.
//  Copyright © 2019 HicknHack Software GmbH. All rights reserved.
//  Copyright © 2023 Advers Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ATUSafariTechnologyPreviewExtractor.h"

static NSString *ATUSafariPreviewBundleIdentifier = @"com.apple.SafariTechnologyPreview";

@implementation ATUSafariTechnologyPreviewExtractor

- (NSArray<NSString *>*)supportedBundleIdentifiers {
  return @[ATUSafariPreviewBundleIdentifier];
}

- (nonnull NSString *)URLForRunningApplication:(nonnull NSRunningApplication *)runningApplication {
  if(![self.supportedBundleIdentifiers containsObject:runningApplication.bundleIdentifier]) {
    return @"";
  }
  NSAppleScript *script = [[NSAppleScript alloc] initWithSource:@"tell application \"Safari Technology Preview\" to get URL of front document"];
  NSAppleEventDescriptor *aed = [script executeAndReturnError:NULL];
  NSString *urlString = aed.stringValue;
  return urlString == nil ? @"" : urlString;
}

@end
