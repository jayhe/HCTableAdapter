//
//  UITableViewCell+HCEventDelegate.m
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/11.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import "UITableViewCell+HCEventDelegate.h"
#import <objc/runtime.h>

static char kHCTableViewCellEventDelegateKey;

@implementation UITableViewCell (HCEventDelegate)

- (id<HCTableViewEventDelegate>)eventDelegate {
    return objc_getAssociatedObject(self, &kHCTableViewCellEventDelegateKey);
}

- (void)setEventDelegate:(id<HCTableViewEventDelegate>)eventDelegate {
    objc_setAssociatedObject(self, &kHCTableViewCellEventDelegateKey, eventDelegate, OBJC_ASSOCIATION_ASSIGN);
}

@end
