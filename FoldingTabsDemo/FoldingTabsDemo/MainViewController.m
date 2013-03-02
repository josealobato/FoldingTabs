//
//  MainViewController.m
//  FoldingTabsDemo
//
//  Created by Jose Lobato on 3/1/13.
//  Copyright (c) 2013 Jose Lobato. All rights reserved.

#import "MainViewController.h"
#import "TabDemoContent.h"
#import "FoldingTabC.h"
#import "MainTabsView.h"

@interface MainViewController ()
@property (retain) FoldingTabC *floatingTabC;
@end

@implementation MainViewController

- (void)awakeFromNib
{
    TabDemoContent *tabvc0 = [[TabDemoContent alloc] initWithNibName:@"TabDemoContent" bundle:nil];
    tabvc0.tabTitle = @"Tab 1";
    tabvc0.tabShowPercentage = 43.3;

    TabDemoContent *tabvc1 = [[TabDemoContent alloc] initWithNibName:@"TabDemoContent" bundle:nil];
    tabvc1.tabTitle = @"Tab 2";
    tabvc1.tabShowPercentage = 53.3;

    TabDemoContent *tabvc2 = [[TabDemoContent alloc] initWithNibName:@"TabDemoContent" bundle:nil];
    tabvc2.tabTitle = @"Tab 3";
    tabvc2.tabShowPercentage = 33.3;

    NSArray *viewControllers = [NSArray arrayWithObjects:tabvc0, tabvc1, tabvc2, nil];
    [tabvc0 release];
    [tabvc1 release];
    [tabvc2 release];

    FoldingTabC *tfloatingTabC = [[FoldingTabC alloc] initWithParentView:self.tabsView
                                                           viewControllers:viewControllers];
    self.floatingTabC = tfloatingTabC;
    [tfloatingTabC release];
}

@end
