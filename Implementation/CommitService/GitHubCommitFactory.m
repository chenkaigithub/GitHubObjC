//
//  GitHubCommitFactory.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubServiceDelegate.h"
#import "GitHubServiceGotCommitDelegate.h"
#import "GitHubCommitFactory.h"
#import "GitHubCommitImp.h"
#import "GitHubCommit.h"

@implementation GitHubCommitFactory

@synthesize commit, author, committer, parent;

-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI 
qualifiedName:(NSString *)qName
   attributes:(NSDictionary *)attributeDict {
  
  if ([elementName isEqualToString:@"commit"]) {
    
    self.commit = [GitHubCommitImp commit];
    
  } else if ([elementName isEqualToString:@"author"]) {
    
    self.author = YES;
    
  } else if ([elementName isEqualToString:@"committer"]) {
    
    self.committer = YES;
    
  } else if ([elementName isEqualToString:@"parent"]) {
    
    self.parent = YES;
  }
  self.currentStringValue = [NSMutableString stringWithCapacity:100];
}

-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName {
  if ([elementName isEqualToString:@"commit"]) {
    
    [(id<GitHubServiceGotCommitDelegate>)self.delegate
     gitHubService:self
         gotCommit:self.commit];
    
  } else if ([elementName isEqualToString:@"message"]) {
    
    self.commit.message = currentStringValue;
    
  } else if ([elementName isEqualToString:@"author"]) {
    
    self.author = NO;
    
  } else if ([elementName isEqualToString:@"committer"]) {
    
    self.committer = NO;
    
  } else if ([elementName isEqualToString:@"parent"]) {
    
    self.parent = NO;
    
  } else if ([elementName isEqualToString:@"id"]) {
    
    if (self.parent) {
      
      [self.commit.parents addObject:currentStringValue];
      
    } else {
      
      self.commit.commitId = currentStringValue;
      
    }
  } else if ([elementName isEqualToString:@"tree"]) {
    
    self.commit.tree = currentStringValue;
    
  } else if ([elementName isEqualToString:@"name"]) {
    
    if (self.author) {
      
      self.commit.authorName = currentStringValue;
      
    } else if (self.committer){
      
      self.commit.committerName = currentStringValue;
    }
  } else if ([elementName isEqualToString:@"email"]) {
    
    if (self.author) {
      
      self.commit.authorEmail = currentStringValue;
      
    } else if (self.committer) {
      
      self.commit.committerEmail = currentStringValue;
    }
  } else if ([elementName isEqualToString:@"login"]) {
    
    if (self.author) {
      
      self.commit.authorLogin = currentStringValue;
      
    } else {
      
      self.commit.committerLogin = currentStringValue;
    }
  } else if ([elementName isEqualToString:@"url"]) {
    
    self.commit.url = [NSURL URLWithString:currentStringValue];
    
  } else if ([elementName isEqualToString:@"authored-date"]) {
    
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    
    self.commit.authoredDate = [formatter
                                dateFromString:self.currentStringValue];
    
  } else if ([elementName isEqualToString:@"committed-date"]) {
    
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    
    self.commit.committedDate = [formatter
                                 dateFromString:self.currentStringValue];
    
  } else if ([elementName isEqualToString:@"error"]) {
    
    [self.parser abortParsing];
  }
  self.currentStringValue = nil;
}

-(void)requestCommitsOnBranch:(NSString *)branch
                   repository:(NSString *)repository
                         user:(NSString *)user {
  
  [self makeRequest:[NSString
                     stringWithFormat:@"%@/api/v2/xml/commits/list/%@/%@/%@",
                     [GitHubBaseFactory serverAddress],
                     user, repository, branch]];
}

-(void)requestCommitsOnBranch:(NSString *)branch
                         path:(NSString *)path
                   repository:(NSString *)repository
                         user:(NSString *)user {
  
  [self makeRequest:[NSString
                     stringWithFormat:@"%@/api/v2/xml/commits/list/%@/%@/%@/%@",
                     [GitHubBaseFactory serverAddress],
                     user, repository, branch, path]];
}

-(void)requestCommit:(NSString *)commitId
          repository:(NSString *)repository
                user:(NSString *)user {
  
  [self makeRequest:[NSString
                     stringWithFormat:@"%@/api/v2/xml/commits/show/%@/%@/%@",
                     [GitHubBaseFactory serverAddress],
                     user, repository, commitId]];
}

+(GitHubCommitFactory *)commitFactoryWithDelegate:
(id<GitHubServiceGotCommitDelegate>)delegate {
  
  return [[[GitHubCommitFactory alloc] initWithDelegate:delegate] autorelease]; 
}

@end
