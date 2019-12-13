//
//  HCTestSectionVM.h
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/10.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCTableViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HCTestSectionVM : NSObject <HCTableViewSectionProtocol>

@property (nonatomic, assign) BOOL isFold; // 是否折叠默认为NO：展开
@property (nonatomic, copy) NSString *foldUnfoldButtonTitle;
@property (nonatomic, assign) NSInteger section;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
