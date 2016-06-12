MVVM Sample
===========

MVVM Sample is a login use case implementation of the Model-View-ViewModel (MVVM) architecture using [ReactiveCocoa 4][reactive-cocoa].

[reactive-cocoa]: https://github.com/ReactiveCocoa/ReactiveCocoa


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

One of the main advantages of the MVVM Architecture is the high testability with a minimal setup. It's based on the separation of the app logic (ViewModel layer) from presentation (View layer).

Unit tests are written using the BDD frameworks [Quick][quick] and [Nimble][nimble]. 

To run the unit tests simply hit `Cmd + U` in Xcode. 

[quick]: https://github.com/Quick/Quick
[nimble]: https://github.com/Quick/Nimble


