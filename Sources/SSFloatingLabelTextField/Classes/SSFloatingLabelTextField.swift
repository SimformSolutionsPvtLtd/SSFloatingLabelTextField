//
//  SSFloatingLabelTextField.swift
//  SSFloatingLabelTextField
//
//  Created by Mohammed Hanif on 21/06/21.
//

import Foundation
import UIKit
import Combine

open class SSFloatingLabelTextField: UITextField {
    
    // MARK:- Variables
    /// placeholder label
    var placeholderLabel: UILabel = UILabel(frame: CGRect.zero)
    /// Error Label
    var errorLabel: UILabel = UILabel(frame: CGRect.zero)
    // Default height
    var placeholderLabelHeight: CGFloat = 14
    // Set any predefine validation type
    open var type: Type? {
        didSet {
            switch type {
            case .email:
                self.keyboardType = .emailAddress
            case .phoneNumber:
                self.keyboardType = .numberPad
            default:
                break
            }
        }
    }
    // Button for toggle password
    let button = UIButton(type: .custom)
    
    // Defines Placeholder label text
    @IBInspectable
    open var floatingLabelText: String?
    
    // Defines error text which will be displayed when text is not valid
    @IBInspectable
    open var errorText: String? {
        didSet {
            errorLabel.text = errorText
            setNeedsDisplay()
        }
    }
    
    // Color of error text
    @IBInspectable
    open var errorTextColor: UIColor = UIColor.black {
        didSet {
            errorLabel.textColor = errorTextColor
            setNeedsDisplay()
        }
    }
    
    // Color for floating label By defaul :- Blue
    @IBInspectable
    open var selectedLabelColor: UIColor = UIColor.blue
    
    // Color for floating label By defaul :- Grey
    @IBInspectable
    open var unSelectedLabelColor: UIColor = UIColor.gray
    
    // Set Custom regex for Text Validation
    @IBInspectable
    var customValidationRegex: String?
    
    @available(iOS 13.0, *)
    private(set) lazy var cancellables = [AnyCancellable]()
    
    // Set if you want to show hide password with icon
    @IBInspectable
    open var isPasswordToggleEnable: Bool = false {
        didSet {
            if isPasswordToggleEnable {
                enablePasswordToggle()
            }
        }
    }
    
    // Toggle image when password is shown (Only required if password toggle is enable)
    @IBInspectable
    open var showPasswordImage: UIImage? = UIImage(named: "eyeOpen") {
        didSet {
            setPasswordToggleImage(button)
        }
    }
    
