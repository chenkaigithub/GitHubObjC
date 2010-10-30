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

@implementation GitHubCommitFactory

#pragma mark -
#pragma mark Memory and member management

//Retain
@synthesize commit, parents, removed, added, modified, modifiedDiff;

//Assign
@synthesize author, committer, inAdded, inModified, inRemoved;

-(void)cleanUp {
  
  self.commit = nil;
  self.parents = nil;
  self.removed = nil;
  self.added = nil;
  self.modified = nil;
  self.modifiedDiff = nil;
  [super cleanUp];
}

-(void)dealloc {
  
  [self cleanUp];
  [super dealloc];
}

#pragma mark -
#pragma mark Internal implementation declaration

-(void)startElementCommit {
  
  self.commit = [GitHubCommitImp commit];
}

-(void)startElementAuthor {
  
  self.author = YES;
}

-(void)startElementCommitter {
  
  self.committer = YES;
}

-(void)startElementParent {
  
  self.parents = [NSMutableArray arrayWithCapacity:5];
}

-(void)startElementRemoved {
  
  self.inRemoved = YES;
  
  if (!self.removed) {
    
    self.removed = [NSMutableArray arrayWithCapacity:5];
  }
}

-(void)startElementAdded {
  
  self.inAdded = YES;
  
  if (!self.added) {
    
    self.added = [NSMutableArray arrayWithCapacity:5];
  }
}

-(void)startElementModified {
  
  self.inModified = YES;
  
  if (!self.modified) {
    
    self.modified = [NSMutableArray arrayWithCapacity:10];
  }
  
  if (!self.modifiedDiff) {
    
    self.modifiedDiff = [NSMutableArray arrayWithCapacity:10];
  }
}

-(void)endElementCommit {
  
  if (self.modified) {
    
    self.commit.modified = [NSArray arrayWithArray:self.modified];
    self.modified = nil;
  }
  
  if (self.modifiedDiff) {
    
    self.commit.modifiedDiff = [NSArray arrayWithArray:self.modifiedDiff];    
    self.modifiedDiff = nil;
  }
  
  if (self.removed) {
    
    self.commit.removed = [NSArray arrayWithArray:self.removed];
    self.removed = nil;
  }
  
  if (self.added) {
    
    self.commit.added = [NSArray arrayWithArray:self.added];
    self.added = nil;
  }
  
  [(id<GitHubServiceGotCommitDelegate>)self.delegate
   gitHubService:self
   gotCommit:self.commit];  
}

-(void)endElementMessage {
  
  self.commit.message = currentStringValue;
}

-(void)endElementAuthor {
  
  self.author = NO;
}

-(void)endElementCommitter {
  
  self.committer = NO;
}

-(void)endElementParent {
  
  self.commit.parents = [NSArray arrayWithArray:self.parents]; 
  self.parents = nil;
}

-(void)endElementModified {
  
  self.inModified = NO;
}

-(void)endElementAdded {
  
  self.inAdded = NO;
}

-(void)endElementRemoved {
  
  self.inRemoved = NO;
}

-(void)endElementId {
  
  if (self.parents) {
    
    [self.parents addObject:self.currentStringValue];
    
  } else {
    
    self.commit.commitId = self.currentStringValue;
  }
}

-(void)endElementTree {
  
  self.commit.tree = self.currentStringValue;
}

-(void)endElementName {
  
  if (self.author) {
    
    self.commit.authorName = self.currentStringValue;
    
  } else if (self.committer){
    
    self.commit.committerName = self.currentStringValue;
  }
}

-(void)endElementEmail {
  
  if (self.author) {
    
    self.commit.authorEmail = self.currentStringValue;
    
  } else if (self.committer) {
    
    self.commit.committerEmail = self.currentStringValue;
  }
}

-(void)endElementLogin {
  
  if (self.author) {
    
    self.commit.authorLogin = self.currentStringValue;
    
  } else {
    
    self.commit.committerLogin = self.currentStringValue;
  }
}

