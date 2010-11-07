//
//  TestGitHubRepoServer.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "TestGitHubRepoServer.h"
#import "GitHubRepositoryServiceFactory.h"
#import "GitHubService.h"
#import "GitHubServiceSettings.h"

@implementation TestGitHubRepoServer

@synthesize testCaseLock, response, repoSearchCount, testCase, doneWithErrors,
done;

-(void)initTestCase:(NSString *)name {
  
  [GitHubServiceSettings
   setServerAddress:[NSString stringWithFormat:@"file://%@/TestData", SRCROOT]];
  
  self.testCase = name;
  self.testCaseLock = YES;
  self.repoSearchCount = 0;
  self.done = NO;
  self.doneWithErrors = NO;
}

//Read repositories from file
-(void)testSearchRepo1 {
  [GitHubServiceSettings hidePrivateRepositories:YES];
  [self initTestCase:NSStringFromSelector(_cmd)];
  [GitHubRepositoryServiceFactory searchRepositoriesByName:@"testSearchRepo1" delegate:self];
  
  while (self.testCaseLock) {
    
    [[NSRunLoop currentRunLoop]
     runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
  }
  STAssertFalse(self.doneWithErrors, @"Done with errors sent");
  STAssertTrue(self.done, @"Done not sent");
}

//Test filtering of private repos
-(void)testSearchRepo2 {
  
  [self initTestCase:NSStringFromSelector(_cmd)];
  [GitHubRepositoryServiceFactory searchRepositoriesByName:@"testSearchRepo2" delegate:self];
  
  while (self.testCaseLock) {
    
    [[NSRunLoop currentRunLoop]
     runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
  }
  STAssertFalse(self.doneWithErrors, @"Done with errors sent");
  STAssertTrue(self.done, @"Done not sent");
}


-(void)timeOut {
  
  self.testCaseLock = NO;
}

-(void)gitHubService:(id<GitHubService>)gitHubService
       gotRepository:(id<GitHubRepository>)repository {
  
  self.repoSearchCount++;
  
  if ([self.testCase isEqualToString:@"testSearchRepo1"]) {
    
    switch (self.repoSearchCount) {
      case 1:
        
        STAssertEquals(repository.watchers, 2,
                       @"Watchers should be 2, is %i", repository.watchers);
        
        STAssertEquals(repository.hasDownloads, YES,
                       @"HasDownloads should be YES, is %i", repository.hasDownloads);
        
        STAssertEqualObjects(repository.desc,
                             @"Exploring uses for mobiles "
                             "in accident situations", nil);
        
        STAssertEqualObjects(repository.name, @"Crash",
                             @"Name should be Crash, is %@", repository.name);
        
        STAssertEquals(repository.fork, NO,
                       @"Fork should be NO, is %i", repository.fork);
        
        STAssertEquals(repository.hasWiki, YES,
                       @"HasWiki should be YES, is %i", repository.hasWiki);
        
        STAssertEquals(repository.hasIssues, YES,
                       @"HasIssues should be YES, is %i", repository.hasIssues);
        
//        STAssertEqualObjects(repository.url, @"",
//                             @"Url should be '', is %@", repository.url);
        
        STAssertEqualObjects(repository.owner, @"bzbhorizon", nil);
        
        STAssertEqualObjects(repository.homepage,
                             [NSURL URLWithString:@""], nil);
        
        STAssertEquals(repository.openIssues, 0,
                       @"OpenIssues should be 0, is %i", repository.openIssues);
        
        STAssertEquals(repository.private, NO,
                       @"Private should be NO, is %i", repository.private);
        
//        STAssertEqualObjects(repository.creationDate, ,
//                             @"CreationDate should be 2, is %@",
//                             repository.creationDate);
//        
//        STAssertEqualObjects(repository.pushDate, ,
//                             @"PushDate should be 2, is %@",
//                             repository.pushDate);
        
        STAssertEquals(repository.forks, 1,
                       @"Forks should be 1, is %i", repository.forks);
        break;
      case 2:
        
        STAssertEquals(repository.watchers, 92,
                       @"Watchers should be 92, is %i", repository.watchers);
        
        STAssertEquals(repository.hasDownloads, YES,
                       @"HasDownloads should be YES, is %i", repository.hasDownloads);
        
        STAssertEqualObjects(repository.desc,
                             @"Manage crash reports of your iPhone and Mac "
                             "OS X apps during development, beta phase and "
                             "after rollout, follow news on Twitter via "
                             "@crashreporter", nil);
        
        STAssertEqualObjects(repository.name, @"CrashReporterDemo", nil);
        
        STAssertEquals(repository.fork, NO,
                       @"Fork should be NO, is %i", repository.fork);
        
        STAssertEquals(repository.hasWiki, YES,
                       @"HasWiki should be YES, is %i", repository.hasWiki);
        
        STAssertEquals(repository.hasIssues, YES,
                       @"HasIssues should be YES, is %i", repository.hasIssues);
        
        //        STAssertEqualObjects(repository.url, @"",
        //                             @"Url should be , is %@", repository.url);
        
        STAssertEqualObjects(repository.owner, @"TheRealKerni", nil);
        
        STAssertEqualObjects(repository.homepage,
                             [NSURL URLWithString:
                              @"http://macdevcrashreports.com"], nil);
        
        STAssertEquals(repository.openIssues, 0,
                       @"OpenIssues should be 0, is %i", repository.openIssues);
        
        STAssertEquals(repository.private, NO,
                       @"Private should be NO, is %i", repository.private);
        
        //        STAssertEqualObjects(repository.creationDate, ,
        //                             @"CreationDate should be 2, is %@",
        //                             repository.creationDate);
        //        
        //        STAssertEqualObjects(repository.pushDate, ,
        //                             @"PushDate should be 2, is %@",
        //                             repository.pushDate);
        
        STAssertEquals(repository.forks, 8,
                       @"Forks should be 8, is %i", repository.forks);      
        
        break;
      case 3:
        
        STAssertEquals(repository.watchers, 53,
                       @"Watchers should be 53, is %i", repository.watchers);
        
        STAssertEquals(repository.hasDownloads, YES,
                       @"HasDownloads should be YES, is %i", repository.hasDownloads);
        
        STAssertEqualObjects(repository.desc,
                             @"CrashKit catches uncaught exceptions, "
                             "traps signals, and sends them to developers "
                             "by email or straight to your bug database.", nil);
        
        STAssertEqualObjects(repository.name, @"CrashKit", nil);
        
        STAssertEquals(repository.fork, NO,
                       @"Fork should be NO, is %i", repository.fork);
        
        STAssertEquals(repository.hasWiki, YES,
                       @"HasWiki should be YES, is %i", repository.hasWiki);
        
        STAssertEquals(repository.hasIssues, YES,
                       @"HasIssues should be YES, is %i", repository.hasIssues);
        
        //        STAssertEqualObjects(repository.url, @"",
        //                             @"Url should be '', is %@", repository.url);
        
        STAssertEqualObjects(repository.owner, @"kaler", nil);
        
        STAssertEqualObjects(repository.homepage,
                             [NSURL URLWithString:
                              @"http://parveenkaler.com/2010/08/11/crashkit"
                             "-helping-your-iphone-apps-suck-less/"], nil);
        
        STAssertEquals(repository.openIssues, 0,
                       @"OpenIssues should be 0, is %i", repository.openIssues);
        
        STAssertEquals(repository.private, NO,
                       @"Private should be NO, is %i", repository.private);
        
        //        STAssertEqualObjects(repository.creationDate, ,
        //                             @"CreationDate should be 2, is %@",
        //                             repository.creationDate);
        //        
        //        STAssertEqualObjects(repository.pushDate, ,
        //                             @"PushDate should be 2, is %@",
        //                             repository.pushDate);
        
        STAssertEquals(repository.forks, 5,
                       @"Forks should be 5, is %i", repository.forks);  
        
        break;
      case 4:

        STAssertEquals(repository.watchers, 24,
                       @"Watchers should be 24, is %i", repository.watchers);
        
        STAssertEquals(repository.hasDownloads, YES,
                       @"HasDownloads should be YES, is %i", repository.hasDownloads);
        
        STAssertEqualObjects(repository.desc,
                             @"A crash reporting app for OS X", nil);
        
        STAssertEqualObjects(repository.name, @"SFBCrashReporter", nil);
        
        STAssertEquals(repository.fork, NO,
                       @"Fork should be NO, is %i", repository.fork);
        
        STAssertEquals(repository.hasWiki, YES,
                       @"HasWiki should be YES, is %i", repository.hasWiki);
        
        STAssertEquals(repository.hasIssues, YES,
                       @"HasIssues should be YES, is %i", repository.hasIssues);
        
        //        STAssertEqualObjects(repository.url, @"",
        //                             @"Url should be '', is %@", repository.url);
        
        STAssertEqualObjects(repository.owner, @"sbooth", nil);
        
        STAssertEqualObjects(repository.homepage,
                             [NSURL URLWithString:@""], nil);
        
        STAssertEquals(repository.openIssues, 0,
                       @"OpenIssues should be 0, is %i", repository.openIssues);
        
        STAssertEquals(repository.private, NO,
                       @"Private should be NO, is %i", repository.private);
        
        //        STAssertEqualObjects(repository.creationDate, ,
        //                             @"CreationDate should be 2, is %@",
        //                             repository.creationDate);
        //        
        //        STAssertEqualObjects(repository.pushDate, ,
        //                             @"PushDate should be 2, is %@",
        //                             repository.pushDate);
        
        STAssertEquals(repository.forks, 4,
                       @"Forks should be 4, is %i", repository.forks);
        break;
      default:
        
        STFail(@"Search Count Index Error, count is %@", self.repoSearchCount);
        break;
    }
  } else if ([self.testCase isEqualToString:@"testSearchRepo2"]) {
    
      if (repository.private) {
        
        STFail(@"Listed private repository");
      }
  }
}

-(void)gitHubServiceDone:(id <GitHubService>)gitHubService {
  
  if ([self.testCase isEqualToString:@"testSearchRepo1"]) {
    
    STAssertEquals(4, self.repoSearchCount,
                   @"Repo count should be 4, is %i", self.repoSearchCount);
    
  } else if ([self.testCase isEqualToString:@"testSearchRepo2"]) {
    
    STAssertEquals(3, self.repoSearchCount,
                   @"Repo count should be 3, is %i", self.repoSearchCount);
   [GitHubServiceSettings hidePrivateRepositories:NO]; 
  }
  self.testCaseLock = NO;
  self.done = YES;
}

-(void)gitHubService:(id <GitHubService>)gitHubService didFailWithError:error {
  
  if ([self.testCase isEqualToString:@"testSearchRepo1"]) {
    
    STFail(@"Got done with errors");
    
  } else if ([self.testCase isEqualToString:@"testSearchRepo2"]) {
    
    STFail(@"Got done with errors");
    [GitHubServiceSettings hidePrivateRepositories:NO];
  }
  self.testCaseLock = NO;
  self.doneWithErrors = YES;
}

@end