    // Toggle image when password is hidden (Only required if password toggle is enable)
    @IBInspectable
    open var hidePasswordImage: UIImage? = UIImage(named: "eyeClose") {
        didSet {
            setPasswordToggleImage(button)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseSetup()
    }
    
    @objc func onEditingChanged() {
        updateValidation()
    }
    
    /// On Textfield editing end
    @objc func onEditingEnd() {
        placeholderLabel.textColor = unSelectedLabelColor
        setNeedsDisplay()
    }
    
    /// /// On Textfield editing begin
    @objc func onEditingBegin() {
        placeholderLabel.textColor = selectedLabelColor
        setNeedsDisplay()
    }
    
    /// When toggle password is clicked
    /// - Parameter sender: UIButton used for toggle
    @IBAction func togglePasswordView(_ sender: UIButton) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender)
    }
    
    /// Initial Setup
    fileprivate func baseSetup() {
        placeholderLabel = UILabel(frame: CGRect.zero)
        addTarget(self, action: #selector(self.onEditingBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(self.onEditingEnd), for: .editingDidEnd)
        addError()
        if #available(iOS 13.0, *) {
            setUpValidations()
        } else {
            addTarget(self, action: #selector(self.onEditingChanged), for: .editingChanged)
        }
    }
    
    /// Add Validations
    @available(iOS 13.0, *)
    func setUpValidations() {
        NotificationCenter.default.publisher(for: SSFloatingLabelTextField.textDidChangeNotification, object: self)
            .sink { (text) in
                self.updateValidation()
            }.store(in: &cancellables)
    }
    
    /// Set password toggle images
    /// - Parameter button: UI Button which is used for toggle
    func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry) {
            button.setImage(hidePasswordImage, for: .normal)
        } else {
            button.setImage(showPasswordImage, for: .normal)
        }
    }
    
    /// Enable password toggle
    func enablePasswordToggle(){
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
        setPasswordToggleImage(button)
    }
    
    /// Validate text according to the validation types
    func updateValidation() {
        self.addFloatingLabel()
        guard let _validationType = self.type else {
            self.validate(regex: nil)
            return
        }
        switch _validationType {
        case .phoneNumber(let formatterString):
            text = text?.format(with: formatterString ?? Constants.phoneNumberMask)
            self.addFloatingLabel()
        default:
            break
        }
        if self.customValidationRegex != nil {
            self.validate(regex: self.customValidationRegex)
        } else {
            switch _validationType {
            case .email:
                self.validate(regex: Constants.emailRegex)
            case .password(let rule):
                switch rule {
                case .weak:
                    self.validate(regex: Constants.weakPasswordRegex)
                case .medium:
                    self.validate(regex: Constants.mediumPasswordRegex)
                case .strong:
                    self.validate(regex: Constants.strongPasswordRegex)
                }
            case .phoneNumber(let mask):
                if self.text?.count == (mask?.count ?? Constants.phoneNumberMask.count) {
                    remmoveError()
                } else {
                    addError()
                }
            }
        }
    }
    
    /// Validate any regex ans show hide error
    /// - Parameter regex: regex which needs to be validated
    func validate(regex: String?) {
        if text?.isValidRegex(regex: regex) ?? false {
            remmoveError()
        } else {
            addError()
        }
    }
    
    /// Add label if not already added
    func addFloatingLabel() {
        if text != "" {
            if (self.subviews.contains(placeholderLabel)) {
                return
            }
            placeholderLabel.textColor = selectedLabelColor
            placeholderLabel.font = UIFont.systemFont(ofSize: 15.0)
            placeholderLabel.text = floatingLabelText
            placeholderLabel.layer.backgroundColor = UIColor.white.cgColor
            placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
            placeholderLabel.clipsToBounds = true
            placeholderLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: placeholderLabelHeight)
            self.addSubview(self.placeholderLabel)
            UIView.animate(withDuration: 0.5) {
                self.placeholderLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -10).isActive = true // Place our label 10pts above the text field
            }
        } else {
            self.placeholderLabel.removeFromSuperview()
        }
        self.setNeedsDisplay()
    }
    
    /// Add error if not already added
    func addError() {
        if (self.subviews.contains(errorLabel)) {
            return
        }
        errorLabel.font = UIFont.systemFont(ofSize: 15.0)
        errorLabel.numberOfLines = 0
        errorLabel.layer.backgroundColor = UIColor.white.cgColor
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.clipsToBounds = true
        errorLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: placeholderLabelHeight)
        self.addSubview(self.errorLabel)
        UIView.animate(withDuration: 0.5) {
            self.errorLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true // Place our label 10pts below the text field
            self.errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
            self.errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        }
        setNeedsDisplay()
    }
    
    /// remove error
    func remmoveError() {
        if text != "" {
            self.errorLabel.removeFromSuperview()
        }
        setNeedsDisplay()
    }
    
    /// Check if current text field is valid or not
    /// - Parameter validationType: Validation typr if used predefine
    /// - Returns: return is textfield is valid or not
    open func isValid() -> Bool {
        guard let validation = type else {
            return !(text?.isEmpty ?? false)
        }
        if customValidationRegex != nil {
            return text?.isValidRegex(regex: customValidationRegex) ?? false
        } else {
            switch (validation) {
            case .email:
                return text?.isValidRegex(regex: Constants.emailRegex) ?? false
            case .password(let rule):
                switch rule {
                case .weak:
                    return text?.isValidRegex(regex: Constants.weakPasswordRegex) ?? false
                case .medium:
                    return text?.isValidRegex(regex: Constants.mediumPasswordRegex) ?? false
                case .strong:
                    return text?.isValidRegex(regex: Constants.strongPasswordRegex) ?? false
                }
            case .phoneNumber(let mask):
                return text?.count == (mask?.count ?? Constants.phoneNumberMask.count)
            }
        }
    }
    
}
