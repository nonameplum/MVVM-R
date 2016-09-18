//
//  AuthViewController.swift
//  MVVM-C Example
//
//  Created by Łukasz Śliwiński on 05/09/16.
//  Copyright © 2016 Plum's organization. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {

    deinit { print("deinit \(self.dynamicType)") }

    // MARK: IBOutlets

    @IBOutlet weak var errorIndicatorLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    // MARK: Properties

    var viewModel: AuthenticationViewModel!

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self

        usernameTextField.addTarget(self, action: #selector(usernameTextFieldTextChanged(_:)), forControlEvents: UIControlEvents.EditingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldTextChanged(_:)), forControlEvents: UIControlEvents.EditingChanged)
    }

    // MARK: Actions

    @IBAction func loginButtonTapped(sender: UIButton) {
        viewModel.login()
    }

    func usernameTextFieldTextChanged(textField: UITextField) {
        viewModel.username = textField.text
    }

    func passwordTextFieldTextChanged(textField: UITextField) {
        viewModel.password = textField.text
    }

}

extension AuthenticationViewController: AuthenticationViewModelDelegate {

    func showInvalidCredentials(message: String) {
        errorIndicatorLabel.text = message
    }

    func credentialsValidated(valid: Bool) {
        loginButton.enabled = valid
    }

}
