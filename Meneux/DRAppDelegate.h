//
//  DRAppDelegate.h
//  Meneux
//
//  Created by David Rauch on 3/23/13.
//  Copyright (c) 2013 David Rauch. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "INAppStoreWindow.h"
#import <WebKit/WebKit.h>
#import "StatusItemView.h"

@interface DRAppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate>

@property (assign) IBOutlet INAppStoreWindow *window;
@property (weak) IBOutlet WebView *webView;
@property (weak) IBOutlet NSView *titleBar;
@property (weak) IBOutlet NSTextField *titleField;
@property (weak) IBOutlet NSButton *lockButton;
@property (weak) IBOutlet NSProgressIndicator *loadSpinner;
@property (weak) IBOutlet NSMenu *menu;

@property (strong) StatusItemView* statusItemView;

@end
