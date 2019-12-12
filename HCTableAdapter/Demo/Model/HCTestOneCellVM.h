//
//  HCTestOneCellVM.h
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/10.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCTableViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HCTestOneCellVM : NSObject <HCTableViewRowProtocol>

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *contentText;

@end

NS_ASSUME_NONNULL_END
