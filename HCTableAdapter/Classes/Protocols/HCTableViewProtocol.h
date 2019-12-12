//
//  HCTableViewProtocol.h
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/10.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HCTableViewRowProtocol, HCTableViewCellDataProtocol;

@protocol HCTableViewSectionProtocol <NSObject>
@required

/**
 section的行数

 @return 行数
 */
- (NSInteger)rowCount;

/**
 header的高度

 @return CGFloat default：CGFLOAT_MIN
 */
- (CGFloat)headerViewHeight;
/**
 footer的高度
 
 @return CGFloat default：CGFLOAT_MIN
 */
- (CGFloat)footerViewHeight;

/**
 返回当前section需要展示的header的class
 
 @return Class
 */
- (nullable Class)headerViewClass;

/**
 返回当前section需要展示的footer的class
 
 @return Class
 */
- (nullable Class)footerViewClass;

- (NSMutableArray<id<HCTableViewRowProtocol>> *)rowDataSource;

- (id<HCTableViewRowProtocol>)rowDataAtIndex:(NSInteger)indexPathRow;

@end

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

NS_ASSUME_NONNULL_END
