//
//  MainViewRouter.swift
//  SpyGame
//
//  Created by Artem Vavilov on 18.02.2023.
//

import UIKit

protocol MainViewRouterProtocol: AnyObject {
    func presentGameView(gameModel: GameModel)
}

final class MainViewRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension MainViewRouter: MainViewRouterProtocol {
    func presentGameView(gameModel: GameModel) {
        let view = GameViewBuilder.build(with: gameModel)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
