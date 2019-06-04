//
//  ATUAutotypeURL.m
//  AutotypeURL
//
//  Created by Michael Starke on 07.05.19.
//  Copyright © 2019 HicknHack Software GmbH. All rights reserved.
//
#import "ATUAutotypeURL.h"
#import "MPATUSettingsViewController.h"
#import "ATUSafariExtractor.h"
#import "ATUChromeExtractor.h"


@interface  ATUAutotypeURL ()

@property (nonatomic, strong) MPATUSettingsViewController *settingsViewController;
@property (nonatomic) BOOL allowSafari;
@property (strong) NSDictionary<NSString *, id<ATUURLExtraction>> *extractors;



@end




@implementation ATUAutotypeURL

@synthesize settingsViewController = _settingsViewController;


+ (void)initialize {
  [[NSUserDefaults standardUserDefaults] registerDefaults:@{ kSettingsAllowSafari : @YES,
                                                             kSettingsAllowChrome : @(YES),
                                                             kSettingsURLDomain : @NO,
                                                             kSettingsURLSubDomain: @YES,
                                                             kSettingsURLCompleteDomain: @(NO) }];
  NSLog(@"allowSafari kSettings %@", kSettingsAllowSafari);
}

- (instancetype)initWithPluginHost:(MPPluginHost *)host {
  self = [super initWithPluginHost:host];
  if(self) {
    

//    NSUserDefaultsController *defaultsController = [NSUserDefaultsController sharedUserDefaultsController];
    _allowSafari = [[NSUserDefaults standardUserDefaults] boolForKey:kSettingsAllowSafari];
    NSLog(@"allowSafari kSettings %@", kSettingsAllowSafari);
    NSLog(@"allow safari BOOL %hhd", _allowSafari);
    ATUChromeExtractor *chrome = [[ATUChromeExtractor alloc] init];
    ATUSafariExtractor *safari = [[ATUSafariExtractor alloc] init];
    self.extractors = @{
                        chrome.supportedBundleIdentifier : chrome,
                        safari.supportedBundleIdentifier : safari
                        };
  }
  return self;
}

- (void)dealloc {
  
  NSLog(@"%@ dealloc", [self class]);
}
- (NSViewController *)settingsViewController {
  if(!_settingsViewController) {
    self.settingsViewController = [[MPATUSettingsViewController alloc] init];
    self.settingsViewController.plugin = self;

  }
  return _settingsViewController;
}
- (void)setSettingsViewController:(MPATUSettingsViewController *)settingsViewController {
  _settingsViewController = settingsViewController;
}


- (BOOL)acceptsRunningApplication:(nonnull NSRunningApplication *)runningApplication {
  id<ATUURLExtraction> extractor = self.extractors[runningApplication.bundleIdentifier];
  return (extractor != nil);
}

- (nonnull NSString *)windowTitleForRunningApplication:(nonnull NSRunningApplication *)runningApplication {
  id<ATUURLExtraction> extractor = self.extractors[runningApplication.bundleIdentifier];
  if(extractor) {
    NSString *urlString = [extractor URLForRunningApplication:runningApplication];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    return url.host.length > 0 ? url.host : @"";
  }
  return @"";
}


@end

