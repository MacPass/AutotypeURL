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



NSString *const kMPASettingsKeyFullMatch          = @"kMPASettingsKeyFullMatch";

@interface  ATUAutotypeURL ()

@property (strong) NSDictionary<NSString *, id<ATUURLExtraction>> *extractors;
@property (strong) ATUSettingsViewController *settingsViewController;

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
  BOOL fullMatch = [defaultsController boolForKey:kMPASettingsKeyFullMatch];
  
  ;
  if(extractor) {
    NSString *urlString = [extractor URLForRunningApplication:runningApplication];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    if (fullMatch == NO) {
      NSLog(@"subdom match %@", url.host);
      return url.host.length > 0 ? url.host : @"";
    }
    else {
      NSLog(@"full match match %@", urlString);
      return url.host.length > 0 ? urlString : @"";
    }
  }
  return @"";
}

- (NSViewController *)settingsViewController {
  if(!_settingsViewController) {
    self.settingsViewController = [[ATUSettingsViewController alloc] init];
    self.settingsViewController.plugin = self;
  }

  return _settingsViewController;
}

- (void)setSettingsViewController:(ATUSettingsViewController *)settingsViewController {
  
  _settingsViewController = settingsViewController;
}


@end


