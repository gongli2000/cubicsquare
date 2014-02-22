//
//  TouchUIView.m
//  setUIImageViewProgrammatically
//
//  Created by James Eclipse on 8/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TouchUIView.h"

#include <stdlib.h>

#import "Constants.h"

@implementation TouchUIView
@synthesize viewArray,viewIndices,saveImage;
@synthesize saveView,pointer;
@synthesize color,helpLabel;
@synthesize nrows,ncols,rotation,tilespacing,puzzleType,imageType,vacantRow,vacantCol,alreadyMoved,numMoves,nummoveslabel;
/*
 + (UIColor *)blackColor;      // 0.0 white 
 + (UIColor *)darkGrayColor;   // 0.333 white 
 + (UIColor *)lightGrayColor;  // 0.667 white 
 + (UIColor *)whiteColor;      // 1.0 white 
 + (UIColor *)grayColor;       // 0.5 white 
 + (UIColor *)redColor;        // 1.0, 0.0, 0.0 RGB 
 + (UIColor *)greenColor;      // 0.0, 1.0, 0.0 RGB 
 + (UIColor *)blueColor;       // 0.0, 0.0, 1.0 RGB 
 + (UIColor *)cyanColor;       // 0.0, 1.0, 1.0 RGB 
 + (UIColor *)yellowColor;     // 1.0, 1.0, 0.0 RGB 
 + (UIColor *)magentaColor;    // 1.0, 0.0, 1.0 RGB 
 + (UIColor *)orangeColor;     // 1.0, 0.5, 0.0 RGB 
 + (UIColor *)purpleColor;     // 0.5, 0.0, 0.5 RGB 
 + (UIColor *)brownColor;      // 0.6, 0.4, 0.2 RGB 
 + (UIColor *)clearColor; 
 */



UIColor* getColor(int row,int col,int nrows){
	UIColor* theColor;
	int nrows2 = nrows/2;
	switch(nrows){
		case 4:
		case 6:
		case 8:
			if((row<nrows2) && (col < nrows2)){
				theColor = [UIColor redColor];
			}else if((row <nrows2) && (col >= nrows2)){
				theColor= [UIColor blueColor];
			}else if((row >=nrows2) && (col < nrows2)){
				theColor=[UIColor orangeColor];
			}else{
				theColor = [UIColor greenColor];
			}
			break;
		case 11:
			if((row >1) && (row < 6) && (col > 1) && (col < 6)){
				theColor = [UIColor cyanColor];
			}else{
				if((row<nrows2) && (col < nrows2)){
					theColor = [UIColor redColor];
				}else if((row <nrows2) && (col >= nrows2)){
					theColor= [UIColor blueColor];
				}else if((row >=nrows2) && (col < nrows2)){
					theColor=[UIColor orangeColor];
				}else{
					theColor = [UIColor greenColor];
				}
			}
			break;
		case 9:
		{
			int rowmod = row / 3;
			int colmod = col / 3;
			NSArray* colors = [[NSArray alloc]   initWithObjects: 
							   [UIColor greenColor],
							   [UIColor blueColor],
							   [UIColor cyanColor],
							   [UIColor yellowColor],
							   [UIColor magentaColor],
							   [UIColor orangeColor],
							   [UIColor purpleColor],
							   [UIColor brownColor],
							   [UIColor redColor],
							   nil];
			theColor=[colors objectAtIndex: rowmod + 3*colmod];
			[colors release];
		} 
	}
	
	return theColor;
}
-(CGPoint) indices2Center:(int) row col:(int) col
{
	return CGPointMake(col*viewTileWidth+viewTileWidth/2 + tilespacing*col, row*viewTileHeight+viewTileHeight/2 + tilespacing*row);
}

-(int) rowcol2index:(int) row col:(int)col{
	return row * self.ncols + col;
}

-(void) replaceViewAt:(int)row col:(int)col withValue:(int)newvalue
{
	[viewIndices replaceObjectAtIndex: [self rowcol2index:row col:col] 
						   withObject: [NSNumber numberWithInt:newvalue]];
}

-(CGPoint) positionOfCenterAtRow:(int)row col:(int)col{
	return [self indices2Center:row col:col];
}

-(UIView*) viewAtRowCol:(int)row col:(int)col{
	
	int index = [self rowcol2index:row col:col];
	int viewindex =  [[viewIndices objectAtIndex: index] intValue];
	return [viewArray objectAtIndex: viewindex];
}

-(void) setPositionOfViews{
	float duration = [self getDuration];
	for(int row=0; row<nrows; row++){
		for(int col=0;col<ncols;col++){
			[self animateView:[self viewAtRowCol:row col:col] toPosition:[self indices2Center: row col:col] duration:duration];
		}
	}
}

-(void)awakeFromNib{
	rotation=YES;
}

-(void) initWithTiles: (int)numRows ncols:(int)numCols spacing:(int)space{
	[self initWithTiles:numRows ncols:numCols spacing:space rotation:rotation usenum:NO puzzleType:self.puzzleType
			viewindices:(NSMutableArray*)nil];
}

