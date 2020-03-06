---
title: NSApplicationCrashOnExceptions
description: A post in the Apple dev forums reminded fellow developers about AppKit's default exception handling
date: 2020-02-03 18:00
tags: AppKit, NSApplicationCrashOnExceptions, Exceptions, Error
typora-copy-images-to: ../../Resources/images
typora-root-url: ../../Resources
---

A post in the Apple dev forums reminded fellow developers about AppKit's default exception handling:

> “AppKit has a default exception handler that catches all language exceptions raised by code run from its run loop. It logs the exception and then swallows it, allowing the app to continue running. Who thought that was a good idea!?!”
>
> – [https://forums.developer.apple.com/thread/128559](https://forums.developer.apple.com/thread/128559)

The best documentation about the `NSApplicationCrashOnExceptions` key has Microsoft:

> AppKit catches exceptions thrown on the main thread, preventing the application from crashing on macOS, so the SDK cannot catch these crashes. To mimic iOS behavior, set NSApplicationCrashOnExceptions flag before SDK initialization, this will allow the application to crash on uncaught exceptions and the SDK can report them.
>
> `UserDefaults.standard.register(defaults: ["NSApplicationCrashOnExceptions": true])`
>
> – [https://docs.microsoft.com/en-us/appcenter/sdk/crashes/macos](https://docs.microsoft.com/en-us/appcenter/sdk/crashes/macos)

More about this topic:

- [https://openradar.appspot.com/41809382](https://openradar.appspot.com/41809382)
- [https://github.com/microsoft/appcenter-sdk-apple/issues/1725](https://github.com/microsoft/appcenter-sdk-apple/issues/1725)
- [https://docs.fabric.io/apple/crashlytics/os-x.html](https://docs.fabric.io/apple/crashlytics/os-x.html)
- [https://siddarthkalra.github.io/2019/04/19/uncaught-exceptions-macos.html](https://siddarthkalra.github.io/2019/04/19/uncaught-exceptions-macos.html)
- [https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Exceptions/Exceptions.html](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Exceptions/Exceptions.html)