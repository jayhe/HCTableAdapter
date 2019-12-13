//
//  HCTableViewAdapter.m
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/10.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import "HCTableViewAdapter.h"
#import "UITableViewCell+HCEventDelegate.h"
#import "UITableViewHeaderFooterView+HCEventDelegate.h"

@interface HCTableViewAdapter () <UITableViewDelegate, UITableViewDataSource, HCTableViewDataSourceChangeDelegate>

@property (nonatomic, strong) HCTableViewDataSource *tableDataSource;
@property (nonatomic, strong) HCTableViewEventHandler *eventHandler;

@end

@implementation HCTableViewAdapter

- (instancetype)initWithTableDataSource:(HCTableViewDataSource *)tableDataSource tableView:(UITableView *)tableView {
    return [self initWithTableDataSource:tableDataSource tableView:tableView eventHandler:nil];
}

- (instancetype)initWithTableDataSource:(HCTableViewDataSource *)tableDataSource tableView:(UITableView *)tableView eventHandler:(HCTableViewEventHandler *)eventHandler {
    self = [super init];
    if (self) {
        _tableDataSource = tableDataSource;
        _tableDataSource.delegate = self;
        _tableView = tableView;
        _eventHandler = eventHandler;
        _eventHandler.responder = tableView;
        _eventHandler.tableDataSource = tableDataSource;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return self;
}

#pragma mark - Custom Method

- (void)reloadWithDataSource:(HCTableViewDataSource *)dataSource {
    self.tableDataSource = dataSource;
    [self.tableView reloadData];
}

#pragma mark - HCTableViewDataSourceChangeDelegate
- (void)didChangeDataSource:(HCTableViewDataSource *)dataSource {
    [self reloadWithDataSource:dataSource];
}
- (void)dataSource:(HCTableViewDataSource *)dataSource didChangeAtIndexPaths:(nonnull NSArray<NSIndexPath *> *)indexPaths withAnimation:(UITableViewRowAnimation)animation {
    if (indexPaths) {
        self.tableDataSource = dataSource;
        [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    }
}

- (void)dataSource:(HCTableViewDataSource *)dataSource didChangeAtSections:(NSIndexSet *)sections withAnimation:(UITableViewRowAnimation)animation {
    if (sections) {
        self.tableDataSource = dataSource;
        [self.tableView reloadSections:sections withRowAnimation:animation];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableDataSource.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<HCTableViewSectionProtocol>sectionData = [self.tableDataSource.dataSource objectAtIndex:section];
    if ([sectionData conformsToProtocol:@protocol(HCTableViewSectionProtocol)] && [sectionData respondsToSelector:@selector(rowCount)]) {
        return [sectionData rowCount];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<HCTableViewSectionProtocol>sectionData = [self.tableDataSource.dataSource objectAtIndex:indexPath.section];
    if ([sectionData conformsToProtocol:@protocol(HCTableViewSectionProtocol)] && [sectionData respondsToSelector:@selector(rowDataAtIndex:)]) {
        id<HCTableViewRowProtocol>rowData = [sectionData rowDataAtIndex:indexPath.row];
        Class tableViewCellClass;
        if ([rowData conformsToProtocol:@protocol(HCTableViewRowProtocol)] && [rowData respondsToSelector:@selector(cellClass)]) {
            tableViewCellClass = [rowData cellClass];
        }
        if (tableViewCellClass) {
            NSString *cellID = NSStringFromClass(tableViewCellClass);
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                [tableView registerClass:tableViewCellClass forCellReuseIdentifier:cellID];
                cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            }
            cell.eventDelegate = self.eventHandler;
            // fill data
            if ([cell conformsToProtocol:@protocol(HCTableViewCellDataProtocol)] && [cell respondsToSelector:@selector(fillData:)]) {
                [(id<HCTableViewCellDataProtocol>)cell fillData:rowData];
            }
            
            return cell;
        }
    }
    
    return [UITableViewCell new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id<HCTableViewSectionProtocol>sectionData = [self.tableDataSource.dataSource objectAtIndex:section];
    Class headerClass;
    if ([sectionData conformsToProtocol:@protocol(HCTableViewSectionProtocol)] && [sectionData respondsToSelector:@selector(headerViewClass)]) {
        headerClass = [sectionData headerViewClass];
    }
    if (headerClass) {
        NSString *headerViewId = NSStringFromClass(headerClass);
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewId];
        if (headerView == nil) {
            [tableView registerClass:headerClass forHeaderFooterViewReuseIdentifier:headerViewId];
            headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewId];
        }
        headerView.eventDelegate = self.eventHandler;
        // fill data
        if ([headerView conformsToProtocol:@protocol(HCTableViewHeaderDataProtocol)] && [headerView respondsToSelector:@selector(fillData:)]) {
            [((id<HCTableViewHeaderDataProtocol>)headerView) fillData:sectionData];
        }
        return headerView;
    } else {
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    id<HCTableViewSectionProtocol>sectionData = [self.tableDataSource.dataSource objectAtIndex:section];
    Class footerClass;
    if ([sectionData conformsToProtocol:@protocol(HCTableViewSectionProtocol)] && [sectionData respondsToSelector:@selector(footerViewClass)]) {
        footerClass = [sectionData footerViewClass];
    }
    if (footerClass) {
        NSString *footerViewId = NSStringFromClass(footerClass);
        UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerViewId];
        if (footerView == nil) {
            [tableView registerClass:footerClass forHeaderFooterViewReuseIdentifier:footerViewId];
            footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerViewId];
        }
        footerView.eventDelegate = self.eventHandler;
        // fill data
        if ([footerView conformsToProtocol:@protocol(HCTableViewHeaderDataProtocol)] && [footerView respondsToSelector:@selector(fillData:)]) {
            [((id<HCTableViewHeaderDataProtocol>)footerView) fillData:sectionData];
        }
        return footerView;
    } else {
        return nil;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<HCTableViewSectionProtocol>sectionData = [self.tableDataSource.dataSource objectAtIndex:indexPath.section];
    if ([sectionData conformsToProtocol:@protocol(HCTableViewSectionProtocol)] && [sectionData respondsToSelector:@selector(rowDataAtIndex:)]) {
        id<HCTableViewRowProtocol>rowData = [sectionData rowDataAtIndex:indexPath.row];
        if ([rowData conformsToProtocol:@protocol(HCTableViewRowProtocol)] && [rowData respondsToSelector:@selector(rowHeight)]) {
            return [rowData rowHeight];
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    id<HCTableViewSectionProtocol>sectionData = [self.tableDataSource.dataSource objectAtIndex:section];
    if ([sectionData conformsToProtocol:@protocol(HCTableViewSectionProtocol)] && [sectionData respondsToSelector:@selector(footerViewHeight)]) {
        return sectionData.footerViewHeight;
    } else {
        return CGFLOAT_MIN;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    id<HCTableViewSectionProtocol>sectionData = [self.tableDataSource.dataSource objectAtIndex:section];
    if ([sectionData conformsToProtocol:@protocol(HCTableViewSectionProtocol)] && [sectionData respondsToSelector:@selector(headerViewHeight)]) {
        return sectionData.headerViewHeight;
    } else {
        return CGFLOAT_MIN;
    }
}

#pragma mark - Private Method

@end