-(NSString*) helpString{
	switch(self.puzzleType){
		case kRotationPuzzle:
			return @"Swipe a tile to the left, right, up or down to rotate 8 adjacent tiles.";
			break;
		case k16Puzzle:
			return @"Drag sections of row or column towards vacant space.";
			break;
		case kJigsawPuzzle:
			return @"Drag tile to another tile to exchange positions.";
			break;
	}
}


-(void) initWithTiles: (int)numRows ncols:(int)numCols spacing:(int)space rotation:(BOOL)rot usenum:(BOOL)usenum
		   puzzleType:(PuzzleType)puzzletype viewindices:(NSMutableArray*)viewindices
{
	srand(time(NULL));
	
	
	[self resetNumMoves];
	self.imageType = usenum==YES ?  kNumberType:  kTileType;
	self.puzzleType = puzzletype;
	tilespacing=space;
	self.nrows=numRows;
	ncols=numCols;
	rotation=rot;
	self.vacantRow = (nrows-1);
	self.vacantCol= (ncols-1);
	
	self.nummoveslabel = [self viewWithTag:100];
	if(self.nummoveslabel!=nil){
		UILabel* helplabel = [self viewWithTag:200];
		if(helplabel!=nil){
			helplabel.text = [self helpString];
		}
	}
	
	for(UIView *v in [self subviews]){
		if([v isKindOfClass:[TileView class]] || [v isKindOfClass: [UIImageView class]]){
			[v removeFromSuperview];
		}
	}
	
	
	[self setViewArray : [[[NSMutableArray alloc] initWithCapacity:nrows*ncols] autorelease]];
	
	if(viewindices == nil){
		self.viewIndices =   [[[NSMutableArray alloc] initWithCapacity:nrows*ncols] autorelease];
	}else{
		self.viewIndices = viewindices;
	}
	
	CGSize frameSize = [self bounds].size;
	int labelheight = (nummoveslabel!=nil)?kLabelHeight:0;
	int tileHeight = (frameSize.height-labelheight)/self.nrows;
	int tileWidth = frameSize.width/self.ncols;
	viewTileWidth = tileWidth;
	viewTileHeight = tileHeight;
	

	for(int row=0;row < self.nrows; row++){
		int top =row*tileHeight;
		int bottom = top+tileHeight;
		for(int col=0;col<ncols;col++){
			int left = col*tileWidth;
			int right = left+tileWidth;
			UIColor* theColor = getColor(row,col,nrows);
			TileView* v = [[TileView alloc] initWithFrame:CGRectMake(0,0,tileWidth,tileHeight) 
													color:theColor 
												   usenum:usenum
												   number: row*nrows+col+1];
			//[v setCenter: CGPointMake(col*tileWidth+tileWidth/2 + tilespacing*col, row*tileHeight+tileHeight/2 + tilespacing*row)];
			CGPoint p = [self indices2Center:row col:col];
			[v setCenter: p];
			
			if((self.puzzleType == k16Puzzle) && (row==(nrows-1)) && (col == (ncols-1))){
				[v setHidden:YES];
			}
			[self insertSubview: v atIndex: 0];
			[viewArray addObject: v];
			if(viewindices == nil){
				[viewIndices addObject: [NSNumber numberWithInt: [self rowcol2index:row col:col]]];
			}
			
			[v release];
		}
	}	
	
	[self setPositionOfViews];
}

// return rand between [1,bound-2];
int intervalRand(int bound){
	//return rand() % (bound -2)+1;
	return rand() % bound;
}
int intervalRand2(int bound){
	return rand() % (bound -2)+1;
}
int intrand(int bound){
	return rand() % bound;
}
-(void) setpointer:(int) row col:(int)col{
	CGPoint p = [self indices2Center:0 col:0];
	self.pointer.center = p;
}





-(void)initWithImage:(UIImage*)image nrows:(int)numRows ncols:(int)numCols spacing:(int)space{
	[self initWithImage:image  nrows:numRows ncols:numCols spacing:space
			   rotation:rotation puzzleType:self.puzzleType viewindices:nil];
}

