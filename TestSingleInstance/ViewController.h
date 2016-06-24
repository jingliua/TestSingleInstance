//
//  ViewController.h
//  TestSingleInstance
//
//  Created by liujing on 16/6/6.
//  Copyright © 2016年 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

@interface TestSingleInstanceClass : NSObject

+ (instancetype)sharedInstance;

@end