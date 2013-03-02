//
//  FoldingTabVC.m
//
//  Created by Jose Lobato on 4/19/11.
//  Copyright 2011 binarytricks.com. All rights reserved.

#import "FoldingTabVC.h"
#import "FoldingTabDimensions.h"

@interface FoldingTabVC ()

@end


@implementation FoldingTabVC
@synthesize delegate;
@synthesize tabIndex;
@synthesize isFolded;
@synthesize parentView;
@synthesize contentVC;
@synthesize isActive;

#pragma mark - Object Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
           parentView:(NSView *)view
            contentVC:(NSViewController *)viewC
             andIndex:(NSUInteger)index
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        /*
         * Save the data given allocate the tab through folding and may our main view subview of the
         * given parent view.
         */
        self.parentView = view;
        self.contentVC = viewC;
        self.tabIndex = index;
        [self foldWithAnimation:NO];
        [self.parentView addSubview:self.view];
        previousPercent = 0.0;
        [self hideContainer];
        self.isActive = NO;
    }
    return self;
}

- (void)dealloc
{
    [self.view removeFromSuperview];
    containerV = nil;
    self.delegate = nil;
    self.parentView = nil;
    self.contentVC = nil;
    [super dealloc];
}


#pragma mark - Events

- (IBAction)tabClick:(id)sender
{
    [delegate tabClick:self];
}


#pragma mark - Folding control

- (void)unfoldUntilCoverTheSuperViewPercentage:(CGFloat)percent
{
    self.isFolded = NO;
    CGRect parentBounds = self.parentView.bounds;
    previousParentBounds = parentBounds;
    CGRect frame = CGRectMake(parentBounds.size.width - (parentBounds.size.width * (percent/100)),
                              0.0,
                              parentBounds.size.width * (percent/100),
                              parentBounds.size.height);
    previousPercent = percent;
    [[self.view animator] setFrame:frame];
}


- (void)foldWithAnimation:(BOOL)isAnimated
{
    self.isFolded = YES;
    CGRect parentBounds = self.parentView.bounds;
    previousParentBounds = parentBounds;

    CGFloat foldersize;
    if(previousPercent<1)
        foldersize = SHOWN_30PCT;
    else
        foldersize = previousPercent/100;

    CGRect frame = CGRectMake(parentBounds.size.width - TAB_TOTAL_SHOWN_WHEN_FOLDED,
                              0.0,
                              parentBounds.size.width * foldersize,
                              parentBounds.size.height);
    if(isAnimated)
        [[self.view animator] setFrame:frame];
    else
        [self.view setFrame:frame];
}


- (void)fold
{
    [self foldWithAnimation:YES];
}


- (void)revisitTapPositionOnParentViewBoundsChange
{
    if (CGRectEqualToRect(previousParentBounds, self.parentView.bounds) == NO) {
        if (isFolded) {
            [self foldWithAnimation:NO];
        }
        else {
            [self unfoldUntilCoverTheSuperViewPercentage:previousPercent];
        }
    }
}


#pragma mark - Container view

- (void)showContainer
{

}


- (void)hideContainer
{

}

@end
