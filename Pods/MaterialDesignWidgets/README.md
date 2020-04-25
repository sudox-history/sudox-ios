


## Material Design Widgets - Lightweight
This framework give you full flexibility to apply any material design widget you would like to use in your app! Please see below steps if you only need to use one or two of the entire package widgets. 

[![Generic badge](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://shields.io/) [![Generic badge](https://img.shields.io/badge/iOS-11.0+-blue.svg)](https://shields.io/)  [![Generic badge](https://img.shields.io/badge/Version-0.1.0-orange.svg)](https://shields.io/) [![Generic badge](https://img.shields.io/badge/pod-0.1.0-lightgrey.svg)](https://shields.io/) [
![Generic badge](https://img.shields.io/badge/platform-ios-green.svg)](https://shields.io/) 

<img src="gif/overview.gif" alt="overview" width="250"/>

You may download **MaterialDesignWidgetsDemo** to see how its used in your app. 

## Key Features
- A full package of material design widgets that you'll need to upgrade your app's visual.
- Widget classes are made to be **open**, which gives you flexibility to create your own.
- Instead of pull down the entire package, you can also copy the source of any widget you need independently.
- If you decide to just use one of the widgets, you can follow below **usage** for instructions on which files you need for that specific widget.

## Requirements
- Swift 5.0
- iOS 11.0+

## Usage

### Buttons
Files  needed:
1. RippleLayer.swift
2. MaterialButton.swift

#### Normal Button
```swift
let btnSample1 = MaterialButton(text: "Sample1", cornerRadius: 15.0)
let btnSample2 = MaterialButton(text: "Sample2", textColor: .black, bgColor: .white)
```
<img src="gif/button.gif" alt="button" width="350"/>

#### Loading Button
```swift
let btnLoading = MaterialButton(text: "Loading Button", cornerRadius: 15.0)
loadingBtn.addTarget(self, action: #selector(tapLoadingButton(sender:)), for: .touchUpInside)

@objc func tapLoadingButton(sender: MaterialButton) {
	sender.isLoading = !sender.isLoading
	sender.isLoading ? sender.showLoader(userInteraction: true) : sender.hideLoader()
}
```
<img src="gif/loadingButton.gif" alt="loadingButton" width="350"/>

#### Shadow Button
```swift
let btnShadow = MaterialButton(text: "Shadow Button", cornerRadius: 15.0, withShadow: true)
```
<img src="gif/shadowButton.gif" alt="shadowButton" width="350"/>

#### Vertical Aligned Button
```swift
let img = UIImage(named: "Your image name")
let btnV = MaterialVerticalButton(icon: img, title: "Fill", foregroundColor: .black, bgColor: .white)
```

<img src="gif/verticalButton.gif" alt="verticalButton" width="350"/>

### Segmented Control
Files  needed:
1. MaterialSegmentedControl.swift
```swift
var segments = [UIButton]() // Segments are in the Button form.
for i in 0..<3 {
	let button = MaterialButton(text: "Segment \(i)", textColor: .gray, bgColor: .clear, cornerRadius: 18.0)
	segments.append(button)
}
```
#### Filled
```swift
let sgFilled = MaterialSegmentedControl(segments: segments, selectorStyle: .fill, textColor: .black, selectorTextColor: .white, selectorColor: .black)

// Below is styling, you can write your own.
sgFilled.backgroundColor = .lightGray
sgFilled.setCornerBorder(cornerRadius: 18.0)
```

<img src="gif/segmentFill.gif" alt="segmentFill" width="350"/>

#### Outline
```swift
let sgOutline = MaterialSegmentedControl(segments: segments, selectorStyle: .line, textColor: .black, selectorTextColor: .white, selectorColor: .black)
```

<img src="gif/segmentOutline.gif" alt="segmentOutline" width="350"/>

#### Line
```swift
let sgLine = MaterialSegmentedControl(selectorStyle: .line, textColor: .black, selectorTextColor: .black, selectorColor: .black, bgColor: .white)
```

<img src="gif/segmentLine.gif" alt="segmentLine" width="350"/>

### TextField
Files  needed:
1. RippleLayer.swift
2. MaterialTextField.swift
```swift
let textField = MaterialTextField(hint: "TextField", textColor: .black, bgColor: .white)
```

<img src="gif/textField.gif" alt="textField" width="350"/>

### Loading Indicator
Files  needed:
1. MaterialLoadingIndicator.swift
```swift
let indicatorBlack = MaterialLoadingIndicator(radius: 15.0, color: .black)
indicatorBlack.startAnimating()
let indicatorGray = MaterialLoadingIndicator(radius: 15.0, color: .gray)
indicatorGray.startAnimating()
```
<img src="gif/loading.gif" alt="loading" width="350"/>

## Installation

MaterialDesignWidgets is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
$ pod 'MaterialDesignWidgets'
```

If you don't use CocoaPods, you can download the entire project then drag and drop all the classes and use them in your project.

## Credits
* [Material Design](https://material.io/design/)
* [Le Van Nghia](https://github.com/sharad-paghadal/MaterialKit/tree/master/Source)
* [Icons8](https://icons8.com/)