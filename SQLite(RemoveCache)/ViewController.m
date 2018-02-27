//
//  ViewController.m
//  SQLite(RemoveCache)
//
//  Created by pengpeng yan on 16/2/16.
//  Copyright © 2016年 peng yan. All rights reserved.
//

#import "ViewController.h"
#import "MenuTableViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *menuID;
@property (weak, nonatomic) IBOutlet UILabel *appKey;
@property (weak, nonatomic) IBOutlet UILabel *dtype;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"菜谱";
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonAction:(id)sender {
   
    MenuTableViewController *menuVC = [[MenuTableViewController alloc] init];
    menuVC.menuID = self.menuID.text;
    menuVC.appKey = self.appKey.text;
    menuVC.dtype = self.dtype.text;
    [self.navigationController pushViewController:menuVC animated:YES];
    
}







@end
