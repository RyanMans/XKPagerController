//
//  XKPagerController.h
//  XKPageController
//
//  Created by Allen、 LAS on 2018/5/10.
//  Copyright © 2018年 重楼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol XKPagerControllerDataSource;

@interface XKPagerController : UIView

//代理对象
@property(nonatomic,weak)id<XKPagerControllerDataSource>dataSource;

//滚动视图
@property(nonatomic,strong,readonly)UIScrollView * displayScrollView;

//当前视图下标
@property(nonatomic,assign,readonly)NSInteger currentIndex;

//视图集合 key: currentIndex->string
@property(nonatomic,strong,readonly)NSMutableDictionary <NSString*,UIView*> * visibleContentViews;

//数据刷新（重载,会删除多余的视图数据）
- (void)xk_ReloadData;

//更新数据(适合统一的子页面)
- (void)xk_UpdateData;

//获取下标位置的内容页面
- (nullable UIView*)contentViewOfIndex:(NSInteger)index;

//页面滚动
- (void)scrollToContentViewAtIndex:(NSInteger)index animate:(BOOL)animate;

@end

//页面数据协议
@protocol XKPagerControllerDataSource <NSObject>

@required

//多少个内容视图
- (NSInteger)numberOfContentViewsInPagerController;

//下标对应返回视图(不可nil)
- (UIView *)pagerController:(XKPagerController *)pagerController contentViewForIndex:(NSInteger)index;

@optional

//滚动视图回调(滚动的时候会执行该方法)
- (void)pagerController:(XKPagerController *)pagerController currentView:(UIView*)currentView scrollToContentViewAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
