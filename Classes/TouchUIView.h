//
//  TouchUIView.h
//  setUIImageViewProgrammatically
//
//  Created by James Eclipse on 8/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#include "TileView.h"
#define GROW_ANIMATION_DURATION_SECONDS .25    // Determines how fast a piece size grows when it is moved.
#define SHRINK_ANIMATION_DURATION_SECONDS 0.5  // Determines how fast a piece size shrinks when a piece stops moving.
#define ROTATEVIEWDURATION .5
#define TRANSLATEVIEWDURATION .1

#define PI   3.14159265358979323846264338327950288418
#define degreesToRadians(x) (M_PI * x / 180.0)
#define kJIGSAW 1
#define kRUBIK 2
#define kTilePuzzle 1
#define kImagePuzzle 2

@interface TouchUIView : UIView {
	NSMutableArray *viewArray;
	NSMutableArray* viewIndices;
	UIView *saveView;
	UIImage* saveImage;
	int nrows;
	int ncols;
	int viewTileWidth;
	int viewTileHeight;
	int nTiles;
	int curColPosition;
	int curRowPosition;
	int vacantRow;
	int vacantCol;
	int tilespacing;
	int numMoves;
	UIColor* color;
	UILabel* nummoveslabel;
	UILabel* helpLabel;
	BOOL rotation;
	int theNumber;
	BOOL alreadyMoved;
	PuzzleType puzzleType;
	ImageType imageType;
	CGPoint anchorPoint;
	UIImageView* pointer;
}
@property (nonatomic,retain) UIImage* saveImage;
@property (nonatomic) BOOL alreadyMoved;
@property (nonatomic) PuzzleType puzzleType;
@property (nonatomic) ImageType imageType;
@property (nonatomic) int nrows,ncols,tilespacing,vacantRow,vacantCol,numMoves;
@property (nonatomic,retain) NSMutableArray *viewArray,*viewIndices;
@property (nonatomic,retain) UIView *saveView;
@property (nonatomic,retain) UIImageView *pointer;
@property (nonatomic,retain) UIColor* color;
@property (nonatomic,retain) UILabel* nummoveslabel;
@property (nonatomic,retain) UILabel* helpLabel;
@property (nonatomic) BOOL rotation;

-(void) reset;
-(void) shuffleViews;
-(CGPoint)indicesToCenter:(int)row col:(int)col;
-(void)initWithTiles:(int)numRows ncols:(int)numCols spacing:(int)space;
-(void)initWithImage:(UIImage*)img nrows:(int)numRows ncols:(int)numCols spacing:(int)space;
-(CGPoint) positionOfCenterAtRow:(int)row col:(int) col;
-(void) setpointer:(int)row col:(int)col;
-(void)animateView:(UIView *)theView toPosition:(CGPoint)thePosition duration:(float)duration;
-(void)cycle8:(int)indexIncrement rowpos:(int)row colpos:(int)col duration:(float)xduration;
-(void)cycle8:(int)indexIncrement rowpos:(int)row colpos:(int)col;
-(float) getDuration;
//-(void) doDoubleTap;
@end
