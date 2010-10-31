//
//  GitHubBaseFactory.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright (c) 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubBaseFactory.h"

@implementation GitHubBaseFactory

#pragma mark -
#pragma mark Internal implementation declaration

static NSString * serverAddress = @"http://github.com";

#pragma mark -
#pragma mark Memory and member management

//Copy
@synthesize request;

//Retain
@synthesize receivedData, currentStringValue, parser, connection, delegate,
endElement, startElement;

//Assign
@synthesize failSent, cancelling;

-(void)cleanUp {
  
  self.delegate = nil;
  self.receivedData = nil;
  self.request = nil;
  self.connection = nil;
  self.parser = nil;
  self.currentStringValue = nil;
}

-(void)dealloc {
  
  [self cleanUp];
  [super dealloc];
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

+(void)setServerAddress:(NSString *)newServerAddress {
  
  [serverAddress release];
  serverAddress = [newServerAddress retain];
}

+(NSString *)serverAddress {
  
  return serverAddress;
}

#pragma mark -
#pragma mark Internal implementation
#pragma mark - Instance

-(id<GitHubService>)initWithDelegate:(id<GitHubServiceDelegate>)newDelegate {
  
  if (self = [super init]){
    self.delegate = newDelegate;
    self.cancelling = NO;
    self.failSent = NO;
  }
  return self;
}

-(void)handleErrorWithCode:(GitHubServerError)code {

  if (!self.cancelling && !self.failSent) {
    
    self.failSent = YES;
    
    [self.delegate gitHubService:self
                didFailWithError:[NSError
                                  errorWithDomain:GitHubServerErrorDomain
                                  code:code
                                  userInfo:nil]];
    
    [self cleanUp];
  }
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
  }
}

#pragma mark -
#pragma mark Delegate protocol implementation
#pragma mark - NSXMLParserDelegate

-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI 
qualifiedName:(NSString *)qName
   attributes:(NSDictionary *)attributeDict {

  SEL aSel = [[self.startElement objectForKey:elementName] pointerValue];
  
  if (aSel) {
    
    [self performSelector:aSel withObject:elementName withObject:attributeDict];
  }
  self.currentStringValue = [NSMutableString stringWithCapacity:100];
}

-(void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
  
  SEL aSel = [[self.endElement objectForKey:elementName] pointerValue];
  
  if (aSel) {
    
    [self performSelector:aSel withObject:elementName];
  }
  self.currentStringValue = nil;
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
  
  [self.currentStringValue appendString:string];
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
  
  [self handleErrorWithCode:GitHubServerParserError];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser {
  
  if (!self.failSent && !self.cancelling) {
    
    [self.delegate gitHubServiceDone:self];
    [self cleanUp];
  }
}

#pragma mark - NSURLConnection

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
  
  [self handleErrorWithCode:GitHubServerConnectionError];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
  
  self.parser = [[[NSXMLParser alloc]
                  initWithData:self.receivedData] autorelease];
  
  [self.parser setDelegate:self];
  [self.parser parse];
  self.connection = nil;
  self.receivedData = nil;
}

#pragma mark -
#pragma mark Interface implementation
#pragma mark - Class

NSString * const GitHubServerErrorDomain = @"GitHubServerErrorDomain";

#pragma mark - Instance

-(void)cancelRequest {
  
  self.cancelling = YES;
  [self cleanUp];
}

-(NSDate *)createDateFromString:(NSString *)string {
  
  NSDate *retVal = nil;
  
  if ([string length] > 18) {
    
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    
    retVal = [formatter dateFromString:[string substringToIndex:18]];
  }
  return retVal;
}

@end
