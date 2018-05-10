//
//  XKPagerController.m
//  XKPageController
//
//  Created by Allen、 LAS on 2018/5/10.
//  Copyright © 2018年 重楼. All rights reserved.
//

#import "XKPagerController.h"
#import "Masonry.h"

@interface XKPagerController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView * displayScrollView;
@end

@implementation XKPagerController

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _visibleContentViews = [NSMutableDictionary dictionary];
        
        __weak typeof(self) ws = self;
        
        [self addSubview:self.displayScrollView];
        
        [self.displayScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
        
        [self layoutIfNeeded];
    }
    return self;
}

//数据刷新(一次性操作、重载)
- (void)xk_ReloadData{
    
    NSInteger totalCount = [self.dataSource numberOfContentViewsInPagerController];
    
    //更新内容size
    _displayScrollView.contentSize = CGSizeMake(_displayScrollView.frame.size.width * totalCount, _displayScrollView.frame.size.height);
    
    if (_visibleContentViews.count) {
        
        [_visibleContentViews enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, UIView *  _Nonnull obj, BOOL * _Nonnull stop) {
            
            [obj removeFromSuperview];
        }];
        
        [_visibleContentViews removeAllObjects];
    }
    
    [self scrollViewDidScroll:self.displayScrollView];
}

//更新数据(适合统一的子页面)
- (void)xk_UpdateData{
    
    NSInteger totalCount = [self.dataSource numberOfContentViewsInPagerController];
    
    //更新contentSize
    _displayScrollView.contentSize = CGSizeMake(_displayScrollView.frame.size.width * totalCount, _displayScrollView.frame.size.height);
    
    if (_visibleContentViews.count > totalCount) { //如果有页面视图较多,则隐藏
        
        [_visibleContentViews enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, UIView *  _Nonnull obj, BOOL * _Nonnull stop) {
            
            NSInteger index = key.integerValue;
            
            obj.hidden = index >= totalCount;
        }];
    }
    [self scrollViewDidScroll:self.displayScrollView];
}

//页面布局
- (UIView *)xk_layoutSubViewsWithSuperView:(UIView*)superView index:(NSInteger)index{
    
    //获取视图
    NSString * key = [NSString stringWithFormat:@"%ld",index];
    
    UIView * visibleItem = _visibleContentViews[key];
    
    if (!visibleItem) {
        
        //获取视图
        visibleItem = [self.dataSource pagerController:self contentViewForIndex:index];
        
        _visibleContentViews[key] = visibleItem;

        [superView addSubview:visibleItem];
        
        visibleItem.frame = CGRectMake(superView.frame.size.width * index, 0, superView.frame.size.width, superView.frame.size.height);
        
        _visibleContentViews[key] = visibleItem;
        
        [superView addSubview:visibleItem];
    }
    return visibleItem;
}

//MARK:滚动切换
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _currentIndex = (NSInteger)scrollView.contentOffset.x / scrollView.frame.size.width;
    
    //当前页面
    UIView * visibleItem = [self xk_layoutSubViewsWithSuperView:scrollView index:_currentIndex];
    
    if ([self.dataSource respondsToSelector:@selector(pagerController:currentView:scrollToContentViewAtIndex:)]) {
        
        [self.dataSource pagerController:self currentView:visibleItem scrollToContentViewAtIndex:_currentIndex];
    }
}

//获取下标位置的内容页面
- (UIView*)contentViewOfIndex:(NSInteger)index{
    
    //获取视图
    NSString * key = [NSString stringWithFormat:@"%ld",index];
    
    UIView * visibleItem = _visibleContentViews[key];
    
    return visibleItem;
}

//设置滚动事件
- (void)scrollToContentViewAtIndex:(NSInteger)index animate:(BOOL)animate{
    [self.displayScrollView setContentOffset:CGPointMake(self.displayScrollView.frame.size.width * index, 0) animated:animate];
}

- (void)setFrame:(CGRect)frame{
    
    [super setFrame:frame];
    
    [self layoutSubviews];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.displayScrollView.frame = self.bounds;
    
    if (_visibleContentViews.count) {
        
        [_visibleContentViews enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, UIView * _Nonnull obj, BOOL * _Nonnull stop) {
            
            NSInteger index = key.integerValue;
            
            obj.frame = CGRectMake(self.displayScrollView.frame.size.width * index, 0, self.displayScrollView.frame.size.width, self.displayScrollView.frame.size.height);

        }];
    }
}

#pragma mark

- (UIScrollView*)displayScrollView
{
    if (!_displayScrollView) {
        _displayScrollView = [UIScrollView new];
        _displayScrollView.delegate = self;
        _displayScrollView.bounces = NO;
        _displayScrollView.pagingEnabled = YES;
        _displayScrollView.showsVerticalScrollIndicator = NO;
        _displayScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _displayScrollView;
}

- (void)dealloc{
    _displayScrollView = nil;
}
@end
