//
//  TestGitHubUserServer.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "TestGitHubUserServer.h"
#import "GitHubUserServiceFactory.h"
#import "GitHubService.h"
#import "GitHubBaseFactory.h"

@implementation TestGitHubUserServer

@synthesize testCaseLock, response, userSearchCount, testCase, doneWithErrors,
done;

-(void)initTestCase:(NSString *)name {
  
  [GitHubBaseFactory
   setServerAddress:[NSString stringWithFormat:@"file://%@/TestData", SRCROOT]];
  
  self.testCase = name;
  self.testCaseLock = YES;
  self.userSearchCount = 0;
  self.done = NO;
  self.doneWithErrors = NO;
}

//Read four users from file
-(void)testSearchUser1 {
  
  [self initTestCase:NSStringFromSelector(_cmd)];
  [GitHubUserServiceFactory searchUsersByName:@"testSearchUser1" delegate:self];
  
  while (self.testCaseLock) {
    
    [[NSRunLoop currentRunLoop]
     runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
  }
  STAssertFalse(self.doneWithErrors, @"Done with errors sent");
  STAssertTrue(self.done, @"Done not sent");
}

//Path does not exist (network error)
-(void)testSearchUser2 {
  
  [self initTestCase:NSStringFromSelector(_cmd)];
  [GitHubUserServiceFactory searchUsersByName:@"testSearchUser2" delegate:self];
  
  while (self.testCaseLock) {
    
    [[NSRunLoop currentRunLoop]
     runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
  }
  STAssertTrue(self.doneWithErrors, @"Done with errors not sent");
  STAssertFalse(self.done, @"Done sent");
}

//Unexpected xml error tag
-(void)testSearchUser3 {
  
  [self initTestCase:NSStringFromSelector(_cmd)];
  [GitHubUserServiceFactory searchUsersByName:@"testSearchUser3" delegate:self];
  
  while (self.testCaseLock) {
    
    [[NSRunLoop currentRunLoop]
     runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
  }
  STAssertTrue(self.doneWithErrors, @"Done with errors not sent");
  STAssertFalse(self.done, @"Done sent");
}

//Unexpected gibberish instead of xml
-(void)testSearchUser4 {
  
  [self initTestCase:NSStringFromSelector(_cmd)];
  [GitHubUserServiceFactory searchUsersByName:@"testSearchUser4" delegate:self];
  
  while (self.testCaseLock) {
    
    [[NSRunLoop currentRunLoop]
     runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
  }
  STAssertTrue(self.doneWithErrors, @"Done with errors not sent");
  STAssertFalse(self.done, @"Done sent");
}

//Cancelled service, should have no response
//(2 seconds as estimate for infinity)

-(void)timeOut {
  
  self.testCaseLock = NO;
}

-(void)testSearchUser5 {
  
  [self initTestCase:NSStringFromSelector(_cmd)];
  
  id<GitHubService> request = [GitHubUserServiceFactory
                               searchUsersByName:@"testSearchUser5"
                               delegate:self];
  
  [request cancelRequest];
  
  [NSTimer scheduledTimerWithTimeInterval:2
                                   target:self
                                 selector:@selector(timeOut)
                                 userInfo:nil
                                  repeats:NO];
  
  while (self.testCaseLock) {
    
    [[NSRunLoop currentRunLoop]
     runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
  }
  STAssertFalse(self.doneWithErrors, @"Done with errors sent");
  STAssertFalse(self.done, @"Done sent");
}

//Cancelled service mid-execution, should have no response
//(2 seconds as estimate for infinity)
-(void)testSearchUser6 {
  
  [self initTestCase:NSStringFromSelector(_cmd)];
  [GitHubUserServiceFactory searchUsersByName:@"testSearchUser6" delegate:self];
  
  while (self.testCaseLock) {
    
    [[NSRunLoop currentRunLoop]
     runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
  }
  STAssertFalse(self.doneWithErrors, @"Done with errors sent");
  STAssertFalse(self.done, @"Done sent");
}

-(void)gitHubService:(id<GitHubService>)gitHubService
             gotName:(NSString *)name {
  
  self.userSearchCount++;
  
  if ([self.testCase isEqualToString:@"testSearchUser1"]) {
    
    switch (self.userSearchCount) {
      case 1:
        
        STAssertEqualObjects(name, @"hassox",
                             @"Name should be hassox, is %@", name);
        
        break;
      case 2:
        
        STAssertEqualObjects(name, @"toastdriven",
                             @"Name should be toastdriven, is %@", name);      
        
        break;
      case 3:
        
        STAssertEqualObjects(name, @"danielvlopes",
                             @"Name should be danielvlopes, is %@", name);
        
        break;
      case 4:
        
        STAssertEqualObjects(name, @"pydanny",
                             @"Name should be pydanny, is %@", name);
       
        break;
      default:
        
        STFail(@"Search Count Index Error, count is %@", self.userSearchCount);
        break;
    }
  } else if ([self.testCase isEqualToString:@"testSearchUser2"]) {
    
    STFail(@"Got user name from broken address, name is %@", name);
    
  } else if ([self.testCase isEqualToString:@"testSearchUser3"]) {
    
    STFail(@"Got user name from error xml, name is %@", name);
  } else if ([self.testCase isEqualToString:@"testSearchUser4"]) {
    
    STFail(@"Got user name from error xml, name is %@", name);
    
  } else if ([self.testCase isEqualToString:@"testSearchUser5"]) {
    
    STFail(@"Got user name from cancelled call, name is %@", name);
    
  } else if ([self.testCase isEqualToString:@"testSearchUser6"]) {
    
    if (self.userSearchCount == 2) {
      
      [gitHubService cancelRequest];
      
      [NSTimer scheduledTimerWithTimeInterval:2
                                       target:self
                                     selector:@selector(timeOut)
                                     userInfo:nil
                                      repeats:NO];
      
    } else if (self.userSearchCount > 2) {
      
      STFail(@"Got user name from cancelled call, name is %@", name);
    }
  }
}

-(void)gitHubServiceDone:(id <GitHubService>)gitHubService {
  
  if ([self.testCase isEqualToString:@"testSearchUser1"]) {
    
    STAssertEquals(4, self.userSearchCount,
                   @"User count should be 4, is %@", self.userSearchCount);
    
  } else if ([self.testCase isEqualToString:@"testSearchUser2"]) {
    
    STFail(@"Got done from broken address");
    
  } else if ([self.testCase isEqualToString:@"testSearchUser3"]) {
    
    STFail(@"Got done from error xml tag");
    
  } else if ([self.testCase isEqualToString:@"testSearchUser4"]) {
    
    STFail(@"Got done from error xml file");
    
  } else if ([self.testCase isEqualToString:@"testSearchUser5"]) {
    
    STFail(@"Got done from cancelled call");
    
  } else if ([self.testCase isEqualToString:@"testSearchUser6"]) {
    
    STFail(@"Got done from cancelled call");
  }
  self.testCaseLock = NO;
  self.done = YES;
}

-(void)gitHubService:(id <GitHubService>)gitHubService didFailWithError:error {
  
  if ([self.testCase isEqualToString:@"testSearchUser1"]) {
    
    STFail(@"Got done with errors");
    
  } else if ([self.testCase isEqualToString:@"testSearchUser2"]) {
    
  } else if ([self.testCase isEqualToString:@"testSearchUser3"]) {
    
  } else if ([self.testCase isEqualToString:@"testSearchUser4"]) {
    
  } else if ([self.testCase isEqualToString:@"testSearchUser5"]) {
    
    STFail(@"Got done with errors");
    
  } else if ([self.testCase isEqualToString:@"testSearchUser6"]) {
    
    STFail(@"Got done with errors");
  }
  self.testCaseLock = NO;
  self.doneWithErrors = YES;
}

@end
