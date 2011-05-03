/*
 LooperAppDelegate.h
 
 Looper - A utility app to continuously loop a set of sound files.
 Copyright (C) 2011 Eduardo Gonzalez
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#import <Cocoa/Cocoa.h>

@interface LooperAppDelegate : NSObject <NSApplicationDelegate, 
                                         NSTableViewDataSource,
                                         NSTableViewDelegate> {
    NSWindow *window;
    NSButton *playButton;
    NSButton *stopButton;
    NSButton *addFileButton;
    NSButton *removeFileButton;
    NSTableView *filesView;
    
    NSMutableDictionary *loops;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSButton *playButton;
@property (assign) IBOutlet NSButton *stopButton;
@property (assign) IBOutlet NSButton *addFileButton;
@property (assign) IBOutlet NSButton *removeFileButton;
@property (assign) IBOutlet NSTableView *filesView;

- (IBAction)addFileButtonDidClick:(id)sender;
- (IBAction)removeFileButtonDidClick:(id)sender;
- (IBAction)playButtonDidClick:(id)sender;
- (IBAction)stopButtonDidClick:(id)sender;

@end
