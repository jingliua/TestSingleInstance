//
//  ViewController.m
//  TestSingleInstance
//
//  Created by liujing on 16/6/6.
//  Copyright © 2016年 liujing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    TestSingleInstanceClass *objct1 = [TestSingleInstanceClass sharedInstance];
    NSLog(@"%@",objct1);
//     TestSingleInstanceClass *objct2 = [TestSingleInstanceClass sharedInstance];
    TestSingleInstanceClass *objct2 = [[TestSingleInstanceClass alloc] init];
    NSLog(@"%@",objct2);
//     TestSingleInstanceClass *objct3 = [TestSingleInstanceClass sharedInstance];
    TestSingleInstanceClass *objct3 = [TestSingleInstanceClass new];
    NSLog(@"%@",objct3);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



@interface TestSingleInstanceClass ()

@property (assign, nonatomic)   int                         height;
@property (strong, nonatomic)   NSObject                    *object;
@property (strong, nonatomic)   NSMutableArray              *arrayM;

@end

@implementation TestSingleInstanceClass


/**
 *  经过实验证明，一般格式实现的单例只有每次调用都通过shareInstance来拿到才会是同一个实例，而其他方式如自己new会创建新的实例。而严格的单例实现是需要重写allocWithZone方法，然后把初始化的方法也放在dispatch_once里面！！！这样才能保证生成了一个实例且未改变此实例的属性值。
 */
static TestSingleInstanceClass *instance = nil;

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
        instance.height = 10;
        instance.object = [[NSObject alloc] init];
        instance.arrayM = [[NSMutableArray alloc] init];
    });
    return instance;
}

//-(instancetype)init{
//    self = [super init];
//    if (self) {
//        _height = 10;
//        _object = [[NSObject alloc] init];
//        _arrayM = [[NSMutableArray alloc] init];
//    }
//    return self;
//}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (NSString *)description
{
    NSString *result = @"";
    result = [result stringByAppendingFormat:@"<%@: %p>",[self class], self];
    result = [result stringByAppendingFormat:@" height = %d,",self.height];
    result = [result stringByAppendingFormat:@" arrayM = %p,",self.arrayM];
    result = [result stringByAppendingFormat:@" object = %p,",self.object];
    return result;
}
@end