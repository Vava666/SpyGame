//
//  GameViewRouter.swift
//  SpyGame
//
//  Created by Artem Vavilov on 21.02.2023.
//

import UIKit

protocol GameViewRouterProtocol: AnyObject {
    func showFinalView(gameModel: GameModel)
}

final class GameViewRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension GameViewRouter: GameViewRouterProtocol {
    func showFinalView(gameModel: GameModel) {
        let view = FinalViewBuilder.build(gameModel: gameModel)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
