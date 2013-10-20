//
//  main.m
//  kvc-demo
//
//  Created by Adam Keys on 10/15/13.
//  Copyright (c) 2013 Adam Keys. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSDictionary *bestOfBeatles = @{@"paul": @{@"beatles": @"Hey Jude", @"solo": @"Jet"}};
        
        NSString *solo = [bestOfBeatles valueForKeyPath:@"paul.solo"];
        NSLog(@"Paul's Best solo song is: %@", solo);
        
//        NSMutableDictionary *dict = [bestOfBeatles mutableCopy];
//        [dict setValue:@"Live and Let Die" forKeyPath:@"paul.solo"];

        
    }
    return 0;
}

