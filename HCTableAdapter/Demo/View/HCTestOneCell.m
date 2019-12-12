//
//  HCTestOneCell.m
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/10.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import "HCTestOneCell.h"
#import "HCTestOneCellVM.h"

@interface HCTestOneCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation HCTestOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self loadSubviews];
    }
    
    return self;
}

- (void)fillData:(HCTestOneCellVM *)model {
    self.titleLabel.text = model.titleText;
    self.contentLabel.text = model.contentText;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat padding = 10;
    self.titleLabel.frame = CGRectMake(padding, padding, self.contentView.frame.size.width - padding * 2, 18);
    self.contentLabel.frame = CGRectMake(padding, CGRectGetMaxY(self.titleLabel.frame) + 5, self.contentView.frame.size.width - padding * 2, 15);
}

#pragma mark - Private Method

- (void)loadSubviews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
}

#pragma mark - Getter && Setter

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = [UIColor lightGrayColor];
        _contentLabel.font = [UIFont systemFontOfSize:12];
    }
    
    return _contentLabel;
}

@end
