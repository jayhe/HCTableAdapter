//
//  HCTestSectionVM.m
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/10.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import "HCTestSectionVM.h"
#import "HCTestSectionHeaderView.h"
#import "HCTestOneCellVM.h"
#import "HCTestTwoCellVM.h"

@interface HCTestSectionVM ()

@property (nonatomic, strong) NSMutableArray<id<HCTableViewRowProtocol>> *sectionData;

@end

@implementation HCTestSectionVM

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.sectionData = [NSMutableArray array];
        self.isFold = NO;
        [self configData];
    }
    
    return self;
}

#pragma mark - HCTableViewSectionProtocol

- (CGFloat)headerViewHeight {
    return 40;
}

- (CGFloat)footerViewHeight {
    return CGFLOAT_MIN;
}

- (Class)headerViewClass {
    return [HCTestSectionHeaderView class];
}

- (Class)footerViewClass {
    return nil;
}

- (NSInteger)rowCount {
    // 展开收起，对数据源进行处理
    return !self.isFold ? self.sectionData.count : 0;
}

- (NSMutableArray<id<HCTableViewRowProtocol>> *)rowDataSource {
    return self.sectionData;
}

- (nonnull id<HCTableViewRowProtocol>)rowDataAtIndex:(NSInteger)indexPathRow {
    return indexPathRow < self.sectionData.count ? [self.sectionData objectAtIndex:indexPathRow] : nil;
}

#pragma mark - Private Method

- (void)configData {
    // test
    HCTestOneCellVM *cellOneVM = [HCTestOneCellVM new];
    cellOneVM.titleText = @"Cell One";
    cellOneVM.contentText = @"Cell One的测试内容";
    [self.sectionData addObject:cellOneVM];
    HCTestOneCellVM *cellOneVM1 = [HCTestOneCellVM new];
    cellOneVM1.titleText = @"Cell Tow";
    cellOneVM1.contentText = @"Cell Tow的测试内容Cell Tow的测试内容Cell Tow的测试内容Cell Tow的测试内容Cell Tow的测试内容Cell Tow的测试内容Cell Tow的测试内容";
    [self.sectionData addObject:cellOneVM1];
    HCTestTwoCellVM *cellTwoVM = [HCTestTwoCellVM new];
    cellTwoVM.backgroundColor = [UIColor purpleColor];
    [self.sectionData addObject:cellTwoVM];
    HCTestTwoCellVM *cellTwoVM1 = [HCTestTwoCellVM new];
    cellTwoVM1.backgroundColor = [UIColor brownColor];
    [self.sectionData addObject:cellTwoVM1];
}

- (void)configDataWhenFoldStatusChanged {
    if (!self.isFold) {
        self.foldUnfoldButtonTitle = @">收起<";
    } else {
        self.foldUnfoldButtonTitle = @"～展开～";
    }
}

#pragma mark - Getter && Setter

- (void)setIsFold:(BOOL)isFold {
    _isFold = isFold;
    [self configDataWhenFoldStatusChanged];
}

@end
