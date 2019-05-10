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
static NSString *ATUHelperName = @"AutotypeURLHelper";

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
  
  [self _launchHelperApplication];
  return @"";
}

- (void)_launchHelperApplication {
  NSBundle *bundle = [NSBundle bundleForClass:self.class];
  NSURL *helperBundleURL = [bundle URLForResource:ATUHelperName withExtension:@"app"];
  NSBundle *helperBundle = [NSBundle bundleWithURL:helperBundleURL];
  NSURL *helperExecuteableURL = helperBundle.executableURL;
  
  NSPipe *outputPipe = [NSPipe pipe];
  NSTask *task = [[NSTask alloc] init];
  task.launchPath = helperExecuteableURL.path;
  task.standardOutput = outputPipe;
  [task launch]; 
  [task waitUntilExit];
  NSFileHandle *fh = outputPipe.fileHandleForReading;
  NSString *output = [[NSString alloc] initWithData:[fh readDataToEndOfFile] encoding:NSUTF8StringEncoding];
  NSLog(@"Output: %@", output);
}

@end
