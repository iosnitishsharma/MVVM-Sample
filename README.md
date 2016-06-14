MVVM Sample
===========

MVVM Sample is a login use case implementation of the MVVM architecture using [ReactiveCocoa 4][reactive-cocoa].

[reactive-cocoa]: https://github.com/ReactiveCocoa/ReactiveCocoa

Also if you want to compare both, I've implemented this same case using the VIPER architecture -> [VIPER-Sample][viper-sample]

[viper-sample]: https://github.com/juanip027/VIPER-Sample

Requirements
------------

It runs on iOS 9+ and requires Xcode 7.3 with Swift 2.2 to build.

Setup
-----

Run the Mock Auth backend in localhost.
```bash
ruby MockRestServlet.rb
```

Use cocoapods to install the dependencies. 
```bash
pod install 
```
Open the workspace in xCode. 


Unit Tests
----------

One of the main advantages of the MVVM Architecture is the high testability with a minimal setup, because of the separation of the app logic (ViewModel layer) from presentation (View layer).

Unit tests were written using the BDD frameworks [Quick][quick] and [Nimble][nimble]. 

To run the unit tests simply hit `Cmd + U` in Xcode. 

[quick]: https://github.com/Quick/Quick
[nimble]: https://github.com/Quick/Nimble


