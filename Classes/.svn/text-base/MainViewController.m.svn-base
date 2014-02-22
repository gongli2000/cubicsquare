//
//  MainViewController.m
//  Camera
//
//  Created by James Eclipse on 8/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "SolvedViewController.h"
#import "SettingsViewController.h"
#import "TouchUIView.h"
#import "SizeSetting.h"
#import "helpview.h"

@implementation MainViewController
@synthesize solvedImage,puzzleView,nrows,ncols,type;
@synthesize puzzleType,imageType,navItem;



-(NSString*)dataFilePath:(NSString*)fileName
{
	NSString* dirpath= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] ;
						
	NSString*x =[dirpath stringByAppendingPathComponent:fileName];

	return x;
}

-(NSMutableArray*) makePuzzle:(int) nmoves size:(int)nsize
{
	NSMutableArray* moves = [[[NSMutableArray alloc] initWithCapacity:nsize*nsize] autorelease];
	int lastrow=-1;
	int lastcol=-1;
	for(int n =0;n<nmoves;n++){
		int row = intervalRand(nsize);
		int col = intervalRand(nsize);
		while((row==lastrow) && (col == lastcol)){
			row = intervalRand(nsize);
			col=intervalRand(nsize);
		}
		lastrow=row;
		lastcol=col;
		[moves addObject: [NSNumber numberWithInt: [puzzleView rowcol2index:row col:col]]];
	}
	return moves;
}

	
-(void) applicationWillTerminate:(NSNotification*)notification
{
	
	

	
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	
	[dict  setValue: [NSNumber numberWithInt:nrows ] forKey:@"nrows"];
	[dict setValue: [NSNumber numberWithInt:ncols] forKey: @"ncols"];
	[dict setValue:[NSNumber numberWithInt: puzzleType] forKey: @"puzzletype"];
	[dict setValue: [NSNumber numberWithInt: imageType] forKey: @"imagetype"];
	int haveindices= (puzzleView.viewIndices != nil)? 1:0;
	[dict setValue: [NSNumber numberWithInt:haveindices] forKey:@"haveindices"];
	
	[dict writeToFile: [self dataFilePath:@"prefs.plist"] atomically:YES];

	[dict release];
	
	if(haveindices){
		NSMutableDictionary* rootObject = [NSMutableDictionary dictionary];
		[rootObject setValue: puzzleView.viewIndices forKey:@"viewindices"];
		[NSKeyedArchiver archiveRootObject: rootObject toFile: [self dataFilePath:@"viewindices"]];
	}
	
/*	
	if(puzzleView.moves != nil){
		//NSArray* x = puzzleView.moves;
		int *x = malloc(1+ sizeof(int)* 2* [puzzleView.moves count]);
		CGPoint p;
		int index=-1;
		for(int i=0;i<[puzzleView.moves count];i++){
			[[puzzleView.moves objectAtIndex: i] getValue:&p];
			x[++index]=p.x;
			x[++index]=p.y;
		}
		
		NSData *xdata= [NSData dataWithBytes:x length:sizeof(int)*2*[puzzleView.moves count]];
		[xdata writeToFile:[self dataFilePath:@"arraydata" ] atomically:YES];
		
		free(x);
	}
*/
	
	
	if(self.solvedImage !=nil){	
		[UIImagePNGRepresentation(puzzleView.saveImage) writeToFile:[self dataFilePath:@"image.png" ] atomically:YES];
	}
	
	

}

-(IBAction) resetPuzzleView:(id)sender{

	switch(puzzleView.imageType){
		case kPhotoType:
				[puzzleView initWithImage:self.solvedImage nrows:puzzleView.nrows ncols: puzzleView.ncols spacing:puzzleView.tilespacing];
			break;
		case kTileType:
			[puzzleView initWithTiles:puzzleView.nrows ncols: puzzleView.ncols spacing:puzzleView.tilespacing 
							 rotation:YES usenum:NO puzzleType:puzzleView.puzzleType viewindices:nil];
			break;
		case kNumberType:
			[puzzleView initWithTiles:puzzleView.nrows ncols: puzzleView.ncols spacing:puzzleView.tilespacing
							 rotation:YES usenum:YES puzzleType:puzzleView.puzzleType viewindices:nil];
			break;
	}
	[puzzleView setNeedsDisplay];
}

-(IBAction) shuffleViews:(id)sender{
	[puzzleView shuffleViews];
}

-(IBAction) showHelpView:(id) sender{
	helpview *svController = [[[helpview alloc] initWithNibName:@"helpview" bundle:nil] autorelease];
	[self presentModalViewController: svController animated:YES];
}

-(IBAction) showSettingsView:(id) sender{
	SizeSetting *svController = [[[SizeSetting alloc] initWithNibName:@"SizeSetting" bundle:nil] autorelease];
	switch(nrows){
		case 4:
			svController.index=0;
			break;
		case 6:
			svController.index=1;
			break;
		case 8:
			svController.index=2;
			break;
		case 9:
			svController.index=3;
			break;
	}
	svController.puzzleType = self.puzzleType;
	svController.imageType = self.imageType;
	svController.image = self.solvedImage;

	[self presentModalViewController: svController animated:YES];
}





-(IBAction)showSolvedView:(id)sender{
	SolvedViewController *svController = [[[SolvedViewController alloc] initWithNibName:@"SolvedViewController" bundle:nil] autorelease];
	[svController init:self.solvedImage imageType:self.imageType nrows:nrows ncols:ncols];
	[self presentModalViewController: svController animated:YES];
}

