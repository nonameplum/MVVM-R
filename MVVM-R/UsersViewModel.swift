//
//  MainListViewModel.swift
//  MVVM-C Example
//
//  Created by Łukasz Śliwiński on 06/09/16.
//  Copyright © 2016 Plum's organization. All rights reserved.
//

import Foundation

protocol UsersViewModelDelegate: class {
    func dataChanged()
}

class UsersViewModel {

    // MARK: Properties

    weak var context: AppContext!

    var persons: [Person] = {
        return [Person(firstName: "Lukas", lastName: "Sliwinski"),
                Person(firstName: "John", lastName: "Smith")]
    }()

    weak var delegate: UsersViewModelDelegate?

    // MARK: Initialization

    init(context: AppContext) {
        self.context = context
    }

    // MARK: Actions

    func navigateToAddPersonView() {
        context.openRoute(.UserDetails)
    }

    func close() {
        context.isLoggedIn = false
        context.openRoute(.Users)
    }

    func addPerson(person: Person?) {
        if let person = person {
            persons.append(person)
            delegate?.dataChanged()
        }
    }

}
