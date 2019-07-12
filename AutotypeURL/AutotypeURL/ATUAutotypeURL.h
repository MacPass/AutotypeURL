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


FOUNDATION_EXPORT NSString *const kMPRSettingsKeySubdomMatch;
FOUNDATION_EXPORT NSString *const kMPRSettingsKeyFullMatch;

@interface ATUAutotypeURL : MPPlugin <MPPluginSettings, MPAutotypeWindowTitleResolverPlugin>;


@end

NS_ASSUME_NONNULL_END
