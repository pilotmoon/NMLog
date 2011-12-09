//
// Copyright (c) 2011 Nick Moore
//  
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software
// and associated documentation files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
// BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
//

#import "NMLog.h"

NSString *const kNMLogLevel=@"NMLogLevel";
NSString *const kNMLogFiles=@"NMLogFiles";

void NMLogLog(NSString *levelName, NSInteger levelNumber, NSString *filePath, NSString *format, ...)
{
    /*
     The file name on its own without extension(s).
     For efficiency, we only break out the file name from the path when actually needed.
     We do this by calling getFileNameOnce() when we want to use it.
    */
    __block NSString *fileName=nil;
    NSString *(^getFileNameOnce)(void)=^{
        return fileName?fileName:(fileName=[[[filePath lastPathComponent] componentsSeparatedByString:@"."] objectAtIndex:0]);
    };
    
    // do specifiers match the filename?
    BOOL fileMatches=NO;
    for (NSString *const specifiedName in [[NSUserDefaults standardUserDefaults] arrayForKey:kNMLogFiles]) {
        if ([specifiedName isEqualToString:getFileNameOnce()]) {
            fileMatches=YES;
            break;
        }
    }
    
    // do the logging
    if (fileMatches||[[NSUserDefaults standardUserDefaults] integerForKey:kNMLogLevel] >= levelNumber) {
		va_list args;
		va_start(args, format);
		NSString *str = [[NSString alloc] initWithFormat:format arguments:args];
		NSLog(@"[%@] %@: %@", levelName, getFileNameOnce(), str);
		[str release];
		va_end(args);
	}
}