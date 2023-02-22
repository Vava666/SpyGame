//
//  FinalViewBuilder.swift
//  SpyGame
//
//  Created by Artem Vavilov on 22.02.2023.
//

import UIKit

final class FinalViewBuilder {
    static func build(gameModel: GameModel) -> UIViewController {
        let viewController = FinalViewController()
        let router = FinalViewRouter(viewController: viewController)
        let presenter = FinalViewPresenter(viewController: viewController, router: router, gameModel: gameModel)
        viewController.presenter = presenter
        return viewController
    }
}
