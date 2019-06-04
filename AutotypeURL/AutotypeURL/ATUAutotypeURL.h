//
//  ATUAutotypeURL.h
//  AutotypeURL
//
//  Created by Michael Starke on 07.05.19.
//  Copyright © 2019 HicknHack Software GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MPPlugin.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const kSettingsAllowSafari;
FOUNDATION_EXPORT NSString *const kSettingsAllowChrome;
FOUNDATION_EXPORT NSString *const kSettingsURLDomain;
FOUNDATION_EXPORT NSString *const kSettingsURLSubDomain;
FOUNDATION_EXPORT NSString *const kSettingsURLCompleteDomain;



@interface ATUAutotypeURL : MPPlugin <MPAutotypeWindowTitleResolverPlugin, MPPluginSettings>



@end

NS_ASSUME_NONNULL_END
