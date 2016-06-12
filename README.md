MVVM Sample
===========

A simple login use case implementation of the Model-View-ViewModel (MVVM) architecture using [ReactiveCocoa 4][reactive-cocoa].

[reactive-cocoa]: https://github.com/ReactiveCocoa/ReactiveCocoa


Requirements
------------

It runs on iOS 9+ and requires Xcode 7.3 with Swift 2.2 to build.

Setup
-----

Run a Mock Auth backend in localhost.
```
ruby MockRestServlet.rb
```

Unit Tests
----------

MVVM separation of logic from presentation provides high testability with a minimal setup.
For instance you don't need the ruby Mock backend for testing purposes since an offline Mock AuthService is injected on test cases.
Unit tests are written using the BDD frameworks [Quick][quick] and [Nimble][nimble]. 
To run the unit tests simply hit `Cmd + U` in Xcode. 


[quick]: https://github.com/Quick/Quick
[nimble]: https://github.com/Quick/Nimble


