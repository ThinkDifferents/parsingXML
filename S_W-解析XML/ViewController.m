//
//  ViewController.m
//  S_W-解析XML
//
//  Created by mac on 16/6/16.
//  Copyright © 2016年 shi-wei. All rights reserved.
//

#import "ViewController.h"
#import "GDataXMLNode.h"
#ifdef DEBUG
#define Test(...) NSLog(__VA_ARGS__)
#else
#define Test(...)
#endif
#define PATH @"http://bobo.local/xml2.txt"

@interface ViewController ()


@end

@implementation ViewController

- (void)analysisXmlFromPath:(NSString *)path
{
    // 1.将字符串格式的接口转成NSURL格式的接口
    NSURL *url = [NSURL URLWithString:path];
    
    // 2.将接口中的数据值先存储到二进制对象中
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    // 3.创建一个解析xml的工具对象
    GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc]initWithData:data options:0 error:nil];
    
    // 4.让xmlDoc工具对象解析出xml的根节点
    GDataXMLElement *RootElement = [xmlDocument rootElement];
    
    // 5.1.children方法可以获取所有子节点
    NSArray *rootElementArray = [RootElement children];
    Test(@"rootElementArray == %ld",rootElementArray.count);

    // 5.2.子节点的长度
    NSUInteger sonElementCount = [RootElement childCount];
    Test(@"sonElementCount == %ld",sonElementCount);
    
    // 5.3.根据下表获取子节点
    GDataXMLNode *node = [RootElement childAtIndex:0];
    Test(@"node == %@",node);
    
    NSArray *booksAllSonElementArray = [node children];

    
    for (GDataXMLElement *element in booksAllSonElementArray) {
        // 5.4.通过属性值获取指定的属相对象
        GDataXMLNode *attForID = [element attributeForName:@"id"];
        GDataXMLNode *attForLanguage = [element attributeForName:@"language"];
        // 5.4.1.获取所有属性
        //NSArray *allArr = [element attributes];
        
        // 通过属相对象获取属性值
        NSString *attForIDStr = [attForID stringValue];
        Test(@"attForIDStr = %@",attForIDStr);
        NSString *attForLanguageStr = [attForLanguage stringValue];
        Test(@"attForLanguageStr = %@",attForLanguageStr);
        
         NSArray *bookAllSonElementArray = [element children];
        for (GDataXMLElement *e in bookAllSonElementArray) {
            NSString *bookName = [e stringValue];
            Test(@"bookName = %@",bookName);
        }
    }
    NSArray *elements = [RootElement elementsForName:@"books"];
    Test(@"elements = %ld",elements.count);
    
    NSArray *Xpath = [RootElement nodesForXPath:@"//name" error:nil];
    Test(@"Xpath = %@",[Xpath[1] stringValue]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self analysisXmlFromPath:PATH];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