-(void)initWithImage:(UIImage*)image nrows:(int)numRows ncols:(int)numCols spacing:(int)space rotation:(BOOL)rot
		  puzzleType:(PuzzleType)puzzletype viewindices:(NSMutableArray* )viewindices
{
	srand(time(NULL));
	
	[self resetNumMoves];
	self.saveImage=image;
	self.imageType = kPhotoType;
	self.puzzleType = puzzletype;
	tilespacing=space;
	nrows=numRows;
	ncols=numCols;
	rotation =rot;
	self.vacantRow = (nrows-1);
	self.vacantCol= (ncols-1);
	
	self.nummoveslabel = [self viewWithTag:100];
	if(self.nummoveslabel!=nil){
		UILabel* helplabel = [self viewWithTag:200];
		if(helplabel!=nil){
			helplabel.text = [self helpString];
		}
	}
	
	for(UIView *v in [self subviews]){
		if([v isKindOfClass:[TileView class]] || [v isKindOfClass: [UIImageView class]]){
			[v removeFromSuperview];
		}
	}
	
	
	
	[self setViewArray:[[[NSMutableArray alloc] initWithCapacity:nrows*ncols] autorelease]];
	if(viewindices == nil){
		self.viewIndices =   [[[NSMutableArray alloc] initWithCapacity:nrows*ncols] autorelease];
	}else{
		self.viewIndices = viewindices;
	}
	

	CGSize imgSize = [image size];
	CGSize frameSize = [self bounds].size;
	
	int tileWidth = imgSize.width/ncols;
	int tileHeight = imgSize.height/nrows;
	int labelheight = (nummoveslabel!=nil)?kLabelHeight:0;
	viewTileWidth = frameSize.width/ncols;
	viewTileHeight = (frameSize.height-labelheight)/nrows;
	
	CGImageRef imageRef;
	CGImageRef saveImageRef = CGImageCreateCopy([image CGImage]);
	
	for(int row=0;row <nrows; row++){
		int top =row*tileHeight;
		int bottom = top+tileHeight;
		
		for(int col=0;col<ncols;col++){
			int left = col*tileWidth;
			int right = left+tileWidth;
			imageRef = CGImageCreateWithImageInRect(saveImageRef, CGRectMake(left,top,tileWidth,tileHeight));
			UIImageView* v = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,viewTileWidth,viewTileHeight)];
			//[v setClipsToBounds:TRUE];
			
			[v setImage: [UIImage imageWithCGImage: imageRef]];
			[v setCenter: CGPointMake(col*viewTileWidth+viewTileWidth/2 + tilespacing*col, row*viewTileHeight+viewTileHeight/2 + tilespacing*row)];
	
			if((self.puzzleType == k16Puzzle) && (row==(nrows-1)) && (col == (ncols-1))){
				[v setHidden:YES];
			}
			[self insertSubview: v atIndex: 0];
			CGImageRelease(imageRef);
			[viewArray addObject: v];
			[v release];
			if(viewindices == nil){
				[viewIndices addObject: [NSNumber numberWithInt: [self rowcol2index:row col:col]]];
			}
			//[tv release];
		}
		
	}
	CGImageRelease(saveImageRef);
	[self setPositionOfViews];
}






- (UIView*) viewAtPosition:(CGPoint)position{
	
	int x = position.x/viewTileWidth;
	int y = position.y/viewTileHeight;	
	UIView *v = nil;
	if(x < ncols && y < nrows){
		
		v= [self viewAtRowCol:y col:x];
	}
	return v;
	
	
}










-(void) swapViews: (int)oRow  oldCol:(int)oCol
		   newRow:(int)nRow newCol:(int)nCol
{
	UIView *oView = [self viewAtRowCol:oRow col:oCol];
	UIView *nView = [self viewAtRowCol:nRow col:nCol];
	int oldindex = [self rowcol2index:oRow col:oCol];
	int newindex = [self rowcol2index:nRow col:nCol];

	[self replaceViewAt:oRow col:oCol withValue: newindex];
	[self replaceViewAt:nRow col:nCol withValue: oldindex];
	
	//[oView setCenter: [self indices2Center: nRow col:nCol]];
	//[nView setCenter: [self indices2Center: oRow col:oCol]];
	[self animateView:oView toPosition:[self indices2Center: nRow col:nCol]];
	[self animateView:nView toPosition:[self indices2Center: oRow col:oCol]];
	
}



-(CGPoint) getCGPoint:(CGPoint) position{
	return CGPointMake(position.x/viewTileWidth, position.y/viewTileHeight);
}



-(void) translateView:(UIView*)view x:(int)x y:(int)y
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:TRANSLATEVIEWDURATION];
	
	
	//[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:view cache:YES];
	//[(UIImageView)view setImage: view.image] = UIImageOrientationRightMirrored;
	//view.center=view.center;
	//UIImage *im =[(UIImageView*)view image];
	view.transform = CGAffineTransformConcat(view.transform, CGAffineTransformMakeTranslation(x,y));
	
	[UIView commitAnimations];	
	
}

#pragma mark -
#pragma mark SHuffle Views
-(IBAction) shuffleViews{
	[self resetNumMoves];
	if(viewArray!=nil){
		
		switch(self.puzzleType){
			case kRotationPuzzle:
				[self rotationShuffle];
				break;
			case kJigsawPuzzle:
				[self jigSawShuffle];
				break;
			case k16Puzzle:
				[self sixteenShuffle];
				break;
		}
	}
}

-(void)rotationShuffle{
	int ntotal = nrows;
	for(int i=0; i<ntotal ;i++){
		//[self rotateView:[[viewArray objectAtIndex: intervalRand(nrows)] objectAtIndex:intervalRand(ncols)] angle:180.0];
		//[self swapViews: intervalRand(nrows) oldCol: intervalRand(ncols) newRow:intervalRand(nrows) newCol: intervalRand(ncols) ];
		int row = intervalRand2(nrows);
		int col = intervalRand2(ncols);
		
		if(intrand(4) < 2){
			[self doSingleTap: row col: col];
		}else{
			[self doSingleTap: (-1)*row col:col];
		}		
	}
}

-(void)jigSawShuffle{
	int ntotal = nrows;
	for(int i=0; i<ntotal ;i++){
		[self rotateView:[self viewAtRowCol:intervalRand(nrows) cols:intervalRand(ncols)] angle:90.0];
		[self swapViews: intervalRand(nrows) oldCol: intervalRand(ncols) newRow:intervalRand(nrows) newCol: intervalRand(ncols) ];
	}
}

-(void)sixteenShuffle{
	int ntotal = nrows*ncols;
	int rows[] = {-1,1,0,0};
	int cols[] = {0,0,-1,1};
	/*
	 int rowsUL[] ={0,1};
	 int colsUL[] = {1,0};
	 int rowsUR[] ={0,1};
	 int colsUR[]={-1,0};
	 int rowsLR[]={-1,0};
	 int colsLR[]={0,-1};
	 int rowsLL[]={-1,0};
	 int colsLL[]={0,1};
	 int rowsupper[]={0,0,1};
	 int colsupper[]={-1,1,0};
	 int rowslower[]={0,0,-1};
	 int colslower[] ={-1,1,0};
	 int rowsleft[]={-1,1,0};
	 int colsleft[]={0,0,1};
	 int rowsright[]={-1,1,0};
	 int colsright[]={0,0,-1};
	 */
	for(int i=0;i<ntotal;i++){
		int n = intrand(4);
		int row = rows[n] + vacantRow;
		int col= cols[n] + vacantCol;
		if((row >=0) && (row < nrows) && (col >=0) && (col < ncols)){
			[self swapViews: vacantRow oldCol: vacantCol newRow:row newCol: col];
			vacantRow=row;
			vacantCol=col;
		}
	}
}




-(void)rotateView:(UIView*) view angle:(int)angle{
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:ROTATEVIEWDURATION];
	
	
	//[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:view cache:YES];
	//[(UIImageView)view setImage: view.image] = UIImageOrientationRightMirrored;
	//view.center=view.center;
	//UIImage *im =[(UIImageView*)view image];
	view.transform =  CGAffineTransformConcat(view.transform,CGAffineTransformMakeRotation (degreesToRadians(90.0)));
	//view.transform = CGAffineTransformConcat(view.transform, CGAffineTransformMakeTranslation(-30,-30));
	
	[UIView commitAnimations];	
	
}

-(void) doCycle:(int)indexIncrement 
{
	[self doCycle:indexIncrement rowpos:curRowPosition colpos:curColPosition];
}
-(void)cycle8:(int)indexIncrement rowpos:(int)row colpos:(int)col{
	[self cycle8:indexIncrement rowpos:row colpos:col duration:[self getDuration]];
}

-(void)cycle8:(int)indexIncrement rowpos:(int)row colpos:(int)col duration:(float)duration{
	int rows[] = {row-1,row-1,row-1,row,row+1,row+1,row+1,row};
	int cols[] = {col-1,col,col+1,col+1,col+1,col,col-1,col-1};
	NSMutableArray* uiviewsindex  = [[NSMutableArray alloc] init];
	int i;
	for(i=0;i<8;i++)
	{
		[uiviewsindex addObject: [viewIndices objectAtIndex: [self rowcol2index:rows[i] col:cols[i]]]];
	}



	
	for(i=0;i<8;i++){
		int nextI = (i+indexIncrement) % 8;
		int viewindex =  [[uiviewsindex objectAtIndex:i] intValue];
		[self replaceViewAt:rows[nextI] col: cols[nextI] withValue: viewindex];
		[self animateView:[viewArray objectAtIndex:viewindex] 
			  toPosition:[self indices2Center: rows[nextI]  col:cols[nextI]]
			duration:duration];
	}

	
	  
	[uiviewsindex release];
}

-(void)cycle4:(int)indexIncrement rowpos:(int)row colpos:(int)col{
	int rows[] = {row-1,row-1,row+1,row+1};
	int cols[] = {col-1,col+1,col+1,col-1};
	NSMutableArray* uiviews  = [[NSMutableArray alloc] init];
	int i;
	for(i=0;i<4;i++)
	{
		[uiviews addObject: [self viewAtRowCol:rows[i]] col: cols[i]];
	}
	
	for(i=0;i<4;i++){
		int nextI = (i+indexIncrement) % 4;
		[self replaceViewAt:rows[nextI] col: cols[nextI] withValue: [self rowcol2index:rows[i] col:cols[i]]];		
		[self animateView:[uiviews objectAtIndex:i] toPosition:[self indices2Center: rows[nextI]  col:cols[nextI]]];
	}
	[uiviews release];
}

