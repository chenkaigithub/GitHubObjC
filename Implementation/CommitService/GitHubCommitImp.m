//
//  GitHubCommitImp.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/16/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubCommitImp.h"

@implementation GitHubCommitImp

@synthesize authorName, authorEmail, authorLogin, authoredDate, committerName,
committerEmail, committerLogin,committedDate, url, commitId, tree, message,
parents;

-(void)addParent:(NSString *)parent {
  
  [self.parents addObject:parent];
}

-(id)init {
  
  if (self = [super init]) {
    self.parents = [NSMutableArray arrayWithCapacity:2];
  }
  return self;
}

+(id<GitHubCommit>)commit {
  
  return [[[GitHubCommitImp alloc] init] autorelease];
}

-(NSString *)description {
  
  NSMutableString *parentsString = [NSMutableString string];
  
  for (int i = 0; i < [self.parents count]; i++) {
    [parentsString appendFormat:@"%@, ", [self.parents objectAtIndex:i]];
  }
  return [NSString
          stringWithFormat:@"\nSTART - GitHubCommit\n"
          "Parents:%@\n"
          "AuthorName:%@\n"
          "AuthorEmail:%@\n"
          "AuthorLogin:%@\n"
          "URL:%@\n"
          "CommitId:%@\n"
          "CommitedDate:%@\n"
          "AuthoredDate:%@\n"
          "Tree:%@\n"
          "CommitterName:%@\n"
          "CommitterEmail:%@\n"
          "CommitterLogin:%@\n"
          "Message:%@\n"
          "END - GitHubCommit\n",
          parentsString,
          self.authorName,
          self.authorEmail,
          self.authorLogin,
          self.url,
          self.commitId,
          self.committedDate,
          self.authoredDate,
          self.tree,
          self.committerName,
          self.committerEmail,
          self.committerLogin,
          self.message];
}

-(void)dealloc {
  
  self.parents = nil;
  self.authorName = nil;
  self.authorEmail = nil;
  self.authorLogin = nil;
  self.url = nil;
  self.commitId = nil;
  self.committedDate = nil;
  self.authoredDate = nil;
  self.tree = nil;
  self.committerName = nil;
  self.committerLogin = nil;
  self.committerEmail = nil;
  self.message = nil;
  [super dealloc];
}

@end
