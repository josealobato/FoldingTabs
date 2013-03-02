//
//  FoldingTabC.h
//
//  Created by Jose Lobato on 4/19/11.
//  Copyright 2011 binarytricks.com. All rights reserved.

#import <Foundation/Foundation.h>
#import "FoldingTabVC.h"

@interface FoldingTabC : NSController <FloatingTabVCDelegate>

@property (retain) NSView *parentView;
@property (retain) NSArray *contentVCs;
@property (retain) NSMutableArray *tabsVCs;

- (id)initWithParentView:(NSView *)view viewControllers:(NSArray *)viewcontrollers;
- (void)foldAllTabs;

@end
