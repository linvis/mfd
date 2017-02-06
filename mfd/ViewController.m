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

- (IBAction)button_click:(id)sender {
    
    NSString *base_cmd = @"/Users/LilyC/mfd/mfd";
    
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
    
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh"];
    
    //NSArray *arguments;
    //arguments = [NSArray arrayWithObjects: @[@"-c", @"/Users/LilyC/mfd/mfd -q 米家台灯"],nil];
    NSString *cmd;
    cmd = [NSString stringWithFormat: @"%@ -q %@", base_cmd, kwString];
    NSLog(@"cmd is: %@", cmd);
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
    NSLog (@"woop!  got\n%@", string);
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
