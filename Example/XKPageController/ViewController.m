//
//  ViewController.m
//  XKPageController
//
//  Created by Allen、 LAS on 2018/5/10.
//  Copyright © 2018年 重楼. All rights reserved.
//

#import "ViewController.h"
#import "XKPagerController.h"
@interface ViewController ()
@property (nonatomic,strong)XKPagerController * pagerController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.pagerController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
