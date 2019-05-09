//
//  AutotypeURLHelper.h
//  AutotypeURLHelper
//
//  Created by Michael Starke on 08.05.19.
//  Copyright © 2019 HicknHack Software GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATUAutotypeURLHelperProtocol.h"

// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
@interface ATUAutotypeURLHelper : NSObject <ATUAutotypeURLHelperProtocol>
@end
