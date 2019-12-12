//
//  HCTableViewEventHandler.h
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/11.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HCTableViewEventDelegate.h"
#import "HCTableViewDataSource.h"

NS_ASSUME_NONNULL_BEGIN

/**
 table事件处理管理类;事件处理的统一入口，一般需要子类化一个
 */
@interface HCTableViewEventHandler : NSObject <HCTableViewEventDelegate>

@property (nonatomic, weak) UIView *responder; // 弱引用，一般是tableView，目的是当事件需要在下一级响应链处理的时候就传递下去
@property (nonatomic, weak) HCTableViewDataSource *tableDataSource; // tableView的数据源，弱引用，用于在事件处理的时候有的需要操作数据源

@end

NS_ASSUME_NONNULL_END
