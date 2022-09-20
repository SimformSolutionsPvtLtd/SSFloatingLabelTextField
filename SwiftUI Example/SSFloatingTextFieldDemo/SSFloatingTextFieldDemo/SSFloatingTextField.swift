//
//  SSFloatingTextField.swift
//  SSFloatingTextFieldDemo
//
//  Created by Parth Dumaswala on 19/09/22.
//

import UIKit
import SwiftUI
import SSFloatingLabelTextField

public struct SSFloatingTextField: UIViewRepresentable {
    
    //MARK: - Variables
    public typealias UIViewType = UITextField
    var text: String
    var onCommit: (String) -> Void
    
    //MARK: - Cordinator
    class cordinator: NSObject, UITextFieldDelegate {
        
        var parent: SSFloatingTextField
        var onCommit: (String) -> Void
        
        init(parent: SSFloatingTextField, onCommit: @escaping (String) -> Void) {
            self.parent = parent
            self.onCommit = onCommit
        }
        
        func textFieldDidChange(_ textField: UITextField) {
            //self.parent.$text.wrappedValue = textField.text ?? ""
            print(textField.text ?? "")
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.onCommit(textField.text ?? "")
        }
    }
    
    private func baseSetup() -> UITextField {
        
        let floatingTextField = SSFloatingLabelTextField()
        floatingTextField.type = .email

        floatingTextField.textContentType = .emailAddress
        floatingTextField.backgroundColor = .black
        floatingTextField.textColor = .white
        floatingTextField.selectedLabelColor = .green
        floatingTextField.placeholder = "Enter Email"
        floatingTextField.floatingLabelText = "Email"
        floatingTextField.errorText = "Please enter a valid email"
        floatingTextField.errorTextColor = .red
        
        return floatingTextField
    }
    
    public func makeUIView(context: Context) -> UITextField {
        baseSetup()
    }
    
    public func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
}
