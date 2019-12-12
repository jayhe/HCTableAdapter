//
//  HCDemoTableViewEventHandler.m
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/11.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import "HCDemoTableViewEventHandler.h"
#import "HCDemoTableViewEvent.h"
#import "HCTestSectionVM.h"

@implementation HCDemoTableViewEventHandler

- (void)onCatchEvent:(id<HCTableViewEventDataProtocol>)event {
    switch (event.eventType) {
//        case HCDemoTableViewEventTypeClickCell: {
//
//        }
//            break;
        case HCDemoTableViewEventTypeClickFoldUnfoldHeader: {
            if ([event.eventData isKindOfClass:[HCTestSectionVM class]]) {
                HCTestSectionVM *sectionVM = (HCTestSectionVM *)event.eventData;
                sectionVM.isFold = !sectionVM.isFold;
                if (self.tableDataSource.delegate && [self.tableDataSource.delegate respondsToSelector:@selector(dataSource:didChangeAtIndexPath:)]) {
                    [self.tableDataSource.delegate dataSource:self.tableDataSource didChangeAtIndexPath:nil];
                }
            }
        }
            break;
        default: {
            // 将时间传递下去，顺着响应链找到处理该事件的【比如有些逻辑放到控制器的就让控制器实现这个协议，则EventHandler处理不了的事件就会传递过去】
            UIResponder *nextResponder = self.responder.nextResponder;
            while (nextResponder) {
                if ([nextResponder conformsToProtocol:@protocol(HCTableViewEventDelegate)] && [nextResponder respondsToSelector:@selector(onCatchEvent:)]) {
                    [((id<HCTableViewEventDelegate>)nextResponder) onCatchEvent:event];
                    break;
                }
                nextResponder = nextResponder.nextResponder;
            }
        }
            break;
    }
}

@end
