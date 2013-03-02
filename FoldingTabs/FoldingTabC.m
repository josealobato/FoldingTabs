//
//  FoldingTabC.m
//
//  Created by Jose Lobato on 4/19/11.
//  Copyright 2011 binarytricks.com. All rights reserved.

#import "FoldingTabC.h"
#import "FoldingTabVC.h"
#import "FoldingTabV.h"
#import "FoldingTabDimensions.h"
#import "FoldingTabProtocol.h"


@interface FoldingTabC ()
@end

@implementation FoldingTabC
@synthesize parentView;
@synthesize contentVCs;
@synthesize tabsVCs;

#pragma mark -
#pragma mark Object Life cycle.

- (id)initWithParentView:(NSView *)view viewControllers:(NSArray *)viewcontrollers
{
    self = [super init];
    if (self) {
		NSAssert1([viewcontrollers count]<=NUMBER_MAX_OF_TABS, @"Number of tabs bigger than allowed (%lu)", [viewcontrollers count]);

		self.contentVCs = viewcontrollers;
		self.parentView = view;

		self.tabsVCs = [NSMutableArray arrayWithCapacity:NUMBER_MAX_OF_TABS];
		for (NSObject *contentVC in viewcontrollers) {
			NSAssert([contentVC isKindOfClass:[NSViewController class]], @"To create a tab a NSViewController has to be passed.", nil);
			NSAssert([contentVC conformsToProtocol:@protocol(FoldingTabDelegate)], @"The given NSViewController has to conform to FloatingTabDelegate protocol to create a tab.", nil);

			FoldingTabVC *tabvc = [[FoldingTabVC alloc] initWithNibName:@"FoldingTabVC"
																   bundle:nil
															   parentView:view
																contentVC:(NSViewController *)contentVC
																 andIndex:[self.tabsVCs count]];
			tabvc.delegate = self;
			[self.tabsVCs addObject:tabvc];
			[tabvc release];
		}
    }
    return self;
}

- (void)dealloc
{
	self.parentView = nil;
	self.contentVCs = nil;
	self.tabsVCs = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Tabs Allocation

- (void)foldAllTabs
{
	for (FoldingTabVC * floatingTabvc in self.tabsVCs) {
		[floatingTabvc fold];
	}
}


#pragma mark -
#pragma mark FloatingTabVCDelegate

- (void)tabClick:(FoldingTabVC *)sender;
{
	NSInteger senderIndex = (NSInteger)[self.tabsVCs indexOfObject:sender];
	CGFloat percentage;

	if ([sender isActive]) {
		[sender hideContainer];
		[sender setIsActive:NO];
		[sender fold];

		for (int idx = 0; idx < senderIndex; idx++) {
			[[self.tabsVCs objectAtIndex:idx] hideContainer];
			[[self.tabsVCs objectAtIndex:idx] setIsActive:NO];
			[[self.tabsVCs objectAtIndex:idx] fold];
		}
	}
	else {
		percentage = [(id<FoldingTabDelegate>)[sender contentVC] tabCoveredWindowPercentageWhenUnfolded];

		if(senderIndex != 0) {
			for (int idx = 0; idx < senderIndex; idx++) {
				[[self.tabsVCs objectAtIndex:idx] hideContainer];
				[[self.tabsVCs objectAtIndex:idx] setIsActive:NO];
				[[self.tabsVCs objectAtIndex:idx] unfoldUntilCoverTheSuperViewPercentage:percentage];
			}
		}

        if ([[sender contentVC] respondsToSelector:@selector(tabWillBecomeActive:)]) {
            [(id<FoldingTabDelegate>)[sender contentVC] tabWillBecomeActive:self];
        }
		[sender unfoldUntilCoverTheSuperViewPercentage:percentage];
		[sender showContainer];
		[sender setIsActive:YES];
		// FIXME: did becomeActive shall be send when the animation finishes.
        if ([[sender contentVC] respondsToSelector:@selector(tabDidBecomeActive:)]) {
            [(id<FoldingTabDelegate>)[sender contentVC] tabDidBecomeActive:self];
        }

		if((senderIndex + 1) != [self.tabsVCs count]) {
			for (int idx = ((int)senderIndex + 1); idx < (int)[self.tabsVCs count]; idx++) {
				[[self.tabsVCs objectAtIndex:idx] hideContainer];
				[[self.tabsVCs objectAtIndex:idx] setIsActive:NO];
				[[self.tabsVCs objectAtIndex:idx] fold];
			}
		}
	}
}


@end
