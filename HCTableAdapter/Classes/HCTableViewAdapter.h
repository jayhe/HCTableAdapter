//
//  HCTableViewAdapter.h
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/10.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HCTableViewDataSource.h"
#import "HCTableViewEventHandler.h"

NS_ASSUME_NONNULL_BEGIN

/**
 table管理类
 */
@interface HCTableViewAdapter : NSObject

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, readonly, strong) HCTableViewEventHandler *eventHandler;
@property (nonatomic, readonly, strong) HCTableViewDataSource *tableDataSource;

- (instancetype)initWithTableDataSource:(HCTableViewDataSource *)tableDataSource tableView:(UITableView *)tableView;
- (instancetype)initWithTableDataSource:(HCTableViewDataSource *)tableDataSource tableView:(UITableView *)tableView eventHandler:(nullable HCTableViewEventHandler *)eventHandler;

- (void)reloadWithDataSource:(HCTableViewDataSource *)dataSource;

@end

NS_ASSUME_NONNULL_END
