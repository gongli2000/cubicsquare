//
//  MainViewController.h
//  Camera
//
//  Created by James Eclipse on 8/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#define kFileName @"/data.plist"

#import <UIKit/UIKit.h>
#import "Constants.h"

@class TouchUIView;

@interface MainViewController : UIViewController {
	IBOutlet TouchUIView* puzzleView;
	IBOutlet UINavigationItem* navItem;
	UIImage* solvedImage;
	int nrows;
	int ncols;
	int type;
	PuzzleType puzzleType;
	ImageType imageType;
}

@property (nonatomic,retain) UINavigationItem	*navItem;
@property (nonatomic,retain) TouchUIView* puzzleView;
@property (nonatomic,retain) UIImage* solvedImage;
@property (nonatomic) int  nrows,ncols,type;
@property (nonatomic) PuzzleType  puzzleType;
@property (nonatomic) ImageType  imageType;


-(NSString*)dataFilePath;
-(void)applicationWillTerminate:(NSNotification*)notfication;


-(IBAction)rotateSwitchClick:(id)sender;



-(IBAction) showHelpView:(id) sender;
-(IBAction)showSolvedView: (id)sender;
-(IBAction)showSettingsView:(id) sender;
-(void) sizeSettingsDidDismiss: (int)rows 
			image:(UIImage*)image
			puzzleType:(int)puzzleType
			imageType:(int)imageType;

-(void) settingsDidDismiss:(UIImage*)tileImage 
					 nrows: (int)rows
					 ncols: (int)cols
					 rotation:(BOOL) rot;
-(IBAction)shuffleViews:(id)sender;
-(IBAction)resetPuzzleView:(id)sender;
@end
