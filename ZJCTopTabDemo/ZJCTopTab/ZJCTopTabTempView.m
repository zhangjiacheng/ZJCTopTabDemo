//
//  TopTabTempView.m
//  zhangjiacheng
//
//  Created by zhangjiacheng on 13-8-15.
//  Copyright (c) 2013年 zhangjiacheng. All rights reserved.
//

#import "ZJCTopTabTempView.h"

@interface ZJCTopTabTempView()

@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *hilightColor;

//@property (nonatomic, strong) NSArray<UILabel *> *nameLabels;
@property (nonatomic,weak) UIView *seleteTabBackImage;
@property (nonatomic, weak) UIScrollView *scrollV;



//@property (nonatomic, weak) UIScrollView *scrollV;

@end

@implementation ZJCTopTabTempView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
          self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame itemNames:(NSArray *)itemNames tintColor:(UIColor *)tintColor hilightColor:(UIColor *)hilightColor {
    self = [super initWithFrame:frame];
    if (self) {
        self.tabItemNames = itemNames;
        self.tintColor = tintColor;
        self.hilightColor = hilightColor;
        self.currentIndex = 0;
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [tintColor CGColor];
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        
        ///////////////////////////////////////////////////////////
        
        NSInteger tabCount = [itemNames count];
        float tabWidths[tabCount];
        float tabTotalWidth = 0;
        for (int i = 0; i < tabCount; i++) {
            //-boundingRectWithSize:options:attributes:context:
            //float w = [itemNames[i] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(MAXFLOAT, 20)].width+10;
            float w = [itemNames[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size.width+10;
            
            
            w = ((w<50) ? 50 : w);
            tabWidths[i] = w;
            tabTotalWidth += w;
        }
        if (tabTotalWidth < frame.size.width) {
            float a = (frame.size.width-tabTotalWidth)/tabCount;
            for (int i = 0; i < tabCount; i++) {
                tabWidths[i] += a;
            }
        }
        
        NSMutableArray *tabArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < tabCount; i++) {
            [tabArray addObject:[NSNumber numberWithFloat:tabWidths[i]]];
        }
        self.tabWidths = tabArray;
        
        UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        //no useness, if donot add this, the other cannot add to the scrollV
        UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        v1.backgroundColor = tintColor;
        //tv.seleteTabBackImage = seleteTabBackImage;
        [self addSubview:v1];//ttt self.scrollV
        
        UIView *seleteTabBackImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tabWidths[0], frame.size.height)];
        seleteTabBackImage.backgroundColor = tintColor;
        self.seleteTabBackImage = seleteTabBackImage;
        [sv addSubview:seleteTabBackImage];//ttt self.scrollV
        
        float scrollContentW = 0;
        for (int i = 0; i < tabCount; i++) {
            
            UILabel *lablei = [[UILabel alloc] initWithFrame:CGRectMake(scrollContentW, (frame.size.height-20)/2, tabWidths[i], 20)];
            lablei.backgroundColor = [UIColor clearColor];
            lablei.textAlignment = NSTextAlignmentCenter;
            lablei.text = itemNames[i];
            lablei.font = [UIFont systemFontOfSize:14];
            lablei.textColor = (i==0) ? [UIColor whiteColor] : tintColor;
            lablei.tag = 1000+i;
            [sv addSubview:lablei];//ttt self.scrollV
            
            scrollContentW += tabWidths[i];
            
            if (i < (tabCount-1)) {
                UIView *l = [[UIView alloc] initWithFrame:CGRectMake(scrollContentW-1, 0, 1, frame.size.height)];
                l.backgroundColor = tintColor;
                l.tag = 2000+i;
                [sv addSubview:l];//ttt self.scrollV
            }
        }
        
        sv.contentSize = CGSizeMake(scrollContentW, frame.size.height);
        sv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.scrollV = sv;
        [self addSubview:sv];
        ///////////////////////////////////////////////////////////
       
    }
    return self;
}


- (void)setCurrentIndex:(int)index {
    
    float totalWidth = 0;
    CGRect rect = CGRectZero;
    for (int i = 0; i < [self.tabWidths count]; i++) {
        float currentW = [self.tabWidths[i] floatValue];
        totalWidth += currentW;
        if (i  == index) {
            rect = CGRectMake(totalWidth-currentW, 0, currentW, self.frame.size.height);
            break;
        }
    }
    
    [UIView animateWithDuration:0.15 animations:^{
        self.seleteTabBackImage.frame = rect;
        UILabel *preLabel = (UILabel *)[self viewWithTag:1000+_currentIndex];
        preLabel.textColor = self.tintColor;
        UILabel *label = (UILabel *)[self viewWithTag:1000+index];
        label.textColor = self.hilightColor;
    } completion:^(BOOL finished){
        _currentIndex = index;
        [self.scrollV scrollRectToVisible:rect animated:YES];
    }];
    
}

- (int)indexOfPointInTabTempView:(CGFloat)x1 {
    
    CGFloat x = x1 + self.scrollV.contentOffset.x;//[self convertPoint:point toView:self.scrollV].x + self.scrollV.contentOffset.x;
    int index = 0;
    float totalWidth = 0;
    //CGRect rect = CGRectZero;
    for (int i = 0; i < [self.tabWidths count]; i++) {
        float currentW = [self.tabWidths[i] floatValue];
        totalWidth += currentW;
        if (x < totalWidth) {
            index = i;
            //rect = CGRectMake(totalWidth-currentW, 0, currentW, self.frame.size.height);
            break;
        }
    }
    
    self.currentIndex = index;
    
    return index;
}

- (void)setTabItemNames:(NSArray *)itemNames {
    _tabItemNames = itemNames;
    
    NSInteger tabCount = [itemNames count];
    float tabWidths[tabCount];
    float tabTotalWidth = 0;
    for (int i = 0; i < tabCount; i++) {
        //float w = [itemNames[i] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(MAXFLOAT, 20)].width+10;
        float w = [itemNames[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size.width+10;
        w = ((w<50) ? 50 : w);
        tabWidths[i] = w;
        tabTotalWidth += w;
    }
    if (tabTotalWidth < self.frame.size.width) {
        float a = (self.frame.size.width-tabTotalWidth)/tabCount;
        for (int i = 0; i < tabCount; i++) {
            tabWidths[i] += a;
        }
    }
    
    NSMutableArray *tabArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < tabCount; i++) {
        [tabArray addObject:[NSNumber numberWithFloat:tabWidths[i]]];
    }
    self.tabWidths = tabArray;
    
    float scrollContentW = 0;
    for (int i = 0; i < [itemNames count]; i++) {
         UILabel *lable = (UILabel *)[self viewWithTag:1000+i];
        lable.text = itemNames[i];
        lable.frame = CGRectMake(scrollContentW, (self.frame.size.height-20)/2, [self.tabWidths[i] floatValue], 20);
        
        if (i==self.currentIndex) {
            self.seleteTabBackImage.frame = CGRectMake(scrollContentW, 0, [self.tabWidths[i] floatValue], self.frame.size.height);
        }
        
        scrollContentW += [self.tabWidths[i] floatValue];
        
        UIView *l = [self viewWithTag:2000+i];
        l.frame = CGRectMake(scrollContentW-1, 0, 1, self.frame.size.height);
    }
    self.scrollV.contentSize = CGSizeMake(scrollContentW, self.frame.size.height);
    
    
}

- (void)flashTheScrollbar {
    [self.scrollV flashScrollIndicators];
}
@end
