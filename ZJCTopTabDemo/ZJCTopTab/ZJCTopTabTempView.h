//
//  TopTabTempView.h
//  MWCCS
//
//  Created by zhangjiacheng on 13-8-15.
//  Copyright (c) 2013年 zhangjiacheng. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * The Top Tab View
 */
@interface ZJCTopTabTempView : UIView


@property (nonatomic, strong) NSArray *tabItemNames;//topTap的栏目名字
@property (nonatomic, assign) int currentIndex;
@property (nonatomic, strong) NSArray<NSNumber *> *tabWidths;


- (int)indexOfPointInTabTempView:(CGFloat)x1;
- (void)setCurrentIndex:(int)index;

- (void)flashTheScrollbar;

- (void)setTabItemNames:(NSArray *)itemNames;
- (id)initWithFrame:(CGRect)frame itemNames:(NSArray *)itemNames tintColor:(UIColor *)tintColor hilightColor:(UIColor *)hilightColor;

@end
