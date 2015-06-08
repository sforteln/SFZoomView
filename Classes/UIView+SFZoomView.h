//
//  UIView+SFZoomView.h
//  SFZoomView
//
//  Created by Simon Fortelny on 6/5/15.
//  Copyright (c) 2015 Simon Fortelny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SFZoomView)

- (void)sf_zoomOut;
- (void)sf_zoomIn;
// instantly sets the view as zoomed out. Can be done before its added to a view heirarchy
- (void)sf_makeZoomedOut;
@end
