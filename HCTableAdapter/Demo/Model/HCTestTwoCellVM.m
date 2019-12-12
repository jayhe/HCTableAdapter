//
//  HCTestTwoCellVM.m
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/10.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import "HCTestTwoCellVM.h"
#import "HCTestTwoCell.h"

@implementation HCTestTwoCellVM

- (Class)cellClass {
    return [HCTestTwoCell class];
}

- (CGFloat)rowHeight {
    return 56;
}

@end
