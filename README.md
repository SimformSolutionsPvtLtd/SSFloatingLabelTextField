<a href="https://www.simform.com/"><img src="https://github.com/mobile-simformsolutions/SSFloatingLabelTextField/blob/main/screenshots/simformBanner.png"></a>

[![Platform][platform-image]][platform-url]
[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]
[![PRs Welcome][PR-image]][PR-url]

# SSFloatingLabelTextField

SSFloatingLabelTextField is a smal library for iOS whic supports Floating labels and errors for different kind of validations.

![Alt text](https://github.com/mobile-simformsolutions/SSFloatingLabelTextField/blob/main/screenshots/SSFloatingTextField.gif?raw=true)

# Features!

Main Features include :- 
- Floating Placeholder label 
- Set different validations type 
- Check if text is valid or not and display error message

All Attributes :- 
| Attribute | Description |
| --- | --- |
| `floatingLabelText` | Floating Placeholder label 
| `selectedLabelColor` | Color of Floating label when textfield is active
| `unSelectedLabelColor` | Color of Floating label when textfield is active
| `errorText` | Error message when text is not valid 
| `errorTextColor` | Color in which error message is shown
| `type` | Set Validation type 
| `customValidationRegex` | Set Custom Regex for Validation 
| `isPasswordToggleEnable` | Toggle show hide password 
| `showPasswordImage` | Toggle image when password is visible
| `hidePasswordImage` | Toggle image when password is visible
  
  # Requirements
    - iOS 11.0+
    - Xcode 11+

 # Installation
#### CocoaPods
 
- You can use CocoaPods to install `SSFloatingLabelTextField` by adding it to your Podfile:

       use_frameworks!
       pod 'SSFloatingLabelTextField'

- Import SSFloatingLabelTextField in your file:

       import SSFloatingLabelTextField
       
    **Manually**
       -   Download and drop **SSFloatingLabelTextField/Sources** folder in your project.
       -   Congratulations!


# Usage example

In the storyboard add a UITextField and change its class to SSFloatingLabelTextField

<img src="https://github.com/mobile-simformsolutions/SSFloatingLabelTextField/blob/main/screenshots/Installation.png">

Import SSFloatingLabelTextField
        
        import SSFloatingLabelTextField
        
Set text type in your View Controller file :- 

        @IBOutlet weak var txtUsername: SSFloatingLabelTextField! // Add IBOutlet
        txtEmail.type = .email // Assign type as email
        txtPassword.type = .password(passwordRule: .medium) // Assign type as password 
        txtPhoneNumber.type = .phoneNumber(formatterString: nil) // Assign type as phone number (Params :- Phone number formatter default :- XXX-XXX-XXXX )
        
Check if given text field is valid or not :- 
        
        txtUsername.isValid()
        

## Find this library useful? :heart:
Support it by joining __[stargazers](https://github.com/mobile-simformsolutions/SSFloatingLabelTextField/stargazers)__ for this repository. :star:

## 🤝 How to Contribute

Whether you're helping us fix bugs, improve the docs, or a feature request, we'd love to have you! :muscle:

Check out our [**Contributing Guide**](https://github.com/mobile-simformsolutions/SSFloatingLabelTextField/blob/master/CONTRIBUTING.md) for ideas on contributing.

## Bugs and Feedback

For bugs, feature requests, and discussion please use [GitHub Issues](https://github.com/mobile-simformsolutions/SSFloatingLabelTextField/issues).


#  Meta
- This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
       
       
[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[platform-image]:https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat
[platform-url]:https://github.com/mobile-simformsolutions/SSSwiftUISpinnerButton
[PR-image]:https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square
[PR-url]:http://makeapullrequest.com
