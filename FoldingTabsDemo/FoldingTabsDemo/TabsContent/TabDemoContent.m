//
//  TabDemoContent.m
//
//  Created by Jose Lobato on 4/21/11.
//  Copyright 2011 binarytricks.com. All rights reserved.

#import "TabDemoContent.h"

@interface TabDemoContent (PrivateMethods)

@end

@implementation TabDemoContent
@synthesize tabTitle;
@synthesize tabShowPercentage;

#pragma mark - FloatingTabDelegate

- (NSString *)tabDisplayTitle
{
	return self.tabTitle;
}


- (CGFloat)tabCoveredWindowPercentageWhenUnfolded
{
	return tabShowPercentage;
}

@end
