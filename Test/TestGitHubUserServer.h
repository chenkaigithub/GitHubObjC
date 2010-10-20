//
//  TestGitHubUserServer.h
//  GitHubLib


#import <SenTestingKit/SenTestingKit.h>
#import "GitHubServiceGotNameDelegate.h"

@interface TestGitHubUserServer : SenTestCase <GitHubServiceGotNameDelegate> {
  BOOL testCaseLock;
  BOOL response;
  NSInteger userSearchCount;
  NSString *testCase;
  BOOL done;
  BOOL doneWithErrors;
}

@property (assign) BOOL testCaseLock;
@property (assign) BOOL doneWithErrors;
@property (assign) BOOL done;
@property (assign) BOOL response;
@property (assign) NSInteger userSearchCount;
@property (copy) NSString *testCase;

-(void)testSearchUser1;
-(void)testSearchUser2;
-(void)testSearchUser3;
-(void)testSearchUser4;
-(void)testSearchUser5;
-(void)testSearchUser6;

@end
