//
//  SolvedViewController.m
//  Camera
//
//  Created by James Eclipse on 8/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SolvedViewController.h"


@implementation SolvedViewController
@synthesize solvedView,solvedImage,imageType;

-(void) init:(UIImage*)image imageType:(ImageType) imagetype nrows:(int)rows ncols:(int)cols
{
	self.solvedImage =image;
	self.imageType = imagetype;
	nrows=rows;
	ncols=cols;
}

-(IBAction) dismiss:(id)sender{
	[self dismissModalViewControllerAnimated:YES];
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	CGSize imgSize = [solvedImage  size];
	CGSize frameSize = [self.solvedView  bounds].size;
	switch(self.imageType){
		case kTileType:
			[solvedView initWithTiles:nrows ncols:nrows spacing:1 rotation:YES	usenum:NO puzzleType:kJigsawPuzzle viewindices:nil];
			break;
		case kNumberType:
			[solvedView initWithTiles:nrows ncols:nrows spacing:1 rotation:YES	usenum:YES puzzleType:kJigsawPuzzle viewindices:nil];
			break;
		case kPhotoType:
			[solvedView initWithImage:self.solvedImage nrows:nrows ncols:nrows spacing:1 rotation:YES  puzzleType:kJigsawPuzzle viewindices:nil];
			break;
	}
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
	[solvedView release];
	[solvedImage release];
	
    [super dealloc];
}


@end
