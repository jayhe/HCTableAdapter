//
//  HCTestSectionHeaderView.m
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/10.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import "HCTestSectionHeaderView.h"
#import "UITableViewHeaderFooterView+HCEventDelegate.h"
#import "HCDemoTableViewEvent.h"
#import "HCTestSectionVM.h"

@interface HCTestSectionHeaderView ()

@property (nonatomic, strong) UIButton *foldUnfoldButton;
@property (nonatomic, strong) HCTestSectionVM *sectionVM;

@end

@implementation HCTestSectionHeaderView

- (instancetype)initWithReuseIdentifier:reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadSubviews];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.foldUnfoldButton.frame = self.contentView.bounds;
}

- (void)fillData:(HCTestSectionVM *)model {
    _sectionVM = model;
    
    self.foldUnfoldButton.selected = model.isFold;
    [self.foldUnfoldButton setTitle:model.foldUnfoldButtonTitle forState:UIControlStateNormal];
}

#pragma mark - Action

- (void)foldUnfoldButtonAction:(UIButton *)sender {
    if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(onCatchEvent:)]) {
        HCDemoTableViewEvent *event = [HCDemoTableViewEvent new];
        event.eventType = HCDemoTableViewEventTypeClickFoldUnfoldHeader;
        event.eventData = self.sectionVM;
        [self.eventDelegate onCatchEvent:event];
    }
}

#pragma mark - Private Method

- (void)loadSubviews {
    self.contentView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.foldUnfoldButton];
}

#pragma mark - Getter && Setter

- (UIButton *)foldUnfoldButton {
    if (_foldUnfoldButton == nil) {
        _foldUnfoldButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_foldUnfoldButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_foldUnfoldButton addTarget:self action:@selector(foldUnfoldButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _foldUnfoldButton;
}

@end
