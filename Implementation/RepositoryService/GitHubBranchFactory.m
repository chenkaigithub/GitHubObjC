//
//  GitHubBranchFactory.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubBranchFactory.h"
#import "GitHubServiceGotBranchDelegate.h"
#import "GitHubServiceDelegate.h"
#import "GitHubBranch.h"
#import "GitHubBranchImp.h"

@implementation GitHubBranchFactory

@synthesize user, repository;

-(void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
  
  if ([elementName isEqualToString:@"branches"]) {
    
  } else if ([elementName isEqualToString:@"error"]) {
    
    [self.parser abortParsing];
    
  } else {
    
    id<GitHubBranch> branch = [GitHubBranchImp branch];
    branch.name = elementName;
    branch.commitId = self.currentStringValue;
    branch.userName = self.user;
    branch.repositoryName = self.repository;
    
    [(id<GitHubServiceGotBranchDelegate>)self.delegate
     gitHubService:self
     gotBranch:branch];
  }
  self.currentStringValue = nil;
}

-(void)requestBranchesByName:(NSString *)newRepository
                        user:(NSString *)newUser {
  
  self.user = newUser;
  self.repository = newRepository;
  
  [self makeRequest:
   [NSString stringWithFormat:@"%@/api/v2/xml/repos/show/%@/%@/branches",
    [GitHubBaseFactory serverAddress], newUser, newRepository]];
}

+(GitHubBranchFactory *)branchFactoryWithDelegate:
(id<GitHubServiceGotBranchDelegate>)delegate {
  
  return [[[GitHubBranchFactory alloc] initWithDelegate:delegate] autorelease]; 
}

-(void)dealloc {
  
  self.repository = nil;
  self.user = nil;
  self.currentStringValue = nil;
  [super dealloc];
}

@end
