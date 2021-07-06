//
//  Constants + Enums.swift
//  SSFloatingLabelTextField
//
//  Created by Mohammed Hanif on 30/06/21.
//

import Foundation

class Constants {
    static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    //    Minimum eight characters, at least one letter, one number and one special character:
    static let weakPasswordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$"
    //    Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character:
    static let mediumPasswordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
    //    Minimum eight and maximum 10 characters, at least one uppercase letter, one lowercase letter, one number and one special character:
    static let strongPasswordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,10}$"
    // Phone number formatter mask
    static var phoneNumberMask = "XXX-XXX-XXXX"
}

enum Type {
    case email
    case password(passwordRule: PasswordRule)
    case phoneNumber(formatterString: String?)
}

enum PasswordRule {
    case weak
    case medium
    case strong
}
