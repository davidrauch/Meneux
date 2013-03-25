//
//  DRBackgroundView.m
//  Meneux
//
//  Created by David Rauch on 3/24/13.
//  Copyright (c) 2013 David Rauch. All rights reserved.
//

#import "DRBackgroundView.h"

@implementation DRBackgroundView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor whiteColor] set];
	NSRectFill(dirtyRect);
}

@end
