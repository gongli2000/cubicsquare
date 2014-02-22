//
//  SizeSetting.m
//  cubic's square
//
//  Created by James Eclipse on 8/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SizeSetting.h"
#import "MainViewController.h"
#import "Constants.h"


UIImage *scaleAndRotateImage(UIImage *image)
{
	int kMaxResolution = 320; // Or whatever
	
	CGImageRef imgRef = image.CGImage;
	
	CGFloat width = CGImageGetWidth(imgRef);
	CGFloat height = CGImageGetHeight(imgRef);
	
	
	CGAffineTransform transform = CGAffineTransformIdentity;
	CGRect bounds = CGRectMake(0, 0, width, height);
	if (width > kMaxResolution || height > kMaxResolution) {
		CGFloat ratio = width/height;
		if (ratio > 1) {
			bounds.size.width = kMaxResolution;
			bounds.size.height = bounds.size.width / ratio;
		}
		else {
			bounds.size.height = kMaxResolution;
			bounds.size.width = bounds.size.height * ratio;
		}
	}
	
	CGFloat scaleRatio = bounds.size.width / width;
	CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
	CGFloat boundHeight;
	UIImageOrientation orient = image.imageOrientation;
	switch(orient) {
			
		case UIImageOrientationUp: //EXIF = 1
			transform = CGAffineTransformIdentity;
			break;
			
		case UIImageOrientationUpMirrored: //EXIF = 2
			transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			break;
			
		case UIImageOrientationDown: //EXIF = 3
			transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
			transform = CGAffineTransformRotate(transform, M_PI);
			break;
			
		case UIImageOrientationDownMirrored: //EXIF = 4
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
			transform = CGAffineTransformScale(transform, 1.0, -1.0);
			break;
			
		case UIImageOrientationLeftMirrored: //EXIF = 5
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		case UIImageOrientationLeft: //EXIF = 6
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		case UIImageOrientationRightMirrored: //EXIF = 7
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeScale(-1.0, 1.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;
			
		case UIImageOrientationRight: //EXIF = 8
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;
			
		default:
			[NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
			
	}
	
	UIGraphicsBeginImageContext(bounds.size);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
		CGContextScaleCTM(context, -scaleRatio, scaleRatio);
		CGContextTranslateCTM(context, -height, 0);
	}
	else {
		CGContextScaleCTM(context, scaleRatio, -scaleRatio);
		CGContextTranslateCTM(context, 0, -height);
	}
	
	CGContextConcatCTM(context, transform);
	
	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
	UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return imageCopy;
}



@implementation SizeSetting
@synthesize segmentControl,tilePhotoSegment,index,puzzleView,image,showPhotosBtn,puzzleType,imageType;

-(void) viewDidLoad{
	segmentControl.selectedSegmentIndex=index;
	tilePhotoSegment.selectedSegmentIndex=self.imageType;
	int nrows = [self getNumRows];
	switch(self.imageType){
		case kTileType:
			[puzzleView initWithTiles:nrows ncols:nrows spacing:1 rotation:YES	usenum:NO puzzleType:self.puzzleType viewindices:nil];
			break;
		case kNumberType:
			[puzzleView initWithTiles:nrows ncols:nrows spacing:1 rotation:YES	usenum:YES puzzleType:self.puzzleType viewindices:nil];
			break;
		case kPhotoType:
			[puzzleView initWithImage:self.image nrows:nrows ncols:nrows spacing:1 rotation:YES  puzzleType:self.puzzleType viewindices:nil];
			break;
	}
}

-(IBAction)puzzleTypeChanged:(id)sender{
}

-(IBAction)tilePhotoToggleSegmentedControl:(id)sender{
	self.imageType = [self.tilePhotoSegment selectedSegmentIndex];
	switch(self.imageType ){
		case kTileType:
			[self selectTileButton:sender];
			self.showPhotosBtn.hidden=YES;
			break;
		case kPhotoType:
			if(self.image == nil){
				[self selectExistingPicture:sender];
			}else{
				//int nrows=[self getNumRows];
				//[puzzleView initWithImage:self.image nrows:nrows ncols:nrows spacing:1 ];
			}
			self.showPhotosBtn.hidden=NO;
			break;
		case kNumberType:
			[self selectNumberButton:sender];
			self.showPhotosBtn.hidden=YES;
			break;
	}
}

-(IBAction)sizeSettingChanged:(id)sender{
	int nrows = [self getNumRows];
	switch(self.imageType){
		case kTileType:
			[puzzleView initWithTiles:nrows ncols:nrows spacing:1 rotation:YES usenum:NO puzzleType: self.puzzleType viewindices:nil];
			break;
		case kNumberType:
			[puzzleView initWithTiles:nrows ncols:nrows spacing:1 rotation:YES usenum:YES puzzleType: self.puzzleType viewindices:nil];
			break;
		case kPhotoType:
			[puzzleView initWithImage: self.image nrows:nrows ncols:nrows spacing:1 rotation:YES puzzleType:self.puzzleType viewindices:nil];
			break;
	}
}



-(int)getNumRows{
	static int size[] ={4,6,8,9};	
	return size[[segmentControl  selectedSegmentIndex]];
}

-(IBAction) dismiss:(id) sender{
	[(MainViewController*)[self parentViewController] 
		sizeSettingsDidDismiss: [self getNumRows] 
		image:self.image
		puzzleType: kRotationPuzzle
		imageType: [tilePhotoSegment selectedSegmentIndex]];
	[self dismissModalViewControllerAnimated:YES];
}


-(IBAction) cancel:(id) sender{
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
/*
 -(IBAction)getCameraPicture:(id)sender{
 UIImagePickerController* picker = [[[UIImagePickerController alloc] autorelease] init];
 picker.delegate=self;
 picker.allowsImageEditing=YES;
 picker.sourceType=(sender == takePictureButton)?
 UIImagePickerControllerSourceTypeCamera:
 UIImagePickerControllerSourceTypeSavedPhotosAlbum;
 [self presentModalViewController:picker animated:YES] ;
 
 }
 */

-(IBAction)selectExistingPicture:(id)sender{
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
		UIImagePickerController *picker = [[[UIImagePickerController alloc] init] autorelease];
		picker.delegate=self;
		picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
		[self presentModalViewController:picker animated:YES];
	}
}

-(IBAction) selectNumberButton:(id)sender{
	
	int nrows = [self getNumRows];
	[puzzleView initWithTiles:nrows ncols:nrows spacing:1 rotation:YES usenum:YES puzzleType:kRotationPuzzle viewindices:nil];
}

-(IBAction) selectTileButton:(id)sender{
	
	int nrows = [self getNumRows];
	[puzzleView initWithTiles:nrows ncols:nrows spacing:1];
}

#pragma mark -
-(void) imagePickerController:(UIImagePickerController *)picker
		didFinishPickingImage:(UIImage*) ximage
				  editingInfo: (NSDictionary*) editingInfo
{
	int nrows=[self getNumRows];
	self.image =scaleAndRotateImage(ximage);
	[puzzleView initWithImage:self.image nrows:nrows ncols:nrows spacing:1];
	[puzzleView setNeedsDisplay];
	
	[picker dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel: (UIImagePickerController *)picker
{
	[picker dismissModalViewControllerAnimated:YES];
	
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
	[segmentControl release];
	[tilePhotoSegment release];
	[puzzleView release];
	[showPhotosBtn release];
	[image release];
    [super dealloc];
}


@end
