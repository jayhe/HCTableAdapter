//
//  HCDemoTableViewAdapter.m
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/11.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import "HCDemoTableViewAdapter.h"
#import "HCDemoTableViewEvent.h"

@implementation HCDemoTableViewAdapter
/*
 HCTableViewAdapter基础类中实现了一些通用的逻辑实现；如果需要处理其他的代理方法，子类化一个，在其中实现逻辑即可
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.eventHandler) {
        HCDemoTableViewEvent *event = [HCDemoTableViewEvent new];
        event.eventType = HCDemoTableViewEventTypeClickCell;
        event.eventData = indexPath;
        [self.eventHandler onCatchEvent:event];
    }
}

@end