-(void) sizeSettingsDidDismiss: (int)rows 
						image:(UIImage*)image
						puzzleType:(PuzzleType)puzzletype
						imageType:(ImageType)imagetype

{
	self.puzzleType = puzzletype;
	self.imageType=imagetype;
	self.solvedImage = image;
	self.nrows=rows;
	self.ncols=rows;
	switch(self.imageType){
		case kTileType:
			[puzzleView initWithTiles: rows ncols:rows spacing: 1 rotation:YES usenum:NO puzzleType:puzzletype viewindices:nil];
			break;
		case kNumberType:
			[puzzleView initWithTiles: rows ncols:rows spacing: 1 rotation:YES usenum:YES puzzleType:puzzletype viewindices:nil];
			break;
		case kPhotoType:
			[puzzleView initWithImage:image nrows:rows ncols:rows spacing:1 rotation:YES puzzleType:puzzletype viewindices:nil];
			break;

	}
	switch(self.puzzleType){
		case kRotationPuzzle:
			navItem.title = @"Cubic's Square";
			break;
		case k16Puzzle:
			navItem.title = @"\"16\" Puzzle";
			break;
		case kJigsawPuzzle:
			navItem.title = @"Jigsaw Puzzle";
			break;
	}
}

-(void) settingsDidDismiss:(UIImage*)tileImage 
				  nrows: (int)rows
				  ncols: (int)cols
				  rotation:(BOOL)rot
{
	if(tileImage !=nil){
	
		self.solvedImage = tileImage;
		self.nrows=rows;
		self.ncols=cols;
		[puzzleView initWithImage: tileImage  nrows:rows ncols:cols spacing:1 rotation:rot];
		/*switch(self.type){
			case 1:
				[puzzleView initWithImage: tileImage  nrows:rows ncols:cols spacing:1 rotation:rot];
				break;
			case 2:
				[puzzleView initWithTiles: rows ncols:cols spacing: 1 rotation:rot];
		}
		*/
		//[puzzleView shuffleViews];
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


-(int) getNumFromDict:(NSMutableDictionary*)dict forKey:(NSString*)key{
	int n;
	NSNumber *number = [dict objectForKey:key];
	[number getValue: &n];
	return n;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	
	NSMutableArray* viewindices = nil;
    [super viewDidLoad];
	self.solvedImage=nil;
	NSMutableArray* moves =nil;
	if([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath:@"prefs.plist"]]){
		NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:[self dataFilePath:@"prefs.plist"]];
		self.nrows= [self getNumFromDict:dict  forKey:@"nrows"];
		self.ncols = [self getNumFromDict:dict forKey:@"ncols"];
		self.puzzleType = [self getNumFromDict:dict forKey:@"puzzletype"];
		self.imageType = [self getNumFromDict:dict forKey:@"imagetype"];
		int haveindices = [self getNumFromDict:dict  forKey:@"haveindices"];
	
		if(haveindices >0){
			NSDictionary * rootObject; rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:[self dataFilePath:@"viewindices"]]; 
			viewindices =  [rootObject valueForKey:@"viewindices"]; 
		}else{
			viewindices = nil;
		}
		
		
		[dict release];
		if((self.imageType == kPhotoType) && [[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath:@"image.png"]]){
			self.solvedImage=  [[UIImage alloc] initWithContentsOfFile:[self dataFilePath:@"image.png"]];
			if(self.solvedImage == nil){
				self.imageType =kTileType;
			}
			
		}
	}else{
		self.nrows=4;
		self.ncols=4;
		self.puzzleType = kRotationPuzzle;
		self.imageType	= kTileType;
	}
	
	UIApplication* app  = [UIApplication sharedApplication];
	[[NSNotificationCenter defaultCenter] 
	 addObserver: self
	 selector:@selector(applicationWillTerminate:)
	 name: UIApplicationWillTerminateNotification
	 object:app];
	
	if(self.solvedImage){
		[self.solvedImage release];
	}
	//self.solvedImage = [UIImage imageNamed:@"Carousel_New York2.png" ];
	
	
	/*self.solvedImage= [UIImage imageWithData:
						[NSData 
							dataWithContentsOfFile: 
								[[NSBundle mainBundle]
									pathForResource:@"Carousel_New York2" 
									ofType:@"png"]]];
	*/

	
	switch(self.imageType){
		case kPhotoType:
			[puzzleView initWithImage: self.solvedImage  nrows:self.nrows ncols:self.ncols spacing:1 rotation:YES 
						   puzzleType:self.puzzleType viewindices:viewindices];
			break;
		case kTileType:
			[puzzleView initWithTiles: self.nrows ncols:self.ncols spacing: 1 rotation:YES usenum:NO 
						   puzzleType:self.puzzleType viewindices:viewindices];
		
			break;
		case kNumberType:
			[puzzleView initWithTiles: self.nrows ncols:self.ncols spacing: 1 rotation:YES usenum:YES puzzleType:self.puzzleType viewindices:viewindices];
			
	}
	switch(self.puzzleType){
		case kRotationPuzzle:
			navItem.title = @"Cubic's Square";
			break;
		case k16Puzzle:
			navItem.title = @"\"16\" Puzzle";
			break;
		case kJigsawPuzzle:
			navItem.title = @"Jigsaw Puzzle";
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
	[puzzleView release];
	[navItem release];
	[solvedImage release];

	
    [super dealloc];
}


@end
