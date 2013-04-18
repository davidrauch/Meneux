//
//  DRAppDelegate.m
//  Meneux
//
//  Created by David Rauch on 3/23/13.
//  Copyright (c) 2013 David Rauch. All rights reserved.
//

#import "DRAppDelegate.h"
#import "INWindowButton.h"

@implementation DRAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[_window orderOut:self];
	
	//Hide Traffic Lights
	[[_window standardWindowButton:NSWindowCloseButton] setHidden:YES];
	[[_window standardWindowButton:NSWindowMiniaturizeButton] setHidden:YES];
	[[_window standardWindowButton:NSWindowZoomButton] setHidden:YES];
	
	_window.titleBarHeight = 32;
	
	[_titleField setFont:[NSFont fontWithName:@"AlternateGothic2 BT" size:18]];
	[[_titleField cell] setBackgroundStyle:NSBackgroundStyleRaised];
	[[_window titleBarView] addSubview:_titleBar];
	
	//Set up Webview
	[[_webView preferences] setDefaultFontSize:16];
	[_webView setCustomUserAgent:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_3) AppleWebKit/536.28.10 (KHTML, like Gecko) Version/6.0.3 Safari/536.28.10"];
	[_webView setMainFrameURL:@"https://teuxdeux.com/login"];
	[_webView setFrameLoadDelegate:self];
	[_webView setHidden:YES];
	
	[_loadSpinner setHidden:NO];
	[_loadSpinner startAnimation:self];
	
	//Set Status Item
	NSStatusItem *statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:24];
	_statusItemView = [[StatusItemView alloc] initWithStatusItem:statusItem];
	_statusItemView.image = [NSImage imageNamed:@"Status"];
	_statusItemView.alternateImage = [NSImage imageNamed:@"StatusHighlighted"];
	_statusItemView.action = @selector(toggleWindow:);
	[_statusItemView setMenu:_menu];
}

- (void)windowDidResignKey:(NSNotification *)notification {
	if([_lockButton state] == NSOffState) {
		[_window orderOut:self];
		[_statusItemView setHighlighted:NO];
	}
}

#pragma mark -
#pragma mark FrameLoadDelegate

- (void)webView:(WebView *)sender didCommitLoadForFrame:(WebFrame *)frame {
	[sender setHidden:YES];
	[_loadSpinner setHidden:NO];
	[_loadSpinner startAnimation:self];
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
	DOMDocument* domDocument=[sender mainFrameDocument];
	DOMElement* styleElement=[domDocument createElement:@"style"];
	[styleElement setAttribute:@"type" value:@"text/css"];
	DOMText* cssText=[domDocument createTextNode:@"body>footer, .header-bar,  #lists{display:none !important} #calendar{margin-top: 10px !important}"];
	[styleElement appendChild:cssText];
	DOMElement* headElement=(DOMElement*)[[domDocument getElementsByTagName:@"head"] item:0];
	[headElement appendChild:styleElement];
	[_webView setHidden:NO];
	[_loadSpinner setHidden:YES];
	[_loadSpinner stopAnimation:self];
}

- (void)toggleWindow:(id)sender {
	if([_statusItemView isHighlighted]) {
		[_window orderOut:self];
		[_statusItemView setHighlighted:NO];
	} else {
		[_window setFrameOrigin:NSMakePoint(_statusItemView.globalRect.origin.x - 148, _statusItemView.globalRect.origin.y - 510)];
		[_window makeKeyAndOrderFront:self];
		[NSApp activateIgnoringOtherApps:YES];
		[_statusItemView setHighlighted:YES];
	}
}

@end
