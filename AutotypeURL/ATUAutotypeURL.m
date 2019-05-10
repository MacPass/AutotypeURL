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

@interface  ATUAutotypeURL ()

@property (strong) NSDictionary<NSString *, id<ATUURLExtraction>> *extractors;

@end

@implementation ATUAutotypeURL

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
  if(extractor) {
    NSString *urlString = [extractor URLForRunningApplication:runningApplication];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    return url.host.length > 0 ? url.host : @"";
  }
  return @"";
}


@end

