//
//  ATUURLExtraction.h
//  AutotypeURL
//
//  Created by Michael Starke on 10.05.19.
//  Copyright © 2019 HicknHack Software GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class NSRunningApplication;

@protocol ATUURLExtraction <NSObject>

@required
@property (readonly, nonatomic) NSArray<NSString *> *supportedBundleIdentifiers;
- (NSString *)URLForRunningApplication:(NSRunningApplication *)runningApplication;

@end

NS_ASSUME_NONNULL_END
