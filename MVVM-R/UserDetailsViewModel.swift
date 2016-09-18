//
//  DetailsViewModel.swift
//  MVVM-C Example
//
//  Created by Łukasz Śliwiński on 06/09/16.
//  Copyright © 2016 Plum's organization. All rights reserved.
//

import Foundation

protocol UserDetailsViewModelDelegate: class {
    func saveButtonEnabled(enabled: Bool)
}

class UserDetailsViewModel {

    // MARK: Properties

    weak var context: AppContext!

    var firstName: String = "" { didSet { validate() } }
    var lastName: String? { didSet { validate() } }

    weak var delegate: UserDetailsViewModelDelegate? { didSet { validate() } }

    // MARK: Initialization

    init(context: AppContext) {
        self.context = context
    }

    // MARK: Actions

    func saveData() {
        context.goBack(Person(firstName: firstName, lastName: lastName))
    }

    func showInfo() {
        context.openRoute(.Info)
    }

    // MARK: Helpers

    private func validate() {
        delegate?.saveButtonEnabled(firstName.characters.count > 0)
    }

}
