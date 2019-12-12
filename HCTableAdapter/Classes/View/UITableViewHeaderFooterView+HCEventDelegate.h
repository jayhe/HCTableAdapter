//
//  UITableViewHeaderFooterView+HCEventDelegate.h
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/11.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCTableViewEventDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewHeaderFooterView (HCEventDelegate)

@property (nonatomic, weak) id<HCTableViewEventDelegate> eventDelegate;

@end

NS_ASSUME_NONNULL_END
