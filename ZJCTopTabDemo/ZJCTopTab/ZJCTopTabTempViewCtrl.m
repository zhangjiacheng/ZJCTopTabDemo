//
//  TopTabTempViewCtrl.m
//  zhangjiacheng
//
//  Created by zhangjiacheng on 14-10-29.
//  Copyright (c) 2014年 zhangjiacheng. All rights reserved.
//

#import "ZJCTopTabTempViewCtrl.h"
#import "ZJCTopTabTempView.h"
#import "ZJCTabName_View_Data.h"

@interface ZJCTopTabTempViewCtrl ()
{
    BOOL tabScrolling;// the top tab had been taped and now is scrolling
}

@property (nonatomic,weak) ZJCTopTabTempView *topTabTempView;
@property (nonatomic,weak) UIView *contenView;

@property (nonatomic, strong) UISwipeGestureRecognizer *recognizer1;
@property (nonatomic, strong) UISwipeGestureRecognizer *recognizer2;


@end

@implementation ZJCTopTabTempViewCtrl

- (id)initWithNameViewDataArray:(NSArray<ZJCTabName_View_Data *> *)array{
    self = [super init];
    if (self) {

        tabScrolling = NO;
        self.name_view_data_Array = array;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentIndex = 0;


    CGSize viewSize = self.view.bounds.size;
    float minusHeight = 0;
    float addY = 0;
    if (self.navigationController!=nil) {
        if (self.navigationController.navigationBarHidden == NO) {
            minusHeight += CGRectGetHeight(self.navigationController.navigationBar.frame);
            addY = minusHeight;
        }
        if (self.navigationController.toolbarHidden == NO) {
            minusHeight += CGRectGetHeight(self.navigationController.navigationBar.frame);
        }
    }
    
    
    NSMutableArray *names = [[NSMutableArray alloc] init];
    for (ZJCTabName_View_Data *data in self.name_view_data_Array) {
        [names addObject:data.tabItemName];
    }

    ///////////////////////////////////////////////////////////
    ZJCTopTabTempView *tv = [[ZJCTopTabTempView alloc] initWithFrame:CGRectMake(5, 5+20+addY, viewSize.width-10, 40) itemNames:names tintColor:[UIColor blueColor] hilightColor:[UIColor whiteColor]];
    tv.autoresizingMask = (UIViewAutoresizingFlexibleWidth|
                        UIViewAutoresizingFlexibleLeftMargin|
                        UIViewAutoresizingFlexibleRightMargin|
                        UIViewAutoresizingFlexibleBottomMargin);
    tv.currentIndex = self.currentIndex;
    self.topTabTempView = tv;

    [self.view addSubview:tv];
    
    float totalWidth = 0;
    for (int i = 0; i < [self.topTabTempView.tabWidths count]; i++) {
        totalWidth += [self.topTabTempView.tabWidths[i] floatValue];
    }
    if (totalWidth > self.topTabTempView.frame.size.width) {
        [self.topTabTempView flashTheScrollbar];
    }

    //-------add the middle view-----
    UIView *contenView = [[UIView alloc] initWithFrame:CGRectMake(0, 70+addY, viewSize.width, viewSize.height-70-minusHeight)];
    contenView.autoresizingMask = (UIViewAutoresizingFlexibleWidth|
                                    UIViewAutoresizingFlexibleHeight);
    _contenView = contenView;
    [self.view addSubview:_contenView];
    
    
    if (self.name_view_data_Array) {
        
        NSMutableArray *views = [[NSMutableArray alloc] init];
        for (int i = 0; i < [self.name_view_data_Array count]; i++) {
            
            [views addObject:self.name_view_data_Array[i].tabItemView];
        }
        [self addTheViewsToContentView:views];
    }
    
    [self setTheTopTabTempView];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    for (int i = 0; i < [self.name_view_data_Array count]; i++) {
        [self.name_view_data_Array objectAtIndex:i].tabItemView.hidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    for (int i = 0; i < [self.name_view_data_Array count]; i++) {
        [self.name_view_data_Array objectAtIndex:i].tabItemView.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - addTheViewsToContentView 向contentView添加Views

- (void)addTheViewsToContentView:(NSArray *)views {
    
    for (int i = 0 ; i < [views count]; i++) {
        
        UIView *view = (UIView*)[views objectAtIndex:i];
        view.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        CGRect frame = self.contenView.frame;
        frame.origin.x = CGRectGetWidth(frame) * i;
        frame.origin.y = 0;
        view.frame = frame;
        view.tag = i;
        
        [self.contenView addSubview:view];
    }

}

#pragma mark - topTabViewClickAtIndex 点击topTap的第几栏
- (void)topTabViewClickAtIndex:(int)index{
    
    NSInteger count = self.currentIndex - index;
    
    tabScrolling = YES;
    
    [UIView animateWithDuration:0.3f animations:^{

        for (NSInteger i = 0; i < [self.name_view_data_Array count]; i++) {

            UIView *view = ((ZJCTabName_View_Data *)[self.name_view_data_Array objectAtIndex:i]).tabItemView;
            view.frame = CGRectMake(view.frame.origin.x + count*self.contenView.frame.size.width, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        }
        
        //[self changeSeleteTabBackImageFrame:index];
        self.topTabTempView.currentIndex = index;
        //[self.topTabTempView setNeedsDisplay];
        
    } completion:^(BOOL finished) {

        UIView *tableView = ((ZJCTabName_View_Data *)[self.name_view_data_Array objectAtIndex:index]).tabItemView;
        self.currentIndex = index;
        if ([tableView isKindOfClass:[UITableView class]]) {
            [(UITableView *)tableView reloadData];
            
        }
        tabScrolling = NO;
    }];
    
}

#pragma mark - setTheTopTabTempView 传递topTap的栏目名字

- (void)setTheTopTabTempView {
    
    if (self.name_view_data_Array) {
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTap.delegate = self;
        [self.topTabTempView addGestureRecognizer:singleTap];
        
        _recognizer1 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        [_recognizer1 setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [[self contenView] addGestureRecognizer:_recognizer1];
        //[self.contenView removeGestureRecognizer:<#(UIGestureRecognizer *)#>];
        
        _recognizer2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        [_recognizer2 setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [[self contenView] addGestureRecognizer:_recognizer2];
        
    }
    
}

#pragma mark - UITapGestureRecognizer methods 点击topTap的栏目 手势

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    
    if (!tabScrolling) {
        CGPoint locationPoint = [gestureRecognizer locationInView:self.topTabTempView];
        int index1 = [self.topTabTempView indexOfPointInTabTempView:locationPoint.x];
        [self topTabViewClickAtIndex:index1];
    }

}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        
        if (self.currentIndex < [self.name_view_data_Array count]-1) {
            [self topTabViewClickAtIndex:(self.currentIndex + 1)];
        }
    }
    
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        
        if (self.currentIndex > 0) {
            [self topTabViewClickAtIndex:(self.currentIndex - 1)];
        }
        
    }
    
}

#pragma mark - setTopTabNames
- (void)setTopTabNames:(NSArray *)names {
    self.topTabTempView.tabItemNames = names;
}

#pragma mark - UIInterfaceOrientation
//support iOS6 ealier system
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientat {
    return toInterfaceOrientat != UIInterfaceOrientationPortraitUpsideDown;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    [UIView animateWithDuration:(duration+0.1) animations:^{

    } completion:^(BOOL finished){
        NSMutableArray<NSString *> *names = [[NSMutableArray alloc] init];
        int i = 0;
        for (ZJCTabName_View_Data *data in self.name_view_data_Array) {
            [names addObject:data.tabItemName];
            UIView *view = data.tabItemView;
            view.frame = CGRectMake((i-self.currentIndex)*self.contenView.frame.size.width, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
            
            i++;
        }
        [self.topTabTempView setTabItemNames:names];
    }];
    
}
//support iOS 8
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
    
    [UIView animateWithDuration:(0.45) animations:^{
        
    } completion:^(BOOL finished){
        NSMutableArray<NSString *> *names = [[NSMutableArray alloc] init];
        int i = 0;
        for (ZJCTabName_View_Data *data in self.name_view_data_Array) {
            [names addObject:data.tabItemName];
            UIView *view = data.tabItemView;
            view.frame = CGRectMake((i-self.currentIndex)*self.contenView.frame.size.width, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
            
            i++;
        }
        [self.topTabTempView setTabItemNames:names];
    }];
    
}

@end
