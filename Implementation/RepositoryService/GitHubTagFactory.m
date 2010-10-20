//
//  GitHubTagFactory.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubTagFactory.h"
#import "GitHubServiceGotTagDelegate.h"
#import "GitHubServiceDelegate.h"
#import "GitHubTagImp.h"

@implementation GitHubTagFactory

@synthesize user, repository;

-(void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
  
  if ([elementName isEqualToString:@"tags"]) {
    
  } else if ([elementName isEqualToString:@"error"]) {
    
    [self.parser abortParsing];
    
  } else {
    
    id<GitHubTag> tag = [GitHubTagImp tag];
    tag.name = elementName;
    tag.commitId = self.currentStringValue;
    tag.userName = self.user;
    tag.repositoryName = self.repository;
    
    [(id<GitHubServiceGotTagDelegate>)self.delegate gitHubService:self
                                                           gotTag:tag];
  }
  self.currentStringValue = nil;
}

-(void)requestTagsByName:(NSString *)newRepository
                    user:(NSString *)newUser {
  
  self.user = newUser;
  self.repository = newRepository;
  
  [self makeRequest:
   [NSString stringWithFormat:@"%@/api/v2/xml/repos/show/%@/%@/tags",
    [GitHubBaseFactory serverAddress], newUser, newRepository]];
}

+(GitHubTagFactory *)tagFactoryWithDelegate:
(id<GitHubServiceGotTagDelegate>)delegate {
  
  return [[[GitHubTagFactory alloc] initWithDelegate:delegate] autorelease]; 
}

-(void)dealloc {
  
  self.repository = nil;
  self.user = nil;
  self.currentStringValue = nil;
  [super dealloc];
}

@end
