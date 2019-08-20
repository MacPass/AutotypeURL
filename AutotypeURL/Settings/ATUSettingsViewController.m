//
//  ATUSettingsViewController.m
//  AutotypeURL
//
//  Created by George Snow on 7/10/19.
//  Copyright © 2019 George Snow All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATUSettingsViewController.h"
#import "ATUAutotypeURL.h"

@interface ATUSettingsViewController ()




@property (weak) IBOutlet NSButton *fullmatchEnableCheck;


@property (nonatomic) BOOL fullmatchEnabled;


@end

@implementation ATUSettingsViewController

- (void)dealloc {
  NSLog(@"%@ dealloc", [self class]);


  [self.fullmatchEnableCheck unbind:NSValueBinding];
  
}

- (NSBundle *)nibBundle {
//  NSLog(@"nib bundle bundleforclass %@", self.className);
  return [NSBundle bundleForClass:[self class]];
}

- (NSString *)nibName {
  return @"AutotypeURLSettings";
}

- (void)awakeFromNib {
//  NSLog(@"awake from nib");
  static BOOL didAwake = NO;
  if(!didAwake) {

    NSUserDefaultsController *defaultsController = [NSUserDefaultsController sharedUserDefaultsController];
    [self.fullmatchEnableCheck bind:NSValueBinding
                toObject:defaultsController
             withKeyPath:[NSString stringWithFormat:@"values.%@", kMPASettingsKeyFullMatch]
                 options:nil];

    didAwake = YES;
  }
}





@end


