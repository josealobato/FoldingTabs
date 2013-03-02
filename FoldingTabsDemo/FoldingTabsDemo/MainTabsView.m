//
//  MainTabsView.m
//
//  Created by Jose Lobato on 6/1/11.
//  Copyright 2011 binarytricks.com. All rights reserved.

#import "MainTabsView.h"
#import "FoldingTabV.h"

@implementation MainTabsView

#pragma mark - Drawing

- (void)drawRect:(NSRect)dirtyRect
{
	for(NSView *sview in [self subviews]) {
		[(FoldingTabV *)sview reviewTapVisualizationStatus];
	}
}

@end
