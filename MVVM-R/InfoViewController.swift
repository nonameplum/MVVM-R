//
//  InfoViewController.swift
//  MVVM-R
//
//  Created by Łukasz Śliwiński on 17/09/16.
//  Copyright © 2016 Plum's organization. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    deinit { print("deinit \(self.dynamicType)") }

    // MARK: Properties

    var viewModel: InfoViewModel!

    @IBAction func dismissButtonTapped(sender: UIButton) {
        viewModel.dismissAction()
    }

    @IBAction func homeButtonTapped(sender: UIButton) {
        viewModel.homeAction()
    }

}
