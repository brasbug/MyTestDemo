//
//  TestMethod.h
//  JavaScriptCore-Demo
//
//  Created by Jack on 15/12/11.
//  Copyright © 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol TestMethodJSExport <JSExport>
JSExportAs
(calculateForJS
 /** handleFactorialCalculateWithNumber 作为js方法的别名 */,
 - (void)test:(NSNumber *)number
 );

- (void)pushViewController:(NSString *)view title:(NSString *)title;
@end

@interface TestMethod : NSObject<TestMethodJSExport>

- (void)testMethod;
@end
