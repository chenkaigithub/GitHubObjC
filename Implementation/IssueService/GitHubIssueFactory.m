//
//  GitHubIssueFactory.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/30/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubIssueFactory.h"

@implementation GitHubIssueFactory

#pragma mark -
#pragma mark Memory and member management

//Retain
@synthesize issue, labels;

//Assign
@synthesize inLabel;

-(void)cleanUp {
  
  self.issue = nil;
  self.labels = nil;
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
  
  if ([elementName isEqualToString:@"issue"]) {
    
    self.issue = [GitHubIssueImp issue];
  } else if ([elementName isEqualToString:@"labels"]) {
    
    self.labels = [NSMutableArray arrayWithCapacity:5];
    
  } else if ([elementName isEqualToString:@"label"]) {
    
    self.inLabel = YES;
  }
  self.currentStringValue = [NSMutableString stringWithCapacity:100];
}

-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName {
  
  if ([elementName isEqualToString:@"issue"]) {
    
    [(id<GitHubServiceGotIssueDelegate>)self.delegate
     gitHubService:self
     gotIssue:self.issue];
    
  } else if ([elementName isEqualToString:@"gravatar-id"]) {
    
    self.issue.gravatar = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"position"]) {
    
    self.issue.position = [self.currentStringValue floatValue];
    
  } else if ([elementName isEqualToString:@"number"]) {
    
    self.issue.number = [self.currentStringValue intValue];
    
  } else if ([elementName isEqualToString:@"votes"]) {
    
    self.issue.votes = [self.currentStringValue intValue];
    
  } else if ([elementName isEqualToString:@"created-at"]) {
    
    if ([self.currentStringValue length] > 18) {
      
      NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
      [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
      
      self.issue.created =
      [formatter dateFromString:[self.currentStringValue substringToIndex:18]];
    }
    
  } else if ([elementName isEqualToString:@"comments"]) {
    
    self.issue.comments = [self.currentStringValue intValue];
    
  } else if ([elementName isEqualToString:@"body"]) {
    
    self.issue.body = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"title"]) {
    
    self.issue.title = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"updated-at"]) {
    
    if ([self.currentStringValue length] > 18) {
      
      NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
      [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
      
      self.issue.updated =
      [formatter dateFromString:[self.currentStringValue substringToIndex:18]];
    }
    
  } else if ([elementName isEqualToString:@"closed-at"]) {
    
    if ([self.currentStringValue length] > 18) {
        
      NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
      [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
      
      self.issue.updated =
      [formatter dateFromString:[self.currentStringValue substringToIndex:18]];
    }
    
  } else if ([elementName isEqualToString:@"user"]) {
    
    self.issue.user = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"labels"]) {
    
    self.issue.labels = [NSArray arrayWithArray:self.labels];
    self.labels = nil;
    
  } else if ([elementName isEqualToString:@"label"]) {
    
    self.inLabel = NO;
    
  } else if ([elementName isEqualToString:@"name"]) {
    
    if (self.inLabel) {
      
      [self.labels addObject:self.currentStringValue];
    }
    
  } else if ([elementName isEqualToString:@"error"]) {
    
    [self handleErrorWithCode:GitHubServerServerError];
  }
  self.currentStringValue = nil;
}

#pragma mark -
#pragma mark Interface implementation
#pragma mark - Class

+(GitHubIssueFactory *)issueFactoryWithDelegate:
(id<GitHubServiceGotIssueDelegate>)delegate {

    return [[[GitHubIssueFactory alloc] initWithDelegate:delegate] autorelease];
}

#pragma mark - Instance

-(void)searchIssuesForTerm:(NSString *)term
                     state:(GitHubIssueState)state
                      user:(NSString *)user
                repository:(NSString *)repository {

  NSString *stateStr;
  
  if (state == GitHubIssueOpen) {
    
    stateStr = @"open";
    
  } else {
    
    stateStr = @"closed";  
  }
  [self makeRequest:[NSString
                     stringWithFormat:
                     @"%@/api/v2/xml/issues/search/%@/%@/%@/%@",
                     [GitHubBaseFactory serverAddress],
                     user, repository, stateStr, term]];
}

-(void)requestIssuesForState:(GitHubIssueState)state
                        user:(NSString *)user
                  repository:(NSString *)repository {
  
  NSString *stateStr;
  
  if (state == GitHubIssueOpen) {
    
    stateStr = @"open";
    
  } else {
    
    stateStr = @"closed";  
  }
  
  [self makeRequest:[NSString
                     stringWithFormat:
                     @"%@/api/v2/xml/issues/list/%@/%@/%@",
                     [GitHubBaseFactory serverAddress],
                     user, repository, stateStr]];
}

-(void)requestIssuesForLabel:(NSString *)label
                        user:(NSString *)user
                  repository:(NSString *)repository {
  
  [self makeRequest:[NSString
                     stringWithFormat:
                     @"%@/api/v2/xml/issues/list/%@/%@/label/%@",
                     [GitHubBaseFactory serverAddress],
                     user, repository, label]];
}

-(void)requestIssueForNumber:(NSUInteger)number
                        user:(NSString *)user
                  repository:(NSString *)repository {

  [self makeRequest:[NSString
                     stringWithFormat:
                     @"%@/api/v2/xml/issues/show/%@/%@/%i",
                     [GitHubBaseFactory serverAddress],
                     user, repository, number]];
}

@end
