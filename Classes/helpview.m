//
//  helpview.m
//  cubic's square
//
//  Created by James Eclipse on 8/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "helpview.h"
#import "TileView.h"

@implementation helpview
@synthesize helpSegment,textField,puzzleview,timer1,timer2;
-(IBAction) dismiss:(id) sender{
	[helpSegment release];
	[self.timer1 invalidate];
	[self.timer2 invalidate];
	[self.timer1 release];
	[self.timer2 release];
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction) helpChanged:(id)sender{
	switch([helpSegment selectedSegmentIndex]){
		case 0:
			textField.text=
			@"Rotation Puzzle\n Swipe left,right, up or down from a tile to rotate 8 adajacent tiles clockwise or counter clockwise";
			break;
		case 1:
			textField.text=@"1";
			break;
		case 2:
			textField.text=@"3";
			break;
	}
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

static int statindex  = 0;

-(void) doanimate{
	int n =2;
	static int startrows[] = {2,2};
	static int startcols[] = {2,1};
	static int orient[]={6,6};
	[puzzleview.pointer setHidden:YES];
 	[puzzleview cycle8: orient[statindex] rowpos:startrows[statindex] colpos:startcols[statindex]];

	//[self.timer1 invalidate];
	//[self.timer2 invalidate];
	sleep(1);
	
	statindex = (statindex+1) % n;
	//self.timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(animatehand) userInfo:nil repeats:YES];

	//self.timer2 = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(doanimate) userInfo:nil repeats:YES];
}


-(void) animatehand{
	
	static int startrows[] = {1,1};
	static int startcols[] = {1,2};
	static int endrows[] = {2,1};
	static int endcols[]={1,0};
	
	
	int row1 = startrows[statindex];
	int col1 = startcols[statindex];
	int row2 = endrows[statindex];
	int col2 = endcols[statindex];
	
	
	[puzzleview.pointer setHidden:NO];	
	[puzzleview bringSubviewToFront:puzzleview.pointer]; 
	[puzzleview.pointer setCenter: [puzzleview positionOfCenterAtRow: row1 col:col1]];
	[puzzleview animateView:puzzleview.pointer
		 toPosition:[puzzleview positionOfCenterAtRow: row2 col:col2]];

	sleep(1);

	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	//[self helpChanged:nil];
    [super viewDidLoad];

	NSString * fileLocation = [[NSBundle mainBundle] pathForResource:@"handiconfinal" ofType:@"png"];
    UIImage * handicon = [[UIImage alloc] initWithContentsOfFile:fileLocation];
	
	puzzleview.pointer = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,32,32)];
	[puzzleview.pointer setImage:handicon];
	[handicon release];
	
	
	[puzzleview.pointer setHidden:YES];
	[puzzleview initWithTiles:4 ncols:4 spacing:1];
	[puzzleview insertSubview: puzzleview.pointer atIndex: 0];

	
	self.timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(animatehand) userInfo:nil repeats:YES];
	self.timer2 = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(doanimate) userInfo:nil repeats:YES];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	

}


- (void)dealloc {
	
    [super dealloc];
}


@end
