//
//  GitHubCommentFactory.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/30/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubCommentFactory.h"

@implementation GitHubCommentFactory

#pragma mark -
#pragma mark Memory and member management

//Retain
@synthesize comment;

-(void)cleanUp {
  
  self.comment = nil;
  [super cleanUp];
}

-(void)dealloc {
  
  [self cleanUp];
  [super dealloc];
}

#pragma mark -
#pragma mark Delegate protocol implementation
#pragma mark - NSXMLParserDelegate

-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI 
qualifiedName:(NSString *)qName
   attributes:(NSDictionary *)attributeDict {
  
  if ([elementName isEqualToString:@"comment"]) {
    
    self.comment = [GitHubCommentImp comment];
  }
  self.currentStringValue = [NSMutableString stringWithCapacity:100];
}

-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName {
  
  if ([elementName isEqualToString:@"comment"]) {
    
    [(id<GitHubServiceGotCommentDelegate>)self.delegate
     gitHubService:self
     gotComment:self.comment];
    
  } else if ([elementName isEqualToString:@"gravatar-id"]) {
    
    self.comment.gravatar = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"created-at"]) {
      
      NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
      [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
      
      self.comment.created =
      [formatter dateFromString:[self.currentStringValue substringToIndex:18]];
    
  } else if ([elementName isEqualToString:@"body"]) {
    
    self.comment.body = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"updated-at"]) {
    
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    
    self.comment.updated =
    [formatter dateFromString:[self.currentStringValue substringToIndex:18]];
    
  } else if ([elementName isEqualToString:@"id"]) {
    
    self.comment.commentId = [self.currentStringValue intValue];
    
  } else if ([elementName isEqualToString:@"user"]) {
    
    self.comment.user = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"error"]) {
    
    [self handleErrorWithCode:GitHubServerServerError];
  }
  self.currentStringValue = nil;
}

#pragma mark -
#pragma mark Interface implementation
#pragma mark - Class

+(GitHubCommentFactory *)commentFactoryWithDelegate:
(id<GitHubServiceGotCommentDelegate>)delegate {

    return [[[GitHubCommentFactory alloc]
             initWithDelegate:delegate] autorelease]; 
}

#pragma mark - Instance

-(void)requestCommentsForNumber:(NSUInteger)number
                           user:(NSString *)user
                     repository:(NSString *)repository {
  
  [self makeRequest:[NSString
                     stringWithFormat:
                     @"%@/api/v2/xml/issues/comments/%@/%@/%i",
                     [GitHubBaseFactory serverAddress],
                     user, repository, number]];
}

@end
