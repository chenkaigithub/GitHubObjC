//
//  GitHubBaseFactory.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright (c) 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubService.h"

@protocol GitHubServiceDelegate;

@interface GitHubBaseFactory : NSObject <GitHubService, NSXMLParserDelegate> {
  NSMutableData *receivedData;
  NSString *request;
  NSXMLParser* parser;
  NSURLConnection *connection;
  NSMutableString *currentStringValue;
  BOOL failSent;
  BOOL cancelling;
  id<GitHubServiceDelegate> delegate; 
}

@property (retain) NSMutableData* receivedData;
@property (retain) NSXMLParser* parser;
@property (retain) NSURLConnection *connection;
@property (retain) NSMutableString *currentStringValue;
@property (copy) NSString* request;
@property (assign) BOOL failSent;
@property (assign) BOOL cancelling;
@property (retain) id<GitHubServiceDelegate> delegate;

-(void)makeRequest:(NSString *) url;
-(id<GitHubService>)initWithDelegate:(id<GitHubServiceDelegate>)newDelegate;
-(void)cancelRequest;
-(void)cleanUp;
-(void)handleErrorWithCode:(GitHubServerError)code;
+(void)setServerAddress:(NSString *)newServerAddress;
+(NSString *)serverAddress;

@end