//
//  ATUAutotypeURL.m
//  AutotypeURL
//
//  Created by Michael Starke on 07.05.19.
//  Copyright © 2019 HicknHack Software GmbH. All rights reserved.
//

#import "ATUAutotypeURL.h"
#import "../AutotypeURLHelper/ATUAutotypeURLHelperProtocol.h"

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

@interface ATUAutotypeURL ()

@property (nonatomic) NSDictionary *scripts;

@end

@implementation ATUAutotypeURL

- (instancetype)initWithPluginHost:(MPPluginHost *)host {
  self = [super initWithPluginHost:host];
  if(self) {
    self.scripts = @{ @"com.apple.Safari"   : @"tell application \"Safari\" to get URL of front document",
                      @"com.google.Chrome"  : @"tell application \"Google Chrome\" to get URL of active tab of front window" };
  }
  return self;
}

- (BOOL)acceptsRunningApplication:(nonnull NSRunningApplication *)runningApplication {
  return (self.scripts[runningApplication.bundleIdentifier] != nil);
}

- (nonnull NSString *)windowTitleForRunningApplication:(nonnull NSRunningApplication *)runningApplication {
  
  NSLog(@"%@", runningApplication);
  NSString *scriptSource = self.scripts[runningApplication.bundleIdentifier];
  if(scriptSource.length == 0) {
    return @"";
  }
  
  NSLog(@"Establishin XPC connection");
  NSXPCConnection *_connectionToService = [[NSXPCConnection alloc] initWithServiceName:@"com.hicknhacksoftware.AutotypeURLHelper"];
  _connectionToService.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(ATUAutotypeURLHelperProtocol)];
  [_connectionToService resume];

  //Once you have a connection to the service, you can use it like this:
  
  NSLog(@"Requesting reply");
  [_connectionToService.remoteObjectProxy runAppleScriptWithSource:scriptSource withReply:^(NSString *URL) {
    NSLog(@"%@", URL);
  }];
  
  //And, when you are finished with the service, clean up the connection like this:
  [_connectionToService invalidate];
  return @"";
}

@end