-(void)doCycle:(int)indexIncrement rowpos:(int)row colpos:(int)col{
	
	if((row>0) && (row < nrows-1) && (col > 0) && (col < ncols-1)) {
		[self cycle8:indexIncrement rowpos:row colpos:col];
	}else{
		/*
		 int n = 4*(nrows-1);
		 int rows[n];
		 int cols[n];
		 int j=0;
		 for(int i=0;i< ncols;i++,j++){
		 rows[j]=0;
		 cols[j]=i;
		 }
		 for(int i=1;i<nrows;i++,j++){
		 rows[j] =i;
		 cols[j]=ncols-1;
		 }
		 for(int i=ncols-2;i>=0;i--,j++){
		 rows[j]=nrows-1;
		 cols[j]=i;
		 }
		 for(int i=nrows-2;i>=1;i--,j++){
		 rows[j]=i;
		 cols[j]=0;
		 }
		 NSMutableArray* uiviews  = [[NSMutableArray alloc] init];
		 int i;
		 for(i=0;i<n;i++)
		 {
		 [uiviews addObject: [[viewArray objectAtIndex:rows[i]] objectAtIndex: cols[i]]];
		 }
		 
		 for(i=0;i<n;i++){
		 int nextI = (i+indexIncrement) % n;
		 [[viewArray objectAtIndex:rows[nextI]] replaceObjectAtIndex: cols[nextI] withObject:[uiviews objectAtIndex:i]];
		 [self animateView:[uiviews objectAtIndex:i] toPosition:[self indices2Center: rows[nextI]  col:cols[nextI]]];
		 }
		 [uiviews release];
		 */
	}
	
}

-(BOOL) pointOnEdge:(int)row col:(int)col{
	return ((col==0) || (col==(ncols-1)) || (row==0) || (row==(nrows-1)));
}

-(BOOL) curPointOnEdge{
	return [self pointOnEdge: curRowPosition col:curColPosition];
}


-(void) doSingleTap:(int)row col:(int)col{
	//[self doCycle: ([self pointOnEdge:row col:col] ? (nrows-1) : 2) rowpos:row colpos:col];
	if(row>0){
		[self doCycle: 2 rowpos:row colpos:col];
	}else{
		[self doCycle: 6  rowpos:-row colpos:col];
	}
	
}

-(void)doTap:(int)row col:(int)col{
	[self incrMoves];
	if(row>0){
		[self doCycle: 2 rowpos:row colpos:col];
	}else{
		[self doCycle: 6  rowpos:-row colpos:col];
	}
}

-(void) undoTap:(int)row col:(int)col{
	//[self doCycle: ([self pointOnEdge:row col:col] ? (nrows-1) : 2) rowpos:row colpos:col];
	[self incrMoves];
	if(row>0){
		[self doCycle: 6 rowpos:row colpos:col];
	}else{
		[self doCycle: 2  rowpos:-row colpos:col];
	}
}


-(void)doSingleTap {
	[self doSingleTap:curRowPosition col:curColPosition];
}

/*
 -(void) doDoubleTap:(int)row col:(int)col{
 //[self doCycle:[self pointOnEdge:row col:col] ? 3*(nrows-1): 6 rowpos:row colpos:col];
 [self doCycle: 6  rowpos:row colpos:col];
 }
 
 
 -(void) doDoubleTap{
 [self doSingleTap:curRowPosition*(-1) col:curColPosition];
 //[self doCycle: (6)]; //7 == -2 mod 8
 }
 */


-(void) doSingleTapRotate:(int)row col:(int)col{
	[self rotateView:[self viewAtRowCol:row col:col] angle:90.0];
}

-(void)doSingleTapRotate {
	[self doSingleTapRotate:curRowPosition col:curColPosition];
}

-(void) doDoubleTapRotate:(int)row col:(int)col{
	[self rotateView:[self viewAtRowCol:row col:col] angle: -90.0];
}

-(void) doDoubleTapRotate{
	[self doDoubleTapRotate:curRowPosition col:curColPosition];
	//[self doCycle: (6)]; //7 == -2 mod 8
}

#pragma mark -
#pragma mark Touches Began
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	if(nummoveslabel==nil)return;
	self.alreadyMoved=NO;
	switch(self.puzzleType){
		case kRotationPuzzle:
			[self rotateTouchesBegan:touches withEvent:event];
			break;
		case kJigsawPuzzle:
			[self dragTouchesBegan:	touches withEvent:event];
			break;
		case k16Puzzle:
			[self sixteenTouchesBegan:touches withEvent:event];
			break;
	}
	
}
-(void) sixteenTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
	CGPoint touchPoint = [[[event allTouches] anyObject] locationInView:self];
	curColPosition = touchPoint.x/viewTileWidth;
	curRowPosition = touchPoint.y/viewTileHeight;
}

-(void) rotateTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
	CGPoint touchPoint = [[[event allTouches] anyObject] locationInView:self];
	curColPosition = touchPoint.x/viewTileWidth;
	curRowPosition = touchPoint.y/viewTileHeight;
	anchorPoint.x = -1;
	anchorPoint.y=-1;
	/*
	 int numTaps = [[[event allTouches] anyObject] tapCount];
	 if(numTaps == 1){
	 [self performSelector: @selector(doSingleTap) withObject:self afterDelay:.3];
	 
	 }else{
	 [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(doSingleTap) object:self];
	 [self performSelector:@selector(doDoubleTap) withObject:nil afterDelay:.3];
	 }
	 */
	
}

