//
//  FoldingTabProtocol.h
//
//  Created by Jose Lobato on 6/2/11.
//  Copyright 2011 binarytricks.com. All rights reserved.

#import <Foundation/Foundation.h>

@protocol FoldingTabDelegate <NSObject>

- (NSString *)tabDisplayTitle;
- (CGFloat)tabCoveredWindowPercentageWhenUnfolded;

@optional
- (void)tabWillBecomeActive:(id)sender;
- (void)tabDidBecomeActive:(id)sender;

@end
