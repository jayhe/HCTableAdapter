//
//  HCTableViewEvent.h
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/11.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCTableViewEventDelegate.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HCDemoTableViewEventType) {
    HCDemoTableViewEventTypeClickCell = 1,
    HCDemoTableViewEventTypeClickFoldUnfoldHeader,
};

@interface HCDemoTableViewEvent : NSObject <HCTableViewEventDataProtocol>

@property (nonatomic, assign) HCDemoTableViewEventType eventType;
@property (nonatomic, strong) id eventData;

@end

NS_ASSUME_NONNULL_END
