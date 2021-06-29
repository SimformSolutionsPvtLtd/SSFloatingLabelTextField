//
//  ViewController.swift
//  SSFloatingLabelTextField
//
//  Created by Mohammed Hanif on 21/06/21.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var txtUsername: SSFloatingLabelTextField!
    @IBOutlet weak var txtEmail: SSFloatingLabelTextField!
    @IBOutlet weak var txtPassword: SSFloatingLabelTextField!
    @IBOutlet weak var txtPhoneNumber: SSFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.type = .email
        txtPassword.type = .password(passwordRule: .medium)
        txtPhoneNumber.type = .phoneNumber(formatterString: nil)
        hideKeyboardWhenTappedAround()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func btnValidate(_ sender: UIButton) {
        print(txtUsername.isValid())
        print(txtEmail.isValid())
        print(txtPassword.isValid())
        print(txtPhoneNumber.isValid())
    }
    
}
