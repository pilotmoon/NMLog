# NMLog

Simple, controllable logging for Objective-C.

## Features

* Print message type (INFO, WARNING etc.) as part of message.
* Print source file name as part of log message.
* Control log detail by setting a level from 0 to 3 (defined in NSUserDefaults).
* Selectively enable detailed logging of specific source files (defined in NSUserDefaults).

Example usage:

    NMLogInfo(@"App starting"); // in file main.m
    ...
    NMLogError(@"Bad thing happened: %i", count); // in file MyFile.m

Example output:

    2011-12-09 17:08:20.778 MyApp[48717:407] [INFO] main: App Starting
    2011-12-09 17:08:20.778 MyApp[48717:407] [ERROR] MyFile: Bad thing happened: 1

NMLog.h provides several macros which function as drop-in replacements for NSLog:

	Macro           Label   Level
	NMLogError      ERROR   0 
	NMLogImportant	INFO    0
	NMLogInfo	    INFO    1
	NMLogWarning    WARNING 1
	NMLogFine       FINE    2
	NMLogTiny       TINY    3

You can globally disable all logging by defining `NMLOG_DISABLE_ALL` in the preprocessor, and you can disable all except Error and Important with `NMLOG_DISABLE_INFO`.

You can specify the logging level at the console with the `NMLogLevel` key:

    defaults write com.example.app NMLogLevel -int 1

And to specify files for which you want to turn on detailed logging with `NMLogFiles`:

    defaults write com.example.app NMLogFiles -array MyFile MyOtherFile MyThirdFile

Specified names match the file name up to the first dot. So, `MyFile` would match `/User/me/code/MyFile.m`.

## Credits

NMLog started out life as a straight copy of Andrew Pepperrell's [APLog](http://preppeller.com/2011/12/08/simple-more-flexible-objective-c-logging/). Nick Moore tinkered with it and it morphed into its current form. Some of Andrew's original code is still there mostly intact (specifically, lines 50-57 of `NMLog.m`, at the time of writing).