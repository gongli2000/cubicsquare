//
//  SolvedViewController.h
//  Camera
//
//  Created by James Eclipse on 8/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchUIView.h"
#import "Constants.h"
@interface SolvedViewController : UIViewController {
	IBOutlet TouchUIView * solvedView;
	ImageType imageType;
	UIImage* solvedImage;
	int nrows;
	int ncols;
}
@property (nonatomic) ImageType imageType;
@property (nonatomic,retain) TouchUIView* solvedView;
@property (nonatomic,retain) UIImage *solvedImage;

-(IBAction) dismiss:(id)sender;
-(void) init:(UIImage*)image imageType:(ImageType) imagetType nrows:(int)rows ncols:(int)cols;
@end
