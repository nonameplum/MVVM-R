//
//  MainListViewController.swift
//  MVVM-C Example
//
//  Created by Łukasz Śliwiński on 06/09/16.
//  Copyright © 2016 Plum's organization. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    deinit { print("deinit \(self.dynamicType)") }

    // MARK: Constants

    struct Constants {
        static let cellIdentifier = "Cell"
    }

    // MARK: IBOutlets

    @IBOutlet weak var tableView: UITableView!

    // MARK: Properties

    var viewModel: UsersViewModel!

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
    }

    // MARK: Actions

    @IBAction func addBarButtonTapped(sender: UIBarButtonItem) {
        viewModel.navigateToAddPersonView()
    }

    @IBAction func closeBarButtonTapped(sender: UIBarButtonItem) {
        viewModel.close()
    }
}

extension UsersViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.persons.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.cellIdentifier, forIndexPath: indexPath)

        cell.detailTextLabel?.text = viewModel.persons[indexPath.row].firstName
        cell.textLabel?.text = viewModel.persons[indexPath.row].lastName

        return cell
    }

}

extension UsersViewController: UsersViewModelDelegate {

    func dataChanged() {
        tableView.reloadData()
    }

}
