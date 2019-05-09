//
//  AutotypeURLHelper.m
//  AutotypeURLHelper
//
//  Created by Michael Starke on 08.05.19.
//  Copyright © 2019 HicknHack Software GmbH. All rights reserved.
//

#import "ATUAutotypeURLHelper.h"

@implementation ATUAutotypeURLHelper

// This implements the example protocol. Replace the body of this class with the implementation of this service's protocol.
- (void)runAppleScriptWithSource:(NSString *)source withReply:(void (^)(NSString *))reply {
  dispatch_async(dispatch_get_main_queue(), ^{
    NSAppleScript *script = [[NSAppleScript alloc] initWithSource:source];
    NSDictionary *errorDict;
    NSAppleEventDescriptor *aed = [script executeAndReturnError:&errorDict];
    NSLog(@"%@", errorDict);
    reply(aed.stringValue);
  });
}

/*
- (NSString *)_getURLFromSafari {
  NSAppleScript *script = [[NSAppleScript alloc] initWithSource:@"tell application \"Safari\" to get URL of front document"];
  NSAppleEventDescriptor *aed = [script executeAndReturnError:NULL];
  return aed.stringValue;
}

- (NSString *)_getURLFromChrome {
  NSAppleScript *script = [[NSAppleScript alloc] initWithSource:@"tell application \"Google Chrome\" to get URL of active tab of front window"];
  NSAppleEventDescriptor *aed = [script executeAndReturnError:NULL];
  return aed.stringValue;
}
 */

@end