-(void) dragTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
	
	int numTaps = [[[event allTouches] anyObject] tapCount];
	// Enumerate through all the touch objects.
	NSUInteger touchCount = 0;
	for (UITouch *touch in touches) {
		// Send to the dispatch method, which will make sure the appropriate subview is acted upon
		[self dispatchFirstTouchAtPoint:[touch locationInView:self] forEvent:nil numTaps:numTaps];
		touchCount++;  
	}
}
-(void)dispatchFirstTouchAtPoint:(CGPoint)touchPoint forEvent:(UIEvent *)event numTaps:(int)numTaps
{
	
	UIView *v = [self viewAtPosition: touchPoint];
	if(v!=nil){
		self.saveView = v;
		[self bringSubviewToFront: saveView];
		curColPosition = touchPoint.x/viewTileWidth;
		curRowPosition = touchPoint.y/viewTileHeight;
		if((curColPosition >0 ) && (curColPosition <(ncols-1)) && (curRowPosition >0) && (curRowPosition < (nrows-1)))
		{
			//[self animateFirstTouchAtPoint:touchPoint forView:v];
			if(numTaps >= 2){
				[self rotateView:v angle:180];
			}
		}
	}
	
}


#pragma mark -
#pragma mark Touches Began
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{  
	if(nummoveslabel==nil)return;
	switch(self.puzzleType){
		case kRotationPuzzle:
			[self rotateTouchesMoved: touches withEvent:event];
			break;
		case kJigsawPuzzle:
			[self dragTouchesMoved: touches withEvent: event];
			break;
		case k16Puzzle:
			[self sixteenTouchesMoved: touches withEvent:event];
			break;
	}
	self.alreadyMoved = YES;
}
-(void)rotateTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{ 
	CGPoint touchPoint = [[[event allTouches] anyObject] locationInView:self];
	int endcolpos = touchPoint.x/viewTileWidth;
	int endrowpos = touchPoint.y/viewTileHeight;
	
	
	
}

-(void)dragTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{ 
	// Enumerates through all touch objects
	for (UITouch *touch in touches) {
		// Send to the dispatch method, which will make sure the appropriate subview is acted upon
		CGPoint position = [touch locationInView:self];
		
		
		int colpos =  position.x/viewTileWidth;
		int rowpos = position.y/viewTileHeight;
		
		//if((curColPosition >0 ) && (curColPosition <(ncols-1)) && (curRowPosition >0) && (curRowPosition < (nrows-1))){
		UIView* newView =nil;
		
		if((colpos != curColPosition)  || (rowpos != curRowPosition)){
			newView = [self viewAtPosition: position] ;
			if(newView != nil)
			{
				//[self animateFirstTouchAtPoint:position forView:newView];
			}
			
		}
		
		[self animateView:saveView toPosition:position]; 
		
		//}
	}
}


-(void) sixteenTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{	
	CGPoint touchPoint = [[[event allTouches] anyObject] locationInView:self];
	int endcolpos = touchPoint.x/viewTileWidth;
	int endrowpos = touchPoint.y/viewTileHeight;
	
	if(abs(endcolpos - curColPosition) > abs(endrowpos -curRowPosition)){
		if(vacantRow == curRowPosition){
			if(endcolpos > curColPosition){
				if(vacantCol > curColPosition){
					
					for(int col=vacantCol;col > curColPosition;col--){
						[self swapViews:vacantRow oldCol:col newRow:vacantRow newCol:col-1];
					}
					self.vacantCol = curColPosition;
				}
			}else{
				if(vacantCol < curColPosition){
				
					for(int col=vacantCol ; col < curColPosition;col++){
						[self swapViews:vacantRow oldCol:col newRow:vacantRow newCol:col+1];
					}
					self.vacantCol=curColPosition;
				}
			}
		}
	}else{
		if(vacantCol == curColPosition){
			if(endrowpos > curRowPosition){
				if(vacantRow > curRowPosition){
					for(int row=vacantRow;row > curRowPosition;row--){
						[self swapViews:row oldCol:vacantCol newRow:row-1 newCol:vacantCol];
					}
					self.vacantRow = curRowPosition;
				}
			}else{
				if(vacantRow < curRowPosition){
				
					for(int row=vacantRow ; row < curRowPosition;row++){
						[self swapViews:row oldCol:vacantCol newRow:row+1 newCol:vacantCol];
					}
					self.vacantRow = curRowPosition;
				}
			}
		}
	}
}

-(void)resetNumMoves{
	numMoves=0;
	if(nummoveslabel!=nil){
		nummoveslabel.text=[NSString stringWithFormat:@"Number of Moves: %ld",numMoves];
	}
}

-(void) incrMoves{
	++numMoves;
}

#pragma mark -
#pragma mark Touches Ended
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(nummoveslabel==nil)return;
	[self incrMoves];
	
	switch(self.puzzleType){
		case kRotationPuzzle:
			[self rotateTouchesEnded: touches withEvent: event];
			break;
		case kJigsawPuzzle:
			[self dragTouchesEnded: touches withEvent: event];
			break;
		case k16Puzzle:
			[self sixteentouchesEnded: touches withEvent: event];
			break;
	}
}