-(void)endElementUrl {
  
  self.commit.url = [NSURL URLWithString:currentStringValue];
}

-(void)endElementAuthoredDate {
  
  if ([self.currentStringValue length] > 18) {
    
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    
    self.commit.authoredDate =
    [formatter dateFromString:[self.currentStringValue substringToIndex:18]];
  }
}

-(void)endElementCommittedDate {
  
  if ([self.currentStringValue length] > 18) {
    
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    
    self.commit.committedDate =
    [formatter dateFromString:[self.currentStringValue substringToIndex:18]];
  }
}

-(void)endElementFilename {
  
  if (self.inAdded) {
    [self.added addObject:self.currentStringValue];
  }
  
  if (self.inRemoved) {
    [self.removed addObject:self.currentStringValue];
  }
  
  if (self.inModified) {
    [self.modified addObject:self.currentStringValue];
  }
}

-(void)endElementDiff {
  
  if (self.inModified) {
    [self.modifiedDiff addObject:self.currentStringValue];
  }
}

-(void)endElementError {
  
  [self handleErrorWithCode:GitHubServerServerError];
}

#pragma mark -
#pragma mark Super override implementation

+(void)initialize {
  
  startElement =
  [[NSDictionary dictionaryWithObjectsAndKeys:
    [NSValue valueWithPointer:@selector
     (startElementCommit)], @"commit",
    [NSValue valueWithPointer:@selector
     (startElementAuthor)], @"author",
    [NSValue valueWithPointer:@selector
     (startElementCommitter)], @"committer",
    [NSValue valueWithPointer:@selector
     (startElementParent)], @"parent",
    [NSValue valueWithPointer:@selector
     (startElementRemoved)], @"removed",
    [NSValue valueWithPointer:@selector
     (startElementAdded)], @"added",
    [NSValue valueWithPointer:@selector
     (startElementModified)], @"modified",
    nil] retain];
  
  endElement =
  [[NSDictionary dictionaryWithObjectsAndKeys:
    [NSValue valueWithPointer:@selector
     (endElementCommit)], @"commit",
    [NSValue valueWithPointer:@selector
     (endElementMessage)], @"message",
    [NSValue valueWithPointer:@selector
     (endElementAuthor)], @"author",
    [NSValue valueWithPointer:@selector
     (endElementCommitter)], @"committer",
    [NSValue valueWithPointer:@selector
     (endElementParent)], @"parent",
    [NSValue valueWithPointer:@selector
     (endElementModified)], @"modified",
    [NSValue valueWithPointer:@selector
     (endElementAdded)], @"added",
    [NSValue valueWithPointer:@selector
     (endElementRemoved)], @"removed",
    [NSValue valueWithPointer:@selector
     (endElementId)], @"id",
    [NSValue valueWithPointer:@selector
     (endElementTree)], @"tree",
    [NSValue valueWithPointer:@selector
     (endElementName)], @"name",
    [NSValue valueWithPointer:@selector
     (endElementEmail)], @"email",
    [NSValue valueWithPointer:@selector
     (endElementLogin)], @"login",
    [NSValue valueWithPointer:@selector
     (endElementUrl)], @"url",
    [NSValue valueWithPointer:@selector
     (endElementAuthoredDate)], @"authored-date",
    [NSValue valueWithPointer:@selector
     (endElementCommittedDate)], @"committed-date",
    [NSValue valueWithPointer:@selector
     (endElementFilename)], @"filename",
    [NSValue valueWithPointer:@selector
     (endElementDiff)], @"diff",
    [NSValue valueWithPointer:@selector
     (endElementError)], @"error",
    nil] retain];
}

#pragma mark -
#pragma mark Interface implementation
#pragma mark - Class

+(GitHubCommitFactory *)commitFactoryWithDelegate:
(id<GitHubServiceGotCommitDelegate>)delegate {
  
  return [[[GitHubCommitFactory alloc] initWithDelegate:delegate] autorelease];
}

#pragma mark - Instance

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

@end
