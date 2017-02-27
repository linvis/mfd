//
//  ViewController.h
//  mfd
//
//  Created by Shlin on 2017/2/5.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (strong) IBOutlet NSButton *search_bt;
@property (strong) IBOutlet NSTextField *text_kw;
//modify fine time select
@property (strong) IBOutlet NSComboBox *md_start_month;
@property (strong) IBOutlet NSComboBox *md_start_year;
@property (strong) IBOutlet NSComboBox *md_stop_month;
@property (strong) IBOutlet NSComboBox *md_stop_year;

@property (strong) IBOutlet NSComboBox *cr_start_month;
@property (strong) IBOutlet NSComboBox *cr_stop_month;

//modify coarse time select
@property (strong) IBOutlet NSComboBoxCell *md_time_coarse;

//modify time type select
@property (strong) IBOutlet NSButton *md_sel_coarse;
@property (strong) IBOutlet NSButton *md_sel_fine;


//modify time or create time select
@property (strong) IBOutlet NSComboBox *time_type;

//file type select
@property (strong) IBOutlet NSComboBox *file_type;

@property (strong) IBOutlet NSButton *name_select;


@property (strong) IBOutlet NSButton *save_search;

@property (strong) IBOutlet NSComboBox *save_list;
@property (strong) IBOutlet NSButton *save_list_select;

@property (strong) IBOutlet NSProgressIndicator *loading;
@property (strong) IBOutlet NSTextField *run_search;

@property (strong) IBOutlet NSComboBox *tags_select;

@end

