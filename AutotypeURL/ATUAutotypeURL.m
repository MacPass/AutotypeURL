//
//  ATUAutotypeURL.m
//  AutotypeURL
//
//  Created by Michael Starke on 07.05.19.
//  Copyright © 2019 HicknHack Software GmbH. All rights reserved.
//

#import "ATUAutotypeURL.h"

static NSString *ATUChromeBundleIdentifier = @"com.google.Chrome";
static NSString *ATUSafariBundleIdentifier = @"com.apple.Safari";

@interface NSRunningApplication (ATUAutotypeURLAdditions)

@property (nonatomic, readonly) BOOL atu_isSafari;
@property (nonatomic, readonly) BOOL atu_isChrome;

@end

@implementation NSRunningApplication (ATUAutotypeURLAdditions)

- (BOOL)atu_isSafari {
    return [self.bundleIdentifier isEqualToString:ATUSafariBundleIdentifier];
}

- (BOOL)atu_isChrome {
    return [self.bundleIdentifier isEqualToString:ATUChromeBundleIdentifier];
}

@end

@implementation ATUAutotypeURL

- (BOOL)acceptsRunningApplication:(nonnull NSRunningApplication *)runningApplication {
    if(runningApplication.atu_isChrome || runningApplication.atu_isSafari) {
        return YES;
    }
    return NO;
}

- (nonnull NSString *)windowTitleForRunningApplication:(nonnull NSRunningApplication *)runningApplication {
    if(runningApplication.atu_isSafari) {
        return [self _getURLFromSafari];
    }
    if(runningApplication.atu_isChrome) {
        return [self _getURLFromChrome];
    }
    return @"";
}

- (NSString *)_getURLFromSafari {
    NSAppleScript *script = [[NSAppleScript alloc] initWithSource:@"tell application \"Safari\" to get URL of front document"];
    NSAppleEventDescriptor *aed = [script executeAndReturnError:NULL];
    NSString *rawURL = aed.stringValue;
    
    NSLog(@"%@ - raw URL", rawURL);
    NSLog(@"%@ - parsedURL", [self _parseURL:rawURL]);
    return [self _parseURL:rawURL];
    
    
}

- (NSString *)_getURLFromChrome {
    NSAppleScript *script = [[NSAppleScript alloc] initWithSource:@"tell application \"Google Chrome\" to get URL of active tab of front window"];
    NSAppleEventDescriptor *aed = [script executeAndReturnError:NULL];
    return aed.stringValue;
}
//Additions for parsing the url subdomain.root.com
- (NSString *)_parseURL: (NSString*) url {
    NSURL *separatedURL = [[NSURL alloc] initWithString:url];
    NSString *subDomIncluded = [separatedURL host];
    return subDomIncluded;
    
}

@end

