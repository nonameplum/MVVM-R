//
//  InfoViewModel.swift
//  MVVM-R
//
//  Created by Łukasz Śliwiński on 17/09/16.
//  Copyright © 2016 Plum's organization. All rights reserved.
//

import Foundation

class InfoViewModel {

    // MARK: Properties

    weak var context: AppContext!

    // MARK: Initialization

    init(context: AppContext) {
        self.context = context
    }

    // MARK: Actions

    func dismissAction() {
        context.goBack(nil)
    }

    func homeAction() {
        context.goBack(.Users, data: nil)
    }

}
