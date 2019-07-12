//
//  ATUAutotypeURL.m
//  AutotypeURL
//
//  Created by Michael Starke on 07.05.19.
//  Copyright © 2019 HicknHack Software GmbH. All rights reserved.
//

#import "ATUAutotypeURL.h"
#import "ATUSafariExtractor.h"
#import "ATUChromeExtractor.h"
#import "ATUSettingsViewController.h"


NSString *const kMPRSettingsKeySubdomMatch        = @"kMPRSettingsKeySubdomMatch";
NSString *const kMPRSettingsKeyFullMatch          = @"kMPRSettingsKeyFullMatch";

@interface  ATUAutotypeURL ()

@property (strong) NSDictionary<NSString *, id<ATUURLExtraction>> *extractors;
@property (strong) ATUSettingsViewController *settingsViewController;
//@property (strong) NSViewController <MPPluginSettings> *settingsViewController;

@end

@implementation ATUAutotypeURL
@synthesize settingsViewController = _settingsViewController;


+(void)initialize{
  [[NSUserDefaults standardUserDefaults] registerDefaults:@{ kMPRSettingsKeySubdomMatch : @YES, kMPRSettingsKeyFullMatch : @NO }];
}

- (instancetype)initWithPluginHost:(MPPluginHost *)host {
  self = [super initWithPluginHost:host];
  if(self) {
    
    
    
    
    ATUChromeExtractor *chrome = [[ATUChromeExtractor alloc] init];
    ATUSafariExtractor *safari = [[ATUSafariExtractor alloc] init];
    self.extractors = @{
                        chrome.supportedBundleIdentifier : chrome,
                        safari.supportedBundleIdentifier : safari
                        };
  }
  return self;
}

- (BOOL)acceptsRunningApplication:(nonnull NSRunningApplication *)runningApplication {
  id<ATUURLExtraction> extractor = self.extractors[runningApplication.bundleIdentifier];
  return (extractor != nil);
}

- (nonnull NSString *)windowTitleForRunningApplication:(nonnull NSRunningApplication *)runningApplication {
  id<ATUURLExtraction> extractor = self.extractors[runningApplication.bundleIdentifier];
  NSUserDefaults *defaultsController = [NSUserDefaults standardUserDefaults];
//  BOOL domMatch = [defaultsController boolForKey:kMPRSettingsKeyDomMatch];
  BOOL subdomMatch = [defaultsController boolForKey:kMPRSettingsKeySubdomMatch];
  BOOL fullMatch = [defaultsController boolForKey:kMPRSettingsKeyFullMatch];
  
  
  if(extractor) {
    NSString *urlString = [extractor URLForRunningApplication:runningApplication];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    if (subdomMatch == YES) {
      return url.host.length > 0 ? url.host : @"";
    }
    else if (fullMatch == YES) {
      return url.host.length > 0 ? urlString : @"";
    }
  }
  return @"";
}


@end

