//
//  HCTableViewEventDelegate.h
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/11.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HCTableViewEventDataProtocol;

@protocol HCTableViewEventDelegate <NSObject>

/**
 事件响应抽象统一入口

 @param event 事件
 */
- (void)onCatchEvent:(id<HCTableViewEventDataProtocol>)event;

@end

@protocol HCTableViewEventDataProtocol <NSObject>
@required
/**
 事件的类型

 @return 一般定义一个枚举
 */
- (NSInteger)eventType;

@optional
/**
 事件回传的参数，事件有数据传递的时候需要

 @return 数据
 */
- (nullable id)eventData;

@end

NS_ASSUME_NONNULL_END
