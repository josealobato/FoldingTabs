//
//  TapDemoView.m
//
//  Created by Jose Lobato on 4/26/11.
//  Copyright 2011 binarytricks.com. All rights reserved.

#import "TapDemoView.h"
#import "FoldingTabDimensions.h"

#define TEST_SQUARE_PADDING		20.0f

@implementation TapDemoView

- (void)dealloc
{
	[self removeFromSuperview];
    [super dealloc];
}


- (void)AddDashStyleToPath:(NSBezierPath *) thePath
{
	CGFloat lineDash[6];
	lineDash[0] = 40.0;
	lineDash[1] = 12.0;
	lineDash[2] = 8.0;
	lineDash[3] = 12.0;
	lineDash[4] = 8.0;
	lineDash[5] = 12.0;

	[thePath setLineDash:lineDash count:6 phase:0.0];
}


- (void)drawRect:(NSRect)dirtyRect
{
	NSGraphicsContext* context = [NSGraphicsContext currentContext];
	[context saveGraphicsState];

	CGRect targetFrame = self.frame;
	[[NSColor grayColor] setFill];
	[[NSColor grayColor] setStroke];

	NSBezierPath* squarePath = [NSBezierPath bezierPath];
	[squarePath moveToPoint:NSMakePoint(TEST_SQUARE_PADDING, TEST_SQUARE_PADDING)];
	[squarePath lineToPoint:NSMakePoint(targetFrame.size.width - TEST_SQUARE_PADDING, TEST_SQUARE_PADDING)];
	[squarePath lineToPoint:NSMakePoint(targetFrame.size.width - TEST_SQUARE_PADDING,
										targetFrame.size.height - TEST_SQUARE_PADDING)];
	[squarePath lineToPoint:NSMakePoint(TEST_SQUARE_PADDING,
										targetFrame.size.height - TEST_SQUARE_PADDING)];
	[squarePath closePath];

	[self AddDashStyleToPath:squarePath];
	[squarePath stroke];

	[context restoreGraphicsState];
}

@end
