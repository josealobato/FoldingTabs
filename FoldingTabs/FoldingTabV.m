//
//  FolddingTabV.m
//
//  Created by Jose Lobato on 4/20/11.
//  Copyright 2011 binarytricks.com. All rights reserved.

#import "FoldingTabV.h"
#import "FoldingTabDimensions.h"
#import "FoldingTabVC.h"
#import "FoldingTabProtocol.h"

@implementation FoldingTabV

#pragma mark -
#pragma mark Object Life Cycle

- (void)dealloc
{
    containerView = nil;
    tabButton = nil;
    controller = nil;
    [super dealloc];
}

- (void)awakeFromNib
{
    [self setWantsLayer:YES];

    /*
     * Set the size and location of the folder (the content area).
     */
    CGFloat folderX = TAB_WIDTH + TAB_LEFT_OFFSET;
    CGRect folderRect = CGRectMake(folderX,
                                   0.0,
                                   self.bounds.size.width - 2 * folderX,
                                   self.bounds.size.height);
    containerView.frame = folderRect;

    /*
     * Adjust the size of the content view given (the one on the given VC).
     * And make it subview of our content View.
     * Later, adjust the size of our content View to be shifted to the right
     * so leave room for the tab, and fill the rest of the space.
     */
    CGRect usefulArea = CGRectMake(GAP_TAB_USEFULAREA, 0.0,
                                   containerView.bounds.size.width - GAP_TAB_USEFULAREA,
                                   containerView.bounds.size.height);
    controller.contentVC.view.frame = usefulArea;
    [containerView addSubview:controller.contentVC.view];

}

#pragma mark - Drawing

- (void)reviewTapVisualizationStatus
{
    [controller revisitTapPositionOnParentViewBoundsChange];
}


- (NSBezierPath *)folderAndTabPath
{
    CGFloat folderX = TAB_WIDTH + TAB_LEFT_OFFSET;
    CGFloat tabX =  TAB_LEFT_OFFSET;
    CGFloat tabY_bottom = self.bounds.size.height - ((TAB_HEIGHT + SPACE_BETWEEN_TABS) * (controller.tabIndex + 1));
    CGFloat tabY_top = tabY_bottom + TAB_HEIGHT;

    NSBezierPath* folderAndTapPath = [NSBezierPath bezierPath];

    [folderAndTapPath moveToPoint:NSMakePoint(folderX, 0.0)];

    [folderAndTapPath lineToPoint:NSMakePoint(folderX, tabY_bottom)];
    [folderAndTapPath lineToPoint:NSMakePoint(tabX + TAB_ARCRADIUS, tabY_bottom)];

    NSPoint fromPoint1 = NSMakePoint(tabX, tabY_bottom);
    NSPoint toPoint1 = NSMakePoint(tabX, tabY_bottom + TAB_ARCRADIUS);
    [folderAndTapPath appendBezierPathWithArcFromPoint:fromPoint1 toPoint:toPoint1 radius:TAB_ARCRADIUS];

    [folderAndTapPath lineToPoint:NSMakePoint(tabX, tabY_top - TAB_ARCRADIUS)];

    NSPoint fromPoint2 = NSMakePoint(tabX, tabY_top);
    NSPoint toPoint2 = NSMakePoint(tabX + TAB_ARCRADIUS, tabY_top);
    [folderAndTapPath appendBezierPathWithArcFromPoint:fromPoint2 toPoint:toPoint2 radius:TAB_ARCRADIUS];

    [folderAndTapPath lineToPoint:NSMakePoint(folderX, tabY_top)];
    [folderAndTapPath lineToPoint:NSMakePoint(folderX, self.bounds.size.height)];
    [folderAndTapPath lineToPoint:NSMakePoint(self.bounds.size.width, self.bounds.size.height)];
    [folderAndTapPath lineToPoint:NSMakePoint(self.bounds.size.width, 0.0)];
    [folderAndTapPath closePath];

    return folderAndTapPath;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [NSGraphicsContext saveGraphicsState];

    [controller revisitTapPositionOnParentViewBoundsChange];

    NSImage *folderbackgroundImage = [NSImage imageNamed:@"folder_background.png"];
    NSColor *folderBackgroundPatternColor = [NSColor colorWithPatternImage:folderbackgroundImage];
    [folderBackgroundPatternColor setFill];
    [[NSColor grayColor] setStroke];

    NSShadow* theShadow = [[NSShadow alloc] init];
    [theShadow setShadowOffset:NSMakeSize(-1.0, -1.0)];
    [theShadow setShadowBlurRadius:6.0];
    [theShadow set];

    NSAffineTransform *xform = [NSAffineTransform transform];
    [xform translateXBy:-0.5 yBy:0.5];
    [xform concat];

    [[self folderAndTabPath] stroke];

    [xform invert];
    [xform concat];

    [[self folderAndTabPath] fill];

    /*
     * Create the tab rectangle to set the button
     */
    CGFloat y = self.bounds.size.height - ((TAB_HEIGHT + SPACE_BETWEEN_TABS) * (controller.tabIndex + 1));
    tabRect = CGRectMake(TAB_LEFT_OFFSET,
                         y,
                         TAB_WIDTH,
                         TAB_HEIGHT);
    tabButton.frame = tabRect;
    [tabButton setTransparent:YES];

    NSAffineTransform *xformTab = [NSAffineTransform transform];
    [xformTab translateXBy:(TAB_LEFT_OFFSET + TAB_WIDTH) yBy:y];
    [xformTab rotateByDegrees:90.0];
    [xformTab concat];

    NSString *tabTitle = [(id<FoldingTabDelegate>)controller.contentVC tabDisplayTitle];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];;
    [style setAlignment:NSCenterTextAlignment];
    NSDictionary *titleAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSFont boldSystemFontOfSize:12.0], NSFontAttributeName,
                                     [NSColor whiteColor], NSForegroundColorAttributeName,
                                     [NSColor whiteColor], NSStrokeColorAttributeName,
                                     style,NSParagraphStyleAttributeName,/*
                                                                          [NSNumber numberWithFloat:6.0], NSStrokeWidthAttributeName,*/nil];
    [style release];
    CGRect newTabRec = NSMakeRect(0, -(TAB_WIDTH/4),TAB_HEIGHT, TAB_WIDTH);
    [tabTitle drawInRect:newTabRec withAttributes:titleAttributes];

    [xformTab invert];
    [xformTab concat];

    [NSGraphicsContext restoreGraphicsState];
    [theShadow release];
}

@end
