//
//  HCTableViewDataSource.h
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/10.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCTableViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HCTableViewDataSourceChangeDelegate;

/**
 table数据管理类
 */
@interface HCTableViewDataSource : NSObject

@property (nonatomic, strong) NSMutableArray<id<HCTableViewSectionProtocol>> *dataSource;
@property (nonatomic, weak) id<HCTableViewDataSourceChangeDelegate> delegate;

#pragma mark - Section Data

- (void)addSectionData:(id<HCTableViewSectionProtocol>)sectionData;
- (void)removeSectionData:(id<HCTableViewSectionProtocol>)sectionData;
- (void)insertSectionData:(id<HCTableViewSectionProtocol>)sectionData atIndex:(NSInteger)section;
- (void)removeSectionAtIndex:(NSInteger)section;

#pragma mark - Row Data

- (void)insertRowData:(id<HCTableViewRowProtocol>)rowData atIndexPath:(NSIndexPath *)indexPath;
- (void)removeRowDataAtIndexPath:(NSIndexPath *)indexPath;

@end

// 数据变化更新UI的代理；这里如果使用rac的话直接写一个RACSubject就好。
@protocol HCTableViewDataSourceChangeDelegate <NSObject>

/**
 数据源发生变化：一般是需要reloadData

 @param dataSource 数据源
 */
- (void)didChangeDataSource:(HCTableViewDataSource *)dataSource;

/**
 数据源发生变化：一般是需要reloadSections

 @param dataSource 数据源
 @param sections 变化的sections
 */
- (void)dataSource:(HCTableViewDataSource *)dataSource didChangeAtSections:(NSIndexSet *)sections withAnimation:(UITableViewRowAnimation)animation;

/**
 数据源发生变化：一般是需要reloadRows

 @param dataSource 数据源
 @param indexPaths 变化的行
 */
- (void)dataSource:(HCTableViewDataSource *)dataSource didChangeAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withAnimation:(UITableViewRowAnimation)animation;

@end

NS_ASSUME_NONNULL_END
