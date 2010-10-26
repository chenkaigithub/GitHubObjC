//
//  GitHubBranchImp.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/16/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubBranchImp.h"

@implementation GitHubBranchImp

#pragma mark -
#pragma mark Memory and member management

//Copy
@synthesize name, commitId, userName, repositoryName;

-(void)dealloc {
  
  self.name = nil;
  self.commitId = nil;
  self.userName = nil;
  self.repositoryName = nil;
  [super dealloc];
}

#pragma mark -
#pragma mark Super override implementation

-(NSString *)description {
  
  return [NSString
          stringWithFormat:@"\nSTART - GitHubBranch\n"
          "Name:%@\n"
          "CommitId:%@\n"
          "UserName:%@\n"
          "RepositoryName:%@\n"
          "END - GitHubBranch\n"
          ,
          self.name,
          self.commitId,
          self.userName,
          self.repositoryName
          ];
}

-(NSComparisonResult)compare:(id<GitHubBranch>)otherBranch {
  
  return [self.name compare:otherBranch.name];
}

#pragma mark -
#pragma mark Interface implementation
#pragma mark - Class

+(id<GitHubBranch>)branch {
  
  return [[[GitHubBranchImp alloc] init] autorelease]; 
}

@end
