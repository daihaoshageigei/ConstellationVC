//
//  ConstellationRequest.m
//  ConstellationVC
//
//  Created by  on 14-9-20.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "ConstellationRequest.h"

#define BASE_URL @"http://api.uihoo.com/astro/astro.http.php?fun=day&id="

@implementation ConstellationRequest


@synthesize constellation = _constellation;
@synthesize currentName = _currentName;
@synthesize twitterDic;
@synthesize currentText;

- (void)startRequest:(NSString *)constellationId
{
    NSString *idString = constellationId;
    
    NSString *str = [BASE_URL stringByAppendingFormat:@"%@&format=xml",idString];
    
    NSURL *url = [NSURL URLWithString:str];
    __weak ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request setTimeOutSeconds:60];
    
    [request setCompletionBlock:^{
        NSData *data = request.responseData;
        NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
        parser.delegate = self;
        [parser parse];
//        NSLog(@"%@",parser);
        
    }];
    [request startAsynchronous];
}

//1.文档开始的时候触发
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    _constellation = [[NSMutableArray alloc]init];
}
//文档出错的时候触发
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"%@",parseError);
}
//2.遇到开始标签时触发
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    currentText = [[NSMutableString alloc]init];
    if([elementName isEqualToString:@"item"]){
        NSMutableDictionary *newNode = [[NSMutableDictionary alloc]initWithCapacity:0];
        twitterDic = newNode;
        [_constellation addObject:newNode];
//        NSLog(@"_constellation %@",_constellation);

        
    }else if(twitterDic){
        NSMutableString *string = [[NSMutableString alloc]initWithCapacity:0];
        [twitterDic setObject:string forKey:elementName];
        _currentName = elementName;
//        NSLog(@"_currentName %@",_currentName);
    }
    
}

//3.获取首尾节点间的内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
//    NSLog(@"333333 %@",NSStringFromSelector(_cmd));
    [currentText appendString:string];
}
//4.解析完当前节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"item"]){
        twitterDic = nil;
    }else if([elementName isEqualToString:_currentName]){
        if([elementName isEqualToString:@""]|[elementName isEqualToString:@""]){
            [twitterDic setObject:elementName forKey:_currentName];
        }else{
            [twitterDic setObject:currentText forKey:_currentName];
//            NSLog(@"twitterDic %@",twitterDic);
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"passValueNotification" object:_constellation userInfo:nil];
}

@end
