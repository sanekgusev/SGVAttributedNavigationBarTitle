# SGVAttributedNavigationBarTitle

[![CI Status](http://img.shields.io/travis/Alexander Gusev/SGVAttributedNavigationBarTitle.svg?style=flat)](https://travis-ci.org/Alexander Gusev/SGVAttributedNavigationBarTitle)

Enables attributed strings as navigation item titles. Should be enabled separately for each `UINavigationBar` instance by setting `UINavigationBar.sgv_attributedTitleEnabled` to YES. After that, all navigation items that have `UINavigationItem.sgv_attributedTitle` set to an `NSAttributedString` will display their corresponding attributed strings when pushed onto the navigationBar.

Some runtime magic is involved.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.
You should also be able to see this in action by

	pod try SGVAttributedNavigationBarTitle

## Requirements

iOS7+. A pinch of bravery.

## Installation

SGVAttributedNavigationBarTitle is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "SGVAttributedNavigationBarTitle"

## Author

Alexander Gusev, sanekgusev@gmail.com

## License

SGVAttributedNavigationBarTitle is available under the MIT license. See the LICENSE file for more info.

