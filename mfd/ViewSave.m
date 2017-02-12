//
//  ViewSave.m
//  mfd
//
//  Created by shlin on 2017/2/11.
//  Copyright © 2017年 LilyC. All rights reserved.
//

#import "ViewSave.h"

extern NSString* mfd_data;

@interface ViewSave ()

@end

@implementation ViewSave

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}
- (IBAction)save_ok_click:(id)sender {
    NSString *str_key;
    if ([self.key_name stringValue].length != 0) {
        str_key = [self.key_name stringValue];
        NSLog(@"the key is: %@", str_key);
        NSLog(@"the data is: %@", mfd_data);
        
        NSString *file_path = @"/Users/shlin/Desktop/GuiSearch.txt";
        NSFileManager *file = [NSFileManager defaultManager];
        if ([file fileExistsAtPath:file_path]) {
            NSLog(@"文件已存在");
        } else {
            BOOL sucess = [file createFileAtPath:file_path contents:nil attributes:nil];
            if (sucess == 1) {
                NSLog(@"文件创建成功");
            }else{
                NSLog(@"文件创建失败");
            }
        }
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:file_path];
        //2.寻找文件数据位置
        [fileHandle seekToEndOfFile];
        //3.数据进行编码
        mfd_data = [NSString stringWithFormat:@"GuiSearchkey=%@,data=%@\n", str_key,mfd_data];
        NSData *data = [mfd_data dataUsingEncoding:NSUTF8StringEncoding];//编码
        //4.写数据
        [fileHandle writeData:data];
        //5.关闭文件
        [fileHandle closeFile];
        
        [self dismissController:self];
    } else {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setInformativeText:@"请输入存储名称"];
        [alert runModal];
    }
}
- (IBAction)save_cancel_click:(id)sender {
    [self dismissController:self];
}

@end
