//
//  MainViewController.h
//  FoldingTabsDemo
//
//  Created by Jose Lobato on 3/1/13.
//  Copyright (c) 2013 Jose Lobato. All rights reserved.

#import <Cocoa/Cocoa.h>

@class MainTabsView;

@interface MainViewController : NSViewController
@property(assign) IBOutlet MainTabsView *tabsView;
@end
