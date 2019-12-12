//
//  HCTableViewDataSource.m
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/10.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import "HCTableViewDataSource.h"

@implementation HCTableViewDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        _dataSource = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark - Section Data

- (void)insertSectionData:(id<HCTableViewSectionProtocol>)sectionData atIndex:(NSInteger)section {
    if (sectionData && section < self.dataSource.count) {
        [self.dataSource insertObject:sectionData atIndex:section];
    }
}

- (void)addSectionData:(id<HCTableViewSectionProtocol>)sectionData {
    if (sectionData) {
        [self.dataSource addObject:sectionData];
    }
}

- (void)removeSectionData:(id<HCTableViewSectionProtocol>)sectionData {
    [self.dataSource removeObject:sectionData];
}

- (void)removeSectionAtIndex:(NSInteger)section {
    if (section < self.dataSource.count) {
        [self.dataSource removeObjectAtIndex:section];
    }
}

#pragma mark - Row Data

- (void)insertRowData:(id<HCTableViewRowProtocol>)rowData atIndexPath:(NSIndexPath *)indexPath {
    id<HCTableViewSectionProtocol> sectionData = [self.dataSource objectAtIndex:indexPath.section];
    NSMutableArray *rowDatas = [sectionData rowDataSource];
    if (rowDatas) {
        [rowDatas insertObject:rowData atIndex:indexPath.row];
    }
}

- (void)removeRowDataAtIndexPath:(NSIndexPath *)indexPath {
    id<HCTableViewSectionProtocol> sectionData = [self.dataSource objectAtIndex:indexPath.section];
    NSMutableArray *rowDatas = [sectionData rowDataSource];
    if (rowDatas) {
        [rowDatas removeObjectAtIndex:indexPath.row];
    }
}

@end
