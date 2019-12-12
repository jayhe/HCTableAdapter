//
//  HCTestOneCellVM.m
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/10.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import "HCTestOneCellVM.h"
#import "HCTestOneCell.h"

@implementation HCTestOneCellVM

#pragma mark - HCTableViewRowProtocol

- (Class)cellClass {
    return [HCTestOneCell class];
}

- (CGFloat)rowHeight {
    return 55;
}

@end
