//
//  HCTableViewEvent.m
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/11.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import "HCDemoTableViewEvent.h"

@implementation HCDemoTableViewEvent

#pragma mark - HCTableViewEventDataProtocol

- (HCDemoTableViewEventType)eventType {
    return _eventType;
}

- (id)eventData {
    return _eventData;
}

@end
