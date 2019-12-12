//
//  HCTestTwoCell.m
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/10.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import "HCTestTwoCell.h"
#import "HCTestTwoCellVM.h"

@interface HCTestTwoCell ()

@property (nonatomic, strong) UIImageView *adImageView;

@end

@implementation HCTestTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self loadSubviews];
    }
    
    return self;
}

- (void)fillData:(HCTestTwoCellVM *)model {
    self.adImageView.backgroundColor = model.backgroundColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.adImageView.frame = self.contentView.bounds;
}

#pragma mark - Private Method

- (void)loadSubviews {
    [self.contentView addSubview:self.adImageView];
}

#pragma mark - Getter && Setter

- (UIImageView *)adImageView {
    if (_adImageView == nil) {
        _adImageView = [UIImageView new];
    }
    
    return _adImageView;
}

@end
