//
//  UITableViewHeaderFooterView+HCEventDelegate.m
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/11.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import "UITableViewHeaderFooterView+HCEventDelegate.h"
#import <objc/runtime.h>

static char kHCTableViewHeaderFooterEventDelegateKey;

@implementation UITableViewHeaderFooterView (HCEventDelegate)

- (id<HCTableViewEventDelegate>)eventDelegate {
    return objc_getAssociatedObject(self, &kHCTableViewHeaderFooterEventDelegateKey);
}

- (void)setEventDelegate:(id<HCTableViewEventDelegate>)eventDelegate {
    objc_setAssociatedObject(self, &kHCTableViewHeaderFooterEventDelegateKey, eventDelegate, OBJC_ASSOCIATION_ASSIGN);
}

@end
