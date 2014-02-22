//
//  helpview.h
//  cubic's square
//
//  Created by James Eclipse on 8/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchUIView.h"

@interface helpview : UIViewController {
	IBOutlet UISegmentedControl* helpSegment;
	IBOutlet UITextView* textField;
	IBOutlet TouchUIView* puzzleview;
	NSTimer* timer1;
	NSTimer* timer2;
}
@property (nonatomic,retain) NSTimer *timer1, *timer2;
@property (nonatomic,retain) IBOutlet UISegmentedControl* helpSegment;
@property (nonatomic,retain) IBOutlet UITextView* textField;
@property (nonatomic,retain) IBOutlet TouchUIView* puzzleview;
-(IBAction) dismiss:(id) sender;
-(IBAction) helpChanged:(id) sender;
@end
