//
//  ViewController.m
//  mfd
//
//  Created by LilyC on 2017/2/5.
//  Copyright © 2017年 LilyC. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (NSString*)run_cmd:(NSString*)cmd {
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh"];
    
    [task setArguments: @[@"-c", cmd]];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    
    
    
    NSString *string;
    string = [[NSString alloc] initWithData: data
                                   encoding: NSUTF8StringEncoding];
    
    return string;
    
}

- (NSString*)run_mdfind_cmd:(NSString*)input {
    NSString *base_cmd = @"/Users/LilyC/mfd/mfd";
    
    NSString *cmd;
    cmd = [NSString stringWithFormat: @"%@ -q %@", base_cmd, input];
    NSLog(@"cmd is: %@", cmd);
    NSString *output = [self performSelector:@selector(run_cmd:) withObject:cmd];
    
    return output;
}

- (NSString*)run_ln_cmd:(NSString*)input {
    NSString *base_cmd_1 = @"ln -s";
    NSString *base_cmd_2 = @"/Users/LilyC/Desktop/atest";
    
    NSString *cmd;

    //NSLog(@"cmd is: %@", cmd);
    input = [input stringByReplacingOccurrencesOfString :@" " withString:@"\\ "];
    input = [input stringByReplacingOccurrencesOfString :@"-" withString:@"\\-"];
    input = [input stringByReplacingOccurrencesOfString :@"&" withString:@"\\&"];
    NSRange range=[input rangeOfString:@"/" options:NSBackwardsSearch];

    NSString *file_name = [input substringFromIndex:range.location];
    NSLog(@"file name is: %@", file_name);
    
    
    cmd = [NSString stringWithFormat: @"%@ %@ %@/link_%@", base_cmd_1, input, base_cmd_2,[file_name substringFromIndex:1]];
    
    NSLog(@"the ln command is: %@", cmd);
    
    NSString *output = [self performSelector:@selector(run_cmd:) withObject:cmd];
    
    return output;
}

- (IBAction)button_click:(id)sender {
    
    
    
    NSString *kwString = [self.text_kw stringValue];
    NSLog(@"the button is press");
    NSLog(@"text is: %@", kwString);
    
    //NSTask *task;
   // task = [[NSTask alloc] init];
    //[task setLaunchPath: @"/bin/sh"];
    
    //NSArray *arguments = [NSArray arrayWithObjects: @[@"-c", @"/Users/LilyC/mfd/mfd -q 米家"],nil];
    
    //[task setArguments:arguments];
    
    //NSPipe *pipe = [NSPipe pipe];
    //[task setStandardOutput:pipe];
    
    //NSFileHandle *file = [pipe fileHandleForReading];
    
    //[task launch];

    
    //NSString *output;
    //output = [[NSString alloc] initWithData:[file readDataToEndOfFile] encoding:NSUTF8StringEncoding];
    
    //NSLog(@" %@", output);
    
    NSString *file_list = [self performSelector:@selector(run_mdfind_cmd:) withObject:kwString];
    
    NSLog(@"file list is:%@", file_list);
    
    
    while (1) {
        if ([file_list length] == 0)
            break;
        NSRange range = [file_list rangeOfString:@"\n"];
        
        NSString *file_path = [file_list substringToIndex:range.location];

        NSLog(@"the file path is:%@", file_path);
        
        NSString *file_name = [self performSelector:@selector(run_ln_cmd:) withObject:file_path];
        
        NSLog(@"the length is:%d %d", range.location, [file_list length]);
        NSLog(@"the rest is:%@", file_list);
        file_list = [file_list substringFromIndex:(range.location + 1)];
    }
    
    
    NSArray *fileURLs = [NSArray arrayWithObjects:@"/Users/LilyC/Desktop/atest", nil];
    [[NSWorkspace sharedWorkspace] activateFileViewerSelectingURLs:fileURLs];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}



@end
