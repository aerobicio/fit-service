# fit-service

A service for parsing FIT files into workout objects.

## Dependencies

* JRuby 1.7.9
* [JFit](https://github.com/aerobicio/jfit) a JRuby library for parsing FIT files.

## Integrating with the fit-service

The fit-service provides a gem that can be included in your rails application.

This gem handles the following tasks:

* Authentication
* Interacting with the fit-service API
* Stubbing the fit-service API when in the test environment

## Setting up your development environment

Once you have jruby 1.7.9 installed, simply run the bootstrap script to set up
your development environment.

    $ script/bootstrap
