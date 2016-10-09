#import "PageScrollView.h"

@implementation PageScrollView

-(id)initWithFrame:(CGRect)frame {
	self = [ super initWithFrame: frame ];
	if (self != nil) {
		_pageRegion = CGRectMake(0, 0, frame.size.width, frame.size.height);
		_controlRegion = CGRectMake(frame.origin.x, frame.size.height - 40.0f, frame.size.width, 40.0f);
		self.delegate = nil;
		
		scrollView = [ [ UIScrollView alloc ] initWithFrame: _pageRegion ];
		scrollView.pagingEnabled = YES;
		scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
		[ self addSubview: scrollView ];
		
		pageControl = [ [ UIPageControl alloc ] initWithFrame: _controlRegion ];
		[ pageControl addTarget: self action: @selector(pageControlDidChange:) forControlEvents: UIControlEventValueChanged ];
		[ self addSubview: pageControl ];
	}
	return self;
}

-(void)setPages:(NSMutableArray *)pages {
	for(int i=0;i<[_pages count];i++) {
		[ [ _pages objectAtIndex: i ] removeFromSuperview ];
	}
	_pages = pages;
	scrollView.contentOffset = CGPointMake(0.0, 0.0);
	scrollView.contentSize = CGSizeMake(_pageRegion.size.width * [ _pages count ], _pageRegion.size.height);
	pageControl.numberOfPages = [ _pages count ];
	pageControl.currentPage = 0;
	[ self layoutViews ];
}

- (void)layoutViews {
	for(int i=0;i<[ _pages count];i++) {
		UIView *page = [ _pages objectAtIndex: i ];
		CGRect bounds = page.bounds;
		CGRect frame = CGRectMake(_pageRegion.size.width * i, 0.0, _pageRegion.size.width, _pageRegion.size.height);
		page.frame = frame;
		page.bounds = bounds;
		[ scrollView addSubview: page ];
	}
}
- (void)setPageControlHidden:(BOOL)hidden
{
    [pageControl setHidden:hidden];
}

-(id)getDelegate {
	return _delegate;
}

- (void)setDelegate:(id)delegate {
	_delegate = delegate;
}

-(NSMutableArray *)getPages {
	return _pages;
}

-(void)setCurrentPage:(int)page {
	[ scrollView setContentOffset: CGPointMake(_pageRegion.size.width * page, scrollView.contentOffset.y) animated: YES ];
    pageControl.currentPage = page;
    [self notifyPageChange];
}

-(int)getCurrentPage {
	return (int) (scrollView.contentOffset.x / _pageRegion.size.width);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControl.currentPage = self.currentPage;
	[ self notifyPageChange ];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.delegate != nil) {
	    if ([ _delegate conformsToProtocol:@protocol(PageScrollViewDelegate) ]) {
			if ([ _delegate respondsToSelector:@selector(pageScrollViewWillBeginDragging:) ]) {
                [_delegate pageScrollViewWillBeginDragging:self];
			}
		}
	}
    
}

-(void) pageControlDidChange: (id)sender 
{
    UIPageControl *control = (UIPageControl *) sender;
    if (control == pageControl) {
		self.currentPage = control.currentPage;
	}
	[ self notifyPageChange ];
}

-(void) notifyPageChange {
	if (self.delegate != nil) {
	    if ([ _delegate conformsToProtocol:@protocol(PageScrollViewDelegate) ]) {
			if ([ _delegate respondsToSelector:@selector(pageScrollViewDidChangeCurrentPage:currentPage:) ]) {
    		    [ self.delegate pageScrollViewDidChangeCurrentPage: (PageScrollView *)self currentPage:pageControl.currentPage ];
			}
		}
	}
}

@end
