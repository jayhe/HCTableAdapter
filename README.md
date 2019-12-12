## HCTableAdapter
> 将table view的逻辑和代码迁移到适配管理器中，从而减少viewController的代码量
### 1.关键类说明
#### HCTableViewAdapter
> tableView的管理类，内部整合table的delegate和dataSource；将table的通用的逻辑都整理出来，不需要每个控制器都写一堆tableview的代理或者数据源的方法；同时内部将header、footer、cell的事件代理都进行统一的封装，并在内部进行代理的绑定，一些事件的处理统一会转发给`HCTableViewEventHandler`去处理

```objc
@interface HCTableViewAdapter : NSObject

@property (nonatomic, weak) UITableView *tableView; // 界面展示的tableview，由VC持有
@property (nonatomic, readonly, strong) HCTableViewEventHandler *eventHandler; // table事件的处理
@property (nonatomic, readonly, strong) HCTableViewDataSource *tableDataSource; // table的数据源

- (instancetype)initWithTableDataSource:(HCTableViewDataSource *)tableDataSource tableView:(UITableView *)tableView;
- (instancetype)initWithTableDataSource:(HCTableViewDataSource *)tableDataSource tableView:(UITableView *)tableView eventHandler:(nullable HCTableViewEventHandler *)eventHandler;

- (void)reloadWithDataSource:(HCTableViewDataSource *)dataSource; // 触发table的reloadData

@end
```

#### HCTableViewEventHandler
> table事件处理管理类;事件处理的统一入口，一般需要子类化一个，然后实现协议`HCTableViewEventDelegate`的`- (void)onCatchEvent:(id<HCTableViewEventDataProtocol>)event`方法，在这里处理各种事件；这里将事件抽象成了遵循协议`HCTableViewEventDataProtocol`对象，达到入口统一

```objc
@protocol HCTableViewEventDataProtocol <NSObject>
@required
/**
 事件的类型

 @return 一般定义一个枚举
 */
- (NSInteger)eventType;

@optional
/**
 事件回传的参数，事件有数据传递的时候需要

 @return 数据
 */
- (nullable id)eventData;

@end
```

#### HCTableViewDataSource
> table的数据管理类，table内部的cell展示，行高、展示哪种cell等等都是由数据源去控制；

这里定义了2个数据结构，一个是section、一个是row；都是通过协议，我们建立的数据源模型遵循对应的协议即可；例如cell，协议定义了行高和cell展示的类。我们的数据源对象遵循这个协议，在adapter的内部会读取数据源的对应协议的值，进行table的UI的展示逻辑

```objc
@protocol HCTableViewRowProtocol <NSObject>
@required
/**
 行高
 
 @return CGFloat default：CGFLOAT_MIN
 */
- (CGFloat)rowHeight;

/**
 返回当前行需要展示的cell的class

 @return Class
 */
- (Class)cellClass;

@end
```

> cell或者header、footer的数据是如何绑定了？也是通过协议，只要cell实现了协议，在adapter内部就会调用协议方法进行数据绑定的调用

协议定义如下：
```objc
@protocol HCTableViewCellDataProtocol <NSObject>
@required
- (void)fillData:(NSObject *)model;

@end

@protocol HCTableViewHeaderDataProtocol <NSObject>
@required
- (void)fillData:(NSObject *)model;

@end

@protocol HCTableViewFooterDataProtocol <NSObject>
@required
- (void)fillData:(NSObject *)model;

@end
```
adapter内部处理：
```objc
// fill data
            if ([cell conformsToProtocol:@protocol(HCTableViewCellDataProtocol)] && [cell respondsToSelector:@selector(fillData:)]) {
                [(id<HCTableViewCellDataProtocol>)cell fillData:rowData];
            }
```

#### 事件绑定
> 为UITableViewCell和UITableViewHeaderFooterView实现了个类别，类别中增加一个代理`id<HCTableViewEventDelegate> eventDelegate;`，然后在adapter中将cell或者header、footer的事件统一代理给`HCTableViewEventHandler`

```objc
cell.eventDelegate = self.eventHandler;
```

### 2.集成
> pod 'HCTableAdapter', :git => 'https://github.com/jayhe/HCTableAdapter.git'

### 3.使用示例
具体代码可以参照demo中的实现

#### UI展示
> UI的展示是按照section来创建dateSource，可以理解dataSource为一个二维数组，外层的个数代表有多少个section、内层的个数代表每个section的行数

1. 创建数据源section以及row分别实现section和row的协议；eg：
* Section的定义 @interface HCTestSectionVM : NSObject <HCTableViewSectionProtocol>
* Row的定义 @interface HCTestOneCellVM : NSObject <HCTableViewRowProtocol>
  有多少种样式的cell定义多少种cell的数据模型

