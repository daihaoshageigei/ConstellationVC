//
//  ConstellationRequest.h
//  ConstellationVC
//
//  Created by  on 14-9-20.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface ConstellationRequest : NSObject<NSXMLParserDelegate>


@property (nonatomic, strong) NSMutableArray *constellation;
@property (nonatomic, strong) NSString *currentName;
@property (nonatomic, strong) NSMutableDictionary *twitterDic;
@property (nonatomic, strong) NSMutableString *currentText;

- (void)startRequest:(NSString *)constellationId;

@end
