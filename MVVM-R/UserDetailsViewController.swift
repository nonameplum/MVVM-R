//
//  DetailsViewController.swift
//  MVVM-C Example
//
//  Created by Łukasz Śliwiński on 06/09/16.
//  Copyright © 2016 Plum's organization. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    deinit { print("deinit \(self.dynamicType)") }

    // MARK: IBOutlets

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!

    // MARK: Properties

    var viewModel: UserDetailsViewModel!

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self

        firstNameTextField.addTarget(self, action: #selector(firstNameTextFieldTextChanged(_:)), forControlEvents: UIControlEvents.EditingChanged)
        lastNameTextField.addTarget(self, action: #selector(lastNameTextFieldTextChanged(_:)), forControlEvents: UIControlEvents.EditingChanged)
    }

    // MARK: Actions

    @IBAction func saveButtonTapped(sender: UIButton) {
        viewModel.saveData()
    }

    @IBAction func infoButtonTapped(sender: UIButton) {
        viewModel.showInfo()
    }

    func firstNameTextFieldTextChanged(textField: UITextField) {
        viewModel.firstName = textField.text ?? ""
    }

    func lastNameTextFieldTextChanged(textField: UITextField) {
        viewModel.lastName = textField.text
    }

}

extension UserDetailsViewController: UserDetailsViewModelDelegate {

    func saveButtonEnabled(enabled: Bool) {
        saveButton.enabled = enabled
    }

}
