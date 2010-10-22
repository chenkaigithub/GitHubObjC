//
//  GitHubBaseFactory.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright (c) 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubBaseFactory.h"
#import "GitHubServiceDelegate.h"

@implementation GitHubBaseFactory

@synthesize receivedData, currentStringValue, request, parser;
@synthesize connection, delegate, failSent, cancelling;

static NSString *serverAddress = @"http://github.com";

+(void)setServerAddress:(NSString *)newServerAddress {
  
  [serverAddress release];
  serverAddress = [newServerAddress retain];
}

+(NSString *)serverAddress {
  
  return serverAddress;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
   attributes:(NSDictionary *)attributeDict {
  
  self.currentStringValue = [NSMutableString stringWithCapacity:100];
}

-(void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
  
  [NSException raise:NSInternalInconsistencyException 
              format:@"You must override %@ in a subclass",
   NSStringFromSelector(_cmd)];
}


-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
  
  [self.currentStringValue appendString:string];
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
  
  self.failSent = YES;
  
  if (!self.cancelling) {
    [self.delegate gitHubService:self didFailWithError:parseError];
  }
}

-(void)parserDidEndDocument:(NSXMLParser *)parser {
  
  if (!self.failSent) {
    [self.delegate gitHubServiceDone:self];
  }
}

-(void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response {
  
  [self.receivedData setLength:0];
}

-(void)connection:(NSURLConnection *)connection
   didReceiveData:(NSData *)data {
  
  [self.receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection
 didFailWithError:(NSError *)error {
  
  [self.delegate gitHubService:self didFailWithError:error];
  self.connection = nil;
  self.receivedData = nil;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
  
  self.parser = [[[NSXMLParser alloc]
                  initWithData:self.receivedData] autorelease];
  
  [self.parser setDelegate:self];
  [self.parser setShouldResolveExternalEntities:YES];
  [self.parser parse];
  self.connection = nil;
  self.receivedData = nil;
}

-(void)setParser:(NSXMLParser *)newParser {
  
  [parser abortParsing];
  [parser release];
  parser = [newParser retain];
}

-(void)setConnection:(NSURLConnection *)newConnection {
  
  [connection cancel];
  [connection release];
  connection = [newConnection retain];
}

-(void)cancelRequest {
  
  self.cancelling = YES;
  self.request = nil;
  self.parser = nil;
  self.receivedData = nil;
  self.connection = nil;
}
	
-(void)makeRequest:(NSString *) url {
  
  self.request = url;
  
  NSURLRequest *theRequest=[NSURLRequest
                            requestWithURL:[NSURL URLWithString:url]
                            cachePolicy:NSURLRequestUseProtocolCachePolicy
                            timeoutInterval:60.0];
  
  self.connection = [NSURLConnection connectionWithRequest:theRequest
                                                  delegate:self];
  
  if (self.connection) {
    
    self.receivedData = [NSMutableData data];
  } else {
  
    [self.delegate gitHubService:self didFailWithError:nil];
  }
}

-(id<GitHubService>)initWithDelegate:(id<GitHubServiceDelegate>)newDelegate {
  
  if (self = [super init]){
    self.delegate = newDelegate;
    self.cancelling = NO;
    self.failSent = NO;
  }
  return self;
}

-(void)dealloc {
  
  self.receivedData = nil;
  self.request = nil;
  self.connection = nil;
  self.parser = nil;
  self.currentStringValue = nil;
  [super dealloc];
}

@end
