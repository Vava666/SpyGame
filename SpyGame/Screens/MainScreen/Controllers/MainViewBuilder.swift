//
//  MainViewBuilder.swift
//  SpyGame
//
//  Created by Artem Vavilov on 18.02.2023.
//

import UIKit

final class MainViewBuilder {
    static func build() -> UIViewController {
        let viewController = MainViewController()
        let router = MainViewRouter(viewController: viewController)
        let presenter = MainViewPresenter(viewController: viewController, router: router)
        viewController.presenter = presenter
        return viewController
    }
}
