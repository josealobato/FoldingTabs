//
//  FolddingTabV.h
//
//  Created by Jose Lobato on 4/20/11.
//  Copyright 2011 binarytricks.com. All rights reserved.

#import <Cocoa/Cocoa.h>

@class FoldingTabVC;

@interface FoldingTabV : NSView {
	IBOutlet NSButton *tabButton;
	IBOutlet FoldingTabVC *controller;
	IBOutlet NSView *containerView;
@private
    CGRect tabRect;
}

- (void)reviewTapVisualizationStatus;

@end
