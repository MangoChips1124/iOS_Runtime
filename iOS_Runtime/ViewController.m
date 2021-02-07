//
//  ViewController.m
//  iOS_Runtime
//
//  Created by karajan on 2021/2/7.
//  Copyright © 2021 karajan. All rights reserved.
//

#import "ViewController.h"

#import "Person.h"

#import <objc/runtime.h>

@interface ViewController ()

@property (nonatomic,strong) Person *persion;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.persion = [[Person alloc] init];
    self.persion.name = @"Tom";
    NSLog(@"Name == %@",self.persion.name);
    
    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    testBtn.frame = CGRectMake(100, 100, 100, 40);
    [testBtn setTitle:@"转换" forState:UIControlStateNormal];
    [testBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [testBtn addTarget:self action:@selector(tapChangeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];
    
    
    UIButton *outPutBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    outPutBtn.frame = CGRectMake(100, 200, 100, 40);
    [outPutBtn setTitle:@"输出" forState:UIControlStateNormal];
    [outPutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [outPutBtn addTarget:self action:@selector(tapOutputBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:outPutBtn];
    
}

-(void)tapChangeBtnClick{
    
    NSLog(@"点击测试按钮");
    
    [self changeVarName];
}

-(void)tapOutputBtnClick{
    NSLog(@"点击输出按钮 Name == %@",self.persion.name);
}

//使用runtime改变实例成员的值
-(void)changeVarName{
    //成员变量个数
    unsigned int count = 0;
    
    //获取所有的成员变量
    Ivar *ivar = class_copyIvarList([self.persion class], &count);
    
    //遍历
    for (int i = 0; i<count; i++) {
        //实例变量
        Ivar varV  = ivar[i];
        //实例变量名字
        const char *varName = ivar_getName(varV);
        //转化一下
        NSString *name = [NSString stringWithUTF8String:varName];
        if([name isEqualToString:@"_name"]){
            object_setIvar(self.persion, varV, @"Jerry");
            break;
        }
    }
}

@end
