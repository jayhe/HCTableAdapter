//
//  HCTestTwoCellVM.h
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/10.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCTableViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HCTestTwoCellVM : NSObject <HCTableViewRowProtocol>

//@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, strong) UIColor *backgroundColor; // 测试设置一个颜色

@end

NS_ASSUME_NONNULL_END
