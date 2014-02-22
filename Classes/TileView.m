//
//  TileView.m
//  Camera
//
//  Created by James Eclipse on 8/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TileView.h"


@implementation TileView
@synthesize color,number,usenum;

- (id)initWithFrame:(CGRect)frame color:(UIColor*)theColor usenum:(BOOL)usenumbers number:(int)num {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.color=theColor;
		self.number=num;
		self.usenum =usenumbers;
		if(self.usenum == YES){
			UILabel* label = [[UILabel alloc] initWithFrame:frame];
			label.text=[NSString stringWithFormat:@"%ld",num];
			label.textAlignment = UITextAlignmentCenter;
			label.alpha = .6;
			[self addSubview:label];
			
		}
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}




- (void)drawRect:(CGRect)rect {
    // Drawing code
	[self.color  setFill];
	UIRectFill ([self bounds]);
}

- (void)dealloc {
	[color release];
    [super dealloc];
	
}


@end
