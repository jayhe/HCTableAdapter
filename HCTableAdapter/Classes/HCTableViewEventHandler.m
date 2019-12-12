//
//  HCTableViewEventHandler.m
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/11.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import "HCTableViewEventHandler.h"

@implementation HCTableViewEventHandler

#pragma mark - HCTableViewEventDelegate

- (void)onCatchEvent:(id<HCTableViewEventDataProtocol>)event {
    NSAssert(0, @"shoule be overide");
}

@end
