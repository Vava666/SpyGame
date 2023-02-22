//
//  GameViewBuilder.swift
//  SpyGame
//
//  Created by Artem Vavilov on 21.02.2023.
//

import UIKit

class GameViewBuilder {
    static func build(with gameModel: GameModel) -> UIViewController {
        let viewController = GameViewController()
        let router = GameViewRouter(viewController: viewController)
        let presenter = GameViewPresenter(viewController: viewController, router: router, gameModel: gameModel)
        viewController.presenter = presenter
        return viewController
    }
}