2. 在vc内部将数据进行绑定
```objc
- (void)bindData {
    HCTableViewDataSource *dataSource = [[HCTableViewDataSource alloc] init];
    [dataSource.dataSource addObject:[[HCTestSectionVM alloc] initWithDict:@{}]];
    [dataSource.dataSource addObject:[[HCTestSectionVM alloc] initWithDict:@{}]];
    // 有事件处理的就子类化一个eventHandler，没有的话就不需要
    HCDemoTableViewEventHandler *eventHandler = [[HCDemoTableViewEventHandler alloc] init];
    self.tableAdapter = [[HCDemoTableViewAdapter alloc] initWithTableDataSource:dataSource tableView:self.testTableView eventHandler:eventHandler];
}
```
3. adapter内部读取数据源信息，渲染UI
```objc

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableDataSource.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<HCTableViewSectionProtocol>sectionData = [self.tableDataSource.dataSource objectAtIndex:section];
    if ([sectionData conformsToProtocol:@protocol(HCTableViewSectionProtocol)] && [sectionData respondsToSelector:@selector(rowCount)]) {
        return [sectionData rowCount];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<HCTableViewSectionProtocol>sectionData = [self.tableDataSource.dataSource objectAtIndex:indexPath.section];
    if ([sectionData conformsToProtocol:@protocol(HCTableViewSectionProtocol)] && [sectionData respondsToSelector:@selector(rowDataAtIndex:)]) {
        id<HCTableViewRowProtocol>rowData = [sectionData rowDataAtIndex:indexPath.row];
        Class tableViewCellClass;
        if ([rowData conformsToProtocol:@protocol(HCTableViewRowProtocol)] && [rowData respondsToSelector:@selector(cellClass)]) {
            tableViewCellClass = [rowData cellClass];
        }
        if (tableViewCellClass) {
            NSString *cellID = NSStringFromClass(tableViewCellClass);
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                [tableView registerClass:tableViewCellClass forCellReuseIdentifier:cellID];
                cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            }
            cell.eventDelegate = self.eventHandler;
            // fill data
            if ([cell conformsToProtocol:@protocol(HCTableViewCellDataProtocol)] && [cell respondsToSelector:@selector(fillData:)]) {
                [(id<HCTableViewCellDataProtocol>)cell fillData:rowData];
            }
            
            return cell;
        }
    }
    
    return [UITableViewCell new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id<HCTableViewSectionProtocol>sectionData = [self.tableDataSource.dataSource objectAtIndex:section];
    Class headerClass;
    if ([sectionData conformsToProtocol:@protocol(HCTableViewSectionProtocol)] && [sectionData respondsToSelector:@selector(headerViewClass)]) {
        headerClass = [sectionData headerViewClass];
    }
    if (headerClass) {
        NSString *headerViewId = NSStringFromClass(headerClass);
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewId];
        if (headerView == nil) {
            [tableView registerClass:headerClass forHeaderFooterViewReuseIdentifier:headerViewId];
            headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewId];
        }
        headerView.eventDelegate = self.eventHandler;
        // fill data
        if ([headerView conformsToProtocol:@protocol(HCTableViewHeaderDataProtocol)] && [headerView respondsToSelector:@selector(fillData:)]) {
            [((id<HCTableViewHeaderDataProtocol>)headerView) fillData:sectionData];
        }
        return headerView;
    } else {
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    id<HCTableViewSectionProtocol>sectionData = [self.tableDataSource.dataSource objectAtIndex:section];
    Class footerClass;
    if ([sectionData conformsToProtocol:@protocol(HCTableViewSectionProtocol)] && [sectionData respondsToSelector:@selector(footerViewClass)]) {
        footerClass = [sectionData footerViewClass];
    }
    if (footerClass) {
        NSString *footerViewId = NSStringFromClass(footerClass);
        UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerViewId];
        if (footerView == nil) {
            [tableView registerClass:footerClass forHeaderFooterViewReuseIdentifier:footerViewId];
            footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerViewId];
        }
        footerView.eventDelegate = self.eventHandler;
        // fill data
        if ([footerView conformsToProtocol:@protocol(HCTableViewHeaderDataProtocol)] && [footerView respondsToSelector:@selector(fillData:)]) {
            [((id<HCTableViewHeaderDataProtocol>)footerView) fillData:sectionData];
        }
        return footerView;
    } else {
        return nil;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<HCTableViewSectionProtocol>sectionData = [self.tableDataSource.dataSource objectAtIndex:indexPath.section];
    if ([sectionData conformsToProtocol:@protocol(HCTableViewSectionProtocol)] && [sectionData respondsToSelector:@selector(rowDataAtIndex:)]) {
        id<HCTableViewRowProtocol>rowData = [sectionData rowDataAtIndex:indexPath.row];
        if ([rowData conformsToProtocol:@protocol(HCTableViewRowProtocol)] && [rowData respondsToSelector:@selector(rowHeight)]) {
            return [rowData rowHeight];
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    id<HCTableViewSectionProtocol>sectionData = [self.tableDataSource.dataSource objectAtIndex:section];
    if ([sectionData conformsToProtocol:@protocol(HCTableViewSectionProtocol)] && [sectionData respondsToSelector:@selector(footerViewHeight)]) {
        return sectionData.footerViewHeight;
    } else {
        return CGFLOAT_MIN;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    id<HCTableViewSectionProtocol>sectionData = [self.tableDataSource.dataSource objectAtIndex:section];
    if ([sectionData conformsToProtocol:@protocol(HCTableViewSectionProtocol)] && [sectionData respondsToSelector:@selector(headerViewHeight)]) {
        return sectionData.headerViewHeight;
    } else {
        return CGFLOAT_MIN;
    }
}
```

#### 事件处理
> 子类化`HCTableViewEventHandler`实现方法`- (void)onCatchEvent:(id<HCTableViewEventDataProtocol>)event`，根据不同的事件类型做不同的逻辑处理
如果有些事件需要回传到vc中处理，可以让vc遵循`HCTableViewEventDelegate`协议，然后顺着响应链将事件传递给vc去处理

```objc
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
            dispatch_async(dispatch_get_main_queue(), ^{
                UIResponder *nextResponder = self.responder.nextResponder;
                while (nextResponder) {
                    if ([nextResponder conformsToProtocol:@protocol(HCTableViewEventDelegate)] && [nextResponder respondsToSelector:@selector(onCatchEvent:)]) {
                        [((id<HCTableViewEventDelegate>)nextResponder) onCatchEvent:event];
                        break;
                    }
                    nextResponder = nextResponder.nextResponder;
                }
            });
        }
            break;
    }
}

@end

```


