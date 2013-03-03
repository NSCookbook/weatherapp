NSCookbook Weather Application
==========

NSCookbook's demo weather application

###Getting Started

Weather uses [CocoaPods](http://cocoapods.org) for dependency management. You must install CocoaPods before running the app.

**Install**

* CocoaPods is distributed as a ruby gem, installing it is as easy as running the following commands in the terminal:

````
$ [sudo] gem install cocoapods
$ pod setup
````

* Now you can install the dependencies, first cd to the project root where Weather.xcodeproject lives, then run

````
$ pod install
````

**Make sure to always open the Xcode workspace instead of the project file when building the project or it won't build.**

````
$ open Weather.xcworkspace
````

###Adding Your Weather Underground API Key

* Open **WeatherAPIKey.h**.
* Open the URL specified in the that header if you don't have an account to create one. Replace the default text with your unique API key.

###Tags

* Code for each recipe has been tagged with the recipe number. Be sure to pull the correct tag when following along with a particular recipe!

| Recipe Article | Revision Tag | 
| ------------ 	| ------------- |
| [Recipe 15: Building A Weather Application](http://nscookbook.com/2013/02/ios-programming-recipe-15-building-a-weather-application/) | recipe-15  |

###License

NSCookbook's weather app is available under the MIT license. See the LICENSE file for more info.