-(CGPoint) getAnchorTile: (int) orow ocol:(int) ocol newrow:(int)newrow newcol :(int)newcol
{
	int rotrow,rotcol;
	if(abs(newcol - ocol) > abs(newrow - orow)){
		if(newcol > ocol){ // swipe right
			if(ocol < (ncols-1))
			{
				rotrow = orow+1;
				rotcol = ocol+1;
				if(rotcol ==  (ncols-1)){
					rotcol = ocol;
				}
				if(rotrow >=(nrows -1)){
					rotrow=-(orow-1);
					//[self doSingleTap: -rotrow col:rotcol];
				}else{
					//[self doSingleTap:rotrow col:rotcol];
				}
				
			}
		}else{ //swipe left
			if(ocol > 0)
			{
				rotrow = orow+1;
				rotcol = ocol-1;
				if(rotcol ==  0){
					rotcol = ocol;
				}
				if(rotrow >=(nrows -1)){
					rotrow=orow-1;
					//[self doSingleTap:rotrow col:rotcol];
				}else{
					rotrow=-rotrow;
					//[self doSingleTap: -rotrow col:rotcol];
				}
				
			}
		}
	}else{
		if(newrow > orow){ // swipe downn
			if(orow < (nrows-1))
			{
				rotrow = orow+1;
				rotcol = ocol+1;
				if(rotrow ==  (nrows-1)){
					rotrow = orow;
				}
				if(rotcol >=(ncols -1)){
					rotcol=ocol-1;
					//[self doSingleTap:rotrow col:rotcol];
				}else{
					rotrow=-rotrow;
					//[self doSingleTap: -rotrow col:rotcol];
				}
				
			}
		}else{ //swipe up
			if(orow > 0)
			{
				rotrow = orow-1;
				rotcol = ocol+1;
				if(rotrow ==  0){
					rotrow = orow;
				}
				if(rotcol >=(ncols -1)){
					rotcol=ocol-1;
					rotrow=-rotrow;
					//[self doSingleTap: -rotrow col:rotcol];
				}else{
					
					//[self doSingleTap:rotrow col:rotcol];
				}
				
			}
		}
	}
	return CGPointMake(rotrow,rotcol);
}
-(void)rotateTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	
	CGPoint touchPoint = [[[event allTouches] anyObject] locationInView:self];
	int endcolpos = touchPoint.x/viewTileWidth;
	int endrowpos = touchPoint.y/viewTileHeight;
	if((endcolpos == curColPosition) && (endrowpos == curRowPosition)){
		return;
	}
	CGPoint anchor = [self getAnchorTile: curRowPosition ocol:curColPosition newrow:endrowpos newcol:endcolpos];
	[self doSingleTap: anchor.x col:anchor.y];
	/*
	 if(abs(endcolpos - curColPosition) > abs(endrowpos -curRowPosition)){
	 if(endcolpos > curColPosition){ // swipe right
	 if(curColPosition < (ncols-1))
	 {
	 int rotrow = curRowPosition+1;
	 int rotcol = curColPosition+1;
	 if(rotcol ==  (ncols-1)){
	 rotcol = curColPosition;
	 }
	 if(rotrow >=(nrows -1)){
	 rotrow=curRowPosition-1;
	 [self doSingleTap: -rotrow col:rotcol];
	 }else{
	 [self doSingleTap:rotrow col:rotcol];
	 }
	 
	 }
	 }else{ //swipe left
	 if(curColPosition > 0)
	 {
	 int rotrow = curRowPosition+1;
	 int rotcol = curColPosition-1;
	 if(rotcol ==  0){
	 rotcol = curColPosition;
	 }
	 if(rotrow >=(nrows -1)){
	 rotrow=curRowPosition-1;
	 [self doSingleTap:rotrow col:rotcol];
	 }else{
	 
	 [self doSingleTap: -rotrow col:rotcol];
	 }
	 
	 }
	 }
	 }else{
	 if(endrowpos > curRowPosition){ // swipe downn
	 if(curRowPosition < (nrows-1))
	 {
	 int rotrow = curRowPosition+1;
	 int rotcol = curColPosition+1;
	 if(rotrow ==  (nrows-1)){
	 rotrow = curRowPosition;
	 }
	 if(rotcol >=(ncols -1)){
	 rotcol=curColPosition-1;
	 [self doSingleTap:rotrow col:rotcol];
	 }else{
	 [self doSingleTap: -rotrow col:rotcol];
	 }
	 
	 }
	 }else{ //swipe up
	 if(curRowPosition > 0)
	 {
	 int rotrow = curRowPosition-1;
	 int rotcol = curColPosition+1;
	 if(rotrow ==  0){
	 rotrow = curRowPosition;
	 }
	 if(rotcol >=(ncols -1)){
	 rotcol=curColPosition-1;
	 [self doSingleTap: -rotrow col:rotcol];
	 }else{
	 
	 [self doSingleTap:rotrow col:rotcol];
	 }
	 
	 }
	 }
	 }
	 */
}




-(void)dragTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	// Enumerates through all touch object
	
	for (UITouch *touch in touches) {
		// Sends to the dispatch method, which will make sure the appropriate subview is acted upon
		[self dispatchTouchEndEvent:[touch view] toPosition:[touch locationInView:self] ];
	}
	
}

