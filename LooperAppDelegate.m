/*
 LooperAppDelegate.m
 
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

#import "LooperAppDelegate.h"

@implementation LooperAppDelegate

@synthesize window;
@synthesize playButton;
@synthesize stopButton;
@synthesize addFileButton;
@synthesize removeFileButton;
@synthesize filesView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    loops = [[NSMutableDictionary alloc] init];
}

- (void)addFileButtonDidClick:(id)sender {
    NSOpenPanel *openDialog = [NSOpenPanel openPanel];
    openDialog.canChooseFiles = YES;
    openDialog.canChooseDirectories = NO;
    if ([openDialog runModal] == NSOKButton) {
        NSURL *urlToPlay = openDialog.URL;
        if ([loops objectForKey:urlToPlay] == nil) {
            
            NSSound *loop = [[NSSound alloc] initWithContentsOfURL:urlToPlay 
                                                       byReference:NO];
            loop.loops = YES;
            [loops setObject:loop forKey:urlToPlay];
            [filesView reloadData];
        }
    }
}

- (void)removeFileButtonDidClick:(id)sender {
    NSInteger index = [filesView selectedRow];
    NSArray *keys = [loops allKeys];
    
    NSURL *url = [keys objectAtIndex:index];

    @try {
        NSSound *loop = [loops objectForKey:url];

        if (loop && [loop isPlaying]) {
            [loop stop];
        }

        [loops removeObjectForKey:url];
    }
    @catch (NSException * e) {
    }

    [filesView reloadData];
}

- (void)playButtonDidClick:(id)sender {
    [loops enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
        NSSound *loop = object;
        if (![loop isPlaying]) {
            [loop play];            
        }
    }];
}

- (void)stopButtonDidClick:(id)sender {
    [loops enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
        NSSound *loop = object;
        if ([loop isPlaying]) {
            [loop stop];            
        }
    }];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [loops count];
}

- (id)tableView:(NSTableView *)tableView
        objectValueForTableColumn:(NSTableColumn *)aTableColumn 
        row:(NSInteger)rowIndex {
    
    NSArray *keys = [loops allKeys];
    NSURL *url = [keys objectAtIndex:rowIndex];
    NSArray *pathComponents = [url pathComponents];
    
    
    return [pathComponents objectAtIndex:[pathComponents count] - 1];
}

@end
