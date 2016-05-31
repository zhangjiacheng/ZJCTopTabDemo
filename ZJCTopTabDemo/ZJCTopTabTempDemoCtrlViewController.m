//
//  ZJCTopTabTempDemoCtrlViewController.m
//  ZJCTopTabDemo
//
//  Created by zhangjiacheng on 16/5/27.
//  Copyright © 2016年 zhangjiacheng. All rights reserved.
//

#import "ZJCTopTabTempDemoCtrlViewController.h"

@interface ZJCTopTabTempDemoCtrlViewController ()

@end

@implementation ZJCTopTabTempDemoCtrlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ZJC Top Tab ctrl";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - parentViewCtrl methods 父类方法
- (void)addTheViewsToContentView:(NSArray *)views {
    
    [super addTheViewsToContentView:views];
    
    for (NSInteger i = 0; i < [views count]; i++) {
        
        if ([views[i] isKindOfClass:[UITableView class]]) {
            UITableView *view = (UITableView *)views[i];
            view.delegate = self;
            view.dataSource = self;
        }
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdenti = @"CellIdenti";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdenti];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdenti];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Tab:%ld -- row:%ld",(long)tableView.tag+1, (long)indexPath.row+1];
    return cell;
    
}


@end
