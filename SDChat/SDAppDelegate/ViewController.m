//
//  ViewController.m
//  SDChat
//
//  Created by slowdony on 2017/6/27.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import "ViewController.h"
#import "SDChatViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"聊天";
    self.view.backgroundColor =[UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SDChatViewController *v =[[SDChatViewController alloc]init];
    [self.navigationController pushViewController:v animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
