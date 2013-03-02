//
//  FoldingTabVC.h
//
//  Created by Jose Lobato on 4/19/11.
//  Copyright 2011 binarytricks.com. All rights reserved.

#import <Cocoa/Cocoa.h>

@protocol FloatingTabVCDelegate;

@interface FoldingTabVC : NSViewController {
	IBOutlet NSView *containerV;
@private
	CGFloat previousPercent;
	CGRect previousParentBounds;
}
@property (assign) id<FloatingTabVCDelegate> delegate;
@property (assign) NSUInteger tabIndex;
@property (retain) NSView *parentView;
@property (assign) BOOL isFolded;
@property (retain) NSViewController *contentVC;
@property (assign) BOOL isActive;

- (IBAction)tabClick:(id)sender;

- (void)unfoldUntilCoverTheSuperViewPercentage:(CGFloat)percent;
- (void)foldWithAnimation:(BOOL)isAnimated;
- (void)fold;

- (id)initWithNibName:(NSString *)nibNameOrNil
			   bundle:(NSBundle *)nibBundleOrNil
		   parentView:(NSView *)view
			contentVC:(NSViewController *)viewC
			 andIndex:(NSUInteger)index;

- (void)revisitTapPositionOnParentViewBoundsChange;

- (void)showContainer;
- (void)hideContainer;
- (BOOL)isActive;

@end


@protocol FloatingTabVCDelegate <NSObject>
- (void)tabClick:(FoldingTabVC *)sender;
@end