-(void) sixteentouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{	
	/*
	 CGPoint touchPoint = [[[event allTouches] anyObject] locationInView:self];
	 int endcolpos = touchPoint.x/viewTileWidth;
	 int endrowpos = touchPoint.y/viewTileHeight;
	 
	 if(abs(endcolpos - curColPosition) > abs(endrowpos -curRowPosition)){
	 if(vacantRow == curRowPosition){
	 if(endcolpos > curColPosition){
	 if(vacantCol > curColPosition){
	 NSLog(@"swipe to right");
	 for(int col=vacantCol;col > curColPosition;col--){
	 [self swapViews:vacantRow oldCol:col newRow:vacantRow newCol:col-1];
	 }
	 self.vacantCol = curColPosition;
	 }
	 }else{
	 if(vacantCol < curColPosition){
	 NSLog(@"swipe to left");
	 for(int col=vacantCol ; col < curColPosition;col++){
	 [self swapViews:vacantRow oldCol:col newRow:vacantRow newCol:col+1];
	 }
	 self.vacantCol=curColPosition;
	 }
	 }
	 }
	 }else{
	 if(vacantCol == curColPosition){
	 if(endrowpos > curRowPosition){
	 if(vacantRow > curRowPosition){
	 for(int row=vacantRow;row > curRowPosition;row--){
	 [self swapViews:row oldCol:vacantCol newRow:row-1 newCol:vacantCol];
	 }
	 self.vacantRow = curRowPosition;
	 }
	 }else{
	 if(vacantRow < curRowPosition){
	 NSLog(@"swipe to up");
	 for(int row=vacantRow ; row < curRowPosition;row++){
	 [self swapViews:row oldCol:vacantCol newRow:row+1 newCol:vacantCol];
	 }
	 self.vacantRow = curRowPosition;
	 }
	 }
	 }
	 }
	 */
}


// Checks to see which view, or views,  the point is in and then calls a method to perform the closing animation,
// which is to return the piece to its original size, as if it is being put down by the user.
-(void)dispatchTouchEndEvent:(UIView *)theView toPosition:(CGPoint)position
{   
	UIView* v = [self viewAtPosition: position];
	
	int centerx,centery;
	int colpos =  position.x/viewTileWidth;
	int rowpos = position.y/viewTileHeight;
	if(v!=nil 
	   //&& 
	   // (colpos >0 ) && (colpos <(ncols-1)) && (rowpos >0) && (rowpos < (nrows-1))
	   )
	{
		
		//if((curColPosition >0 ) && (curColPosition <(ncols-1)) && (curRowPosition >0) && (curRowPosition < (nrows-1)))
		{
			if((colpos!=curColPosition) || (rowpos!=curRowPosition)){
				[self swapViews: 
				 curRowPosition oldCol:curColPosition
						 newRow:rowpos newCol:colpos];
				
				curColPosition=colpos;
				curRowPosition=rowpos;
			}else{
				[self animateView:saveView toPosition:[self indices2Center:curRowPosition col:curColPosition]]; 
			}
		}
	}else{
		
		[self animateView:saveView toPosition:[self indices2Center:curRowPosition col:curColPosition]]; 
	}
	
}


#pragma mark -
#pragma mark TOuches Canceled

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(nummoveslabel==nil)return;
	// Enumerates through all touch object
	for (UITouch *touch in touches) {
		// Sends to the dispatch method, which will make sure the appropriate subview is acted upon
		[self dispatchTouchEndEvent:[touch view] toPosition:[touch locationInView:self]];
	}
}


// Scales up a view slightly which makes the piece slightly larger, as if it is being picked up by the user.
-(void)animateFirstTouchAtPoint:(CGPoint)touchPoint forView:(UIImageView *)theView 
{
	// Pulse the view by scaling up, then move the view to under the finger.
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:GROW_ANIMATION_DURATION_SECONDS];
	theView.transform = CGAffineTransformMakeScale(1.2, 1.2);
	[UIView commitAnimations];
}

-(float) getDuration{
	float x=1.0;
	switch(self.puzzleType){
		case kRotationPuzzle:
			x=.3;
		case k16Puzzle:
			x= .1;
		case kJigsawPuzzle:
			x= .5;
	}
	return x;
}

// Scales down the view and moves it to the new position. 
-(void)animateView:(UIView *)theView toPosition:(CGPoint)thePosition{
	float dur = [self getDuration];
	[self animateView:theView toPosition:thePosition duration:dur];
}
-(void)animateView:(UIView *)theView toPosition:(CGPoint)thePosition duration:(float)duration
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration: duration];
	// Set the center to the final postion
	//[self bringSubviewToFront:theView];
	theView.center = thePosition;
	// Set the transform back to the identity, thus undoing the previous scaling effect.
	//theView.transform = CGAffineTransformIdentity;
	[UIView commitAnimations];	
}

-(void)scaledownView:(UIView *)theView 
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:SHRINK_ANIMATION_DURATION_SECONDS];
	
	// Set the transform back to the identity, thus undoing the previous scaling effect.
	theView.transform = CGAffineTransformIdentity;
	[UIView commitAnimations];	
}



- (void)dealloc {
	[viewArray release];
	[saveView release];
	[color release];
    [super dealloc];
}


@end
