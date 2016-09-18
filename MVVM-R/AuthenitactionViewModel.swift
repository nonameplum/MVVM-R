//
//  AuthenitactionViewModel.swift
//  MVVM-C Example
//
//  Created by Łukasz Śliwiński on 05/09/16.
//  Copyright © 2016 Plum's organization. All rights reserved.
//

import Foundation

protocol AuthenticationViewModelDelegate: class {
    func showInvalidCredentials(message: String)
    func credentialsValidated(valid: Bool)
}

class AuthenticationViewModel {

    // MARK: Properties

    var username: String? { didSet { validate() } }
    var password: String? { didSet { validate() } }

    weak var context: AppContext!
    var routeCallback: String?

    weak var delegate: AuthenticationViewModelDelegate? { didSet { doInitialSetup() } }

    // MARK: Initialization

    init(context: AppContext) {
        self.context = context
    }

    private func doInitialSetup() {
        username = nil
        password = nil
        validate()
    }

    // MARK: Actions

    func login() {
        if username == "root" && password == "admin" {
            context.isLoggedIn = true
            context.openRoute(.Users, data: nil)
        } else {
            delegate?.showInvalidCredentials("Invalid message user or password!")
        }
    }

    // MARK: Helpers

    private func validate() {
        delegate?.credentialsValidated(username != nil && username!.characters.count > 3 && password != nil && password!.characters.count > 1)
        delegate?.showInvalidCredentials("")
    }

}
