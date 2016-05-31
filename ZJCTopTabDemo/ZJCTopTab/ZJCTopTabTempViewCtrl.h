//
//  TopTabTempViewCtrl.h
//  SFAforMWCCS
//
//  Created by zhangjiacheng on 14-10-29.
//  Copyright (c) 2014年 zhangjiacheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJCTabName_View_Data;
/**
 TopTabTempViewCtrl is a view ctrl with a custom segment on the top and several views added to the "contenvView" view, opationally with a search bar below the custom segment
 
 Custom Controller of ZJCTopTabTempViewCtrl might  overide the following two methods
 1 - (void)addTheViewsToContentView:(NSArray *)views
 2 - (void)topTabViewClickAtIndex:(int)index
 */
@interface ZJCTopTabTempViewCtrl : UIViewController<UIGestureRecognizerDelegate>

@property (nonatomic, assign) int currentIndex;//the current selected index of the top tab
@property (nonatomic, strong) NSArray<ZJCTabName_View_Data *> *name_view_data_Array;

/**
 the designed constructor for the TopTabTempViewCtrl, custom subclass of the TopTabTempViewCtrl should use this constructor to in his own custom consctructor method. 
mpViewCtrl
 */
- (id)initWithNameViewDataArray:(NSArray<ZJCTabName_View_Data *> *)array;

/*
 * when the index tab selelectd, this method revoke.
 */
- (void)topTabViewClickAtIndex:(int)index;

/**
 add the subviews to the contentView
 */
- (void)addTheViewsToContentView:(NSArray *)views;

/*
 *set top tab bar titles
 */
- (void)setTopTabNames:(NSArray *)names;


@end
