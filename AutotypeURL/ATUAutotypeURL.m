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


NSString *const kMPASettingsKeyFullMatch = @"kMPASettingsKeyFullMatch";

@interface  ATUAutotypeURL ()

@property (strong) NSArray<id<ATUURLExtraction>> *extractors;

@property (nonatomic) BOOL fullMatchEnabled;

@end

@implementation ATUAutotypeURL
@synthesize settingsViewController = _settingsViewController;


+(void)initialize{
  [[NSUserDefaults standardUserDefaults] registerDefaults:@{ kMPASettingsKeyFullMatch : @NO }];
}

- (instancetype)initWithPluginHost:(MPPluginHost *)host {
  self = [super initWithPluginHost:host];
  if(self) {
    self.extractors = @[[[ATUChromeExtractor alloc] init], [[ATUSafariExtractor alloc] init]];
  }
  return self;
}

- (BOOL)acceptsRunningApplication:(nonnull NSRunningApplication *)runningApplication {
  id<ATUURLExtraction> extractor = [self _extractorForBundleIdentifier:runningApplication.bundleIdentifier];
  return (extractor != nil);
}

- (nonnull NSString *)windowTitleForRunningApplication:(nonnull NSRunningApplication *)runningApplication {
  id<ATUURLExtraction> extractor = [self _extractorForBundleIdentifier:runningApplication.bundleIdentifier];
  
  if(!extractor) {
    return @"";
  }
  
  BOOL fullMatch = [NSUserDefaults.standardUserDefaults boolForKey:kMPASettingsKeyFullMatch];
  
  NSString *urlString = [extractor URLForRunningApplication:runningApplication];
  NSURL *url = [[NSURL alloc] initWithString:urlString];
  
  if(fullMatch) {
    return url.host.length > 0 ? urlString : @"";
  }
  return url.host.length > 0 ? url.host : @"";
}

- (NSViewController *)settingsViewController {
  if(!_settingsViewController) {
    _settingsViewController = [[ATUSettingsViewController alloc] init];
  }
  return _settingsViewController;
}

- (id<ATUURLExtraction>)_extractorForBundleIdentifier:(NSString*)bundleIdentifier {
  for(id<ATUURLExtraction> extractor in self.extractors) {
    if([extractor.supportedBundleIdentifiers containsObject:bundleIdentifier]) {
      return extractor;
    }
  }
  return nil;
}


@end


