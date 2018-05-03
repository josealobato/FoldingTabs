
# Introduction #

The Floating tab management group is in charge of mount, adjust and maintain a set of folding tabs but not of their content. 

![Folded Tabs image](http://josealobato.org/public_assets/FoldingTabs1.png)
![One unfolded Tab image](http://josealobato.org/public_assets/FoldingTabs2.png)
![Two unfolded Tab image](http://josealobato.org/public_assets/FoldingTabs3.png)

Some legend:

* Tab: is the small piece attached to the folder where the user can pull of.
* Folder: is the sheet attached to the tab that is hidden/shown when the tab is handled.

# How to use it #

Instanciate the _FloatingTabC_ giving the following parameters:

* An array of View Controllers. The view of these view controllers will become the content of the tab.
* A parent view. The parent view will be the view holder of the tabs.

Here a sample code for three tabs:

	TabDemoContent *tabvc0 = [[TabDemoContent alloc] initWithNibName:@"TabDemoContent" bundle:nil];
		tabvc0.tabTitle = @"Background";
		tabvc0.tabShowPercentage = 43.3;
	
		TabDemoContent *tabvc1 = [[TabDemoContent alloc] initWithNibName:@"TabDemoContent" bundle:nil];
		tabvc1.tabTitle = @"Widgets";
		tabvc1.tabShowPercentage = 33.3;
	
		TabDemoContent *tabvc2 = [[TabDemoContent alloc] initWithNibName:@"TabDemoContent" bundle:nil];
		tabvc2.tabTitle = @"Layouts";
		tabvc2.tabShowPercentage = 33.3;
	
		NSArray *viewControllers = [NSArray arrayWithObjects:tabvc0, tabvc1, tabvc2, nil];
		[tabvc0 release];
		[tabvc1 release];
		[tabvc2 release];
	
		FloatingTabC *tfloatingTabC = [[FloatingTabC alloc] initWithParentView:contentView 
														 viewControllers:viewControllers];
		self.floatingTabC = tfloatingTabC;
		[tfloatingTabC release];

# Requirements #

* There shall be provided a superview (NSView to hold the tabs).
* The superview shall call all subviews of _FloatingTabV_ type to refresh sending the _reviewTapVisualizationStatus_ message.

Here sample code:

	- (void)drawRect:(NSRect)dirtyRect
	{
		/*
		 * Ask the FloatingTabV subview to make sure the taps are properly visible.
		 */
	    for(NSView *subview in [self subviews]) {
			if([subview isMemberOfClass:[FloatingTabV class]]) {
				[(FloatingTabV *)subview reviewTapVisualizationStatus];
			}
		}
	}

* The view controllers that provides the content for the tab shall have the following properties (KVC compliant):
	+ (NSString *)tabTitle: the title text set on the tab.
	+ (CGFloat)tabShowPercentage: The percentage of the parent view that will be covered by the tab+folder on the unfold state.

# Architecture #

Basic overview of the architecture.

## Controller (FloatingTabC) ##

> Responsible of creating the stack, keeping a list of existing tabs (view controllers) and manage the logic of folding and unfolding the tabs (not folding but request to fold/unfold).

It is the builder so it builds the complete infrastructure. To initialize the stack an instance of this object has to be created.

## ViewController (FloatingTabVC) ##

> Responsible of fold and unfold its view and handle events on the tab.

The view associated with this VC is a _FloatingTabV_ custom view. It contains in fact the tab and folder. This VC will add its view as subview of the given main view (parentView). 

It also kept a pointer to the parentView so it can fold and unfold properly the tab+folder view according to the percentage given. 
It is connected with is Controller (FloatingTabC) through a delegate.

## Custom View (FloatingTabV) ##

> Responsible of drawing the tab and folder. 
 
It also takes the content subview from the VC and add as subview of its own content view. 

Have to be notice also that it offers to its superview the capability to revisit the tab location using _reviewTapVisualizationStatus_. This is done to fix the following problem: All resizing is done using the automatic resize of the subview. if the superview resize is fast, the folded tab view may go out of scope so it stops being refresh so get "out of view". When the superview is resized, by calling this method it makes sure that the taps will be relocated properly.

This view controllers, by modifying _drawrect_ the look and feel of the tab shall be given.

# Extra Files #

* **FloatingTabDimensions.h** this file is used for configuration of the tabs and folder basic dimensions.

# LICENCE

(The MIT License)

Copyright © 2011 Jose A. Lobato, jose.lobato@me.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
