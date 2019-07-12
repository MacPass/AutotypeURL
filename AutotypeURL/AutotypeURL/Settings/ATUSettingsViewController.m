//
//  MPRMenu.m
//  MacPassRevealer
//
//  Created by George Snow on 7/10/19.
//  Copyright © 2019 George Snow All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATUSettingsViewController.h"
#import "ATUAutotypeURL.h"

@interface ATUSettingsViewController ()

@property (weak) IBOutlet NSMenuItem *subdomOpt;
@property (weak) IBOutlet NSMenuItem *fullOpt;



@end

@implementation ATUSettingsViewController

- (void)dealloc {
  NSLog(@"%@ dealloc", [self class]);

  [self.subdomOpt unbind:NSValueBinding];
  [self.fullOpt unbind:NSValueBinding];
  
}

- (NSBundle *)nibBundle {
  return [NSBundle bundleForClass:[self class]];
}

- (NSString *)nibName {
  return @"ATUSettings";
}

- (void)awakeFromNib {
  static BOOL didAwake = NO;
  if(!didAwake) {
    NSUserDefaultsController *defaultsController = [NSUserDefaultsController sharedUserDefaultsController];
 
    [self.subdomOpt bind:NSValueBinding
                              toObject:defaultsController
                           withKeyPath:[NSString stringWithFormat:@"values.%@", kMPRSettingsKeySubdomMatch]
                               options:nil];
    [self.fullOpt bind:NSValueBinding
                toObject:defaultsController
             withKeyPath:[NSString stringWithFormat:@"values.%@", kMPRSettingsKeyFullMatch]
                 options:nil];
    didAwake = YES;
  }
}


@end


