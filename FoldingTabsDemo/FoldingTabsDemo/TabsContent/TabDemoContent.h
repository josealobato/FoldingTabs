//
//  TabDemoContent.h
//
//  Created by Jose Lobato on 4/21/11.
//  Copyright 2011 binarytricks.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FoldingTabProtocol.h"

@interface TabDemoContent : NSViewController <FoldingTabDelegate>{
	IBOutlet NSTextField *label;
@private

}
@property (retain) NSString *tabTitle;
@property CGFloat tabShowPercentage;

@end
