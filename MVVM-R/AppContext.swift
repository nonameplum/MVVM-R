//
//  AppRouting.swift
//  MVVM-R
//
//  Created by Łukasz Śliwiński on 13/09/16.
//  Copyright © 2016 Plum's organization. All rights reserved.
//

import Foundation
import Routing

class AppContext {

    static let sharedInstance = AppContext()

    private let baseUrl = "mvvmr://"
    private let router = Routing()
    private let userDefaults = NSUserDefaults.standardUserDefaults()

    var isLoggedIn: Bool {
        get { return userDefaults.boolForKey("isLoggedIn") }
        set { userDefaults.setBool(newValue, forKey: "isLoggedIn") }
    }

    init() {
        configureRouting()
    }

    func openRoute(appRoute: AppRoute, data: Any? = nil) -> Bool {
        return router["Views"].open(baseUrl + appRoute.url, data: data)
    }

    func goBack(data: Any?) {
        router["Views"].goBack(data)
    }

    func goBack(appRoute: AppRoute, data: Any? = nil) {
        return router["Views"].goBack(baseUrl + appRoute.url, data: data)
    }

    private func configureRouting() {
        router.map(
            baseUrl + AppRoute.Login(callback: nil).url,
            source: .Storyboard(storyboard: "Authentication", identifier: "AuthenticationViewController", bundle: nil),
            style: .ReplaceRootController,
            setup: { [unowned self] (vc, parameters, data) in
                guard let vc = vc as? AuthenticationViewController else { return }

                vc.viewModel = AuthenticationViewModel(context: self)

                if let callback = parameters["callback"] {
                    vc.viewModel.routeCallback = callback
                }
            })

        router.map(
            baseUrl + AppRoute.Users.url,
            source: .Storyboard(storyboard: "Users", identifier: "UsersViewController", bundle: nil),
            style: .InNavigationController(.ReplaceRootController),
            backwardSetup: { (vc, route, parameters, data) in
                guard let vc = vc as? UsersViewController else { return }

                if let data = data as? Person {
                    vc.viewModel.addPerson(data)
                }
            },
            setup: { (vc, _, _) in
                guard let vc = vc as? UsersViewController else { return }

                vc.viewModel = UsersViewModel(context: self)
            })

        router.map(
            baseUrl + AppRoute.UserDetails.url,
            source: .Storyboard(storyboard: "UserDetails", identifier: "UserDetailsViewController", bundle: nil),
            style: .Push(animated: true),
            backwardHandler: { (prevRoute, orgStyle, vc, completed) in
                vc.navigationController?.popViewControllerAnimated(true, completion: completed)
            },
            setup: { (vc, _, _) in
                guard let vc = vc as? UserDetailsViewController else { return }

                vc.viewModel = UserDetailsViewModel(context: self)
            })

        router.map(
            baseUrl + AppRoute.Info.url,
            source: .Storyboard(storyboard: "Info", identifier: "InfoViewController", bundle: nil),
            style: .Present(animated: true),
            backwardHandler: { (prevRoute, orgStyle, vc, completed) in
                vc.dismissViewControllerAnimated(true, completion: completed)
            },
            setup: { (vc, _, _) in
                guard let vc = vc as? InfoViewController else { return }

                vc.viewModel = InfoViewModel(context: self)
        })

        router.proxy(baseUrl + "auth/*", tags: ["Views"]) { [unowned self] (route, parameters, data, next) in
            if self.isLoggedIn {
                next(nil, nil, nil)
            } else {
                next(self.baseUrl + "login?callback=\(route)", parameters, data)
            }
        }

        router.proxy("/*", tags: ["Views"]) { route, parameters, data, next in
            print("opened: route (\(route)) with parameters (\(parameters)) & data (\(data))")
            next(nil, nil, nil)
        }
    }
}

enum AppRoute {
    case Login(callback: String?)
    case Users
    case UserDetails
    case Info

    var url: String {
        switch self {
        case .Login(let callback):
            if let callback = callback {
                return "login?callback=\(callback)"
            }

            return "login"

        case .Users:
            return "auth/users"

        case .UserDetails:
            return "auth/user_details"

        case .Info:
            return "auth/info"
        }
    }
}
