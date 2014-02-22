//
//  SizeSetting.h
//  cubic's square
//
//  Created by James Eclipse on 8/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchUIView.h"
#import "Constants.h"

@interface SizeSetting : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
	IBOutlet UISegmentedControl* segmentControl;
	IBOutlet UISegmentedControl* tilePhotoSegment;
	IBOutlet TouchUIView* puzzleView;
	IBOutlet UIButton* showPhotosBtn;
	UIImage* image;
	int index;
	PuzzleType	puzzleType;
	ImageType   imageType;
}
@property (nonatomic) PuzzleType puzzleType;
@property (nonatomic) ImageType imageType;
@property (nonatomic,retain) UIButton* showPhotosBtn;
@property (nonatomic,retain) UIImage *image;
@property (nonatomic,retain) TouchUIView* puzzleView;
@property (nonatomic,retain) UISegmentedControl* segmentControl;
@property (nonatomic,retain) UISegmentedControl* tilePhotoSegment;
@property (nonatomic) int index;

-(IBAction)selectNumberButton:(id)sender;
-(IBAction)tilePhotoToggleSegmentedControl:(id)sender;
-(IBAction)puzzleTypeChanged:(id)sender;
-(IBAction) cancel:(id) sender;
-(IBAction) selectTileButton:(id)sender;
-(IBAction)sizeSettingChanged:(id)sender;
-(IBAction) dismiss:(id)sender;
-(IBAction)selectExistingPicture:(id)sender;

@end
