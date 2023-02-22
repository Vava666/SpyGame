//
//  GameViewPresenter.swift
//  SpyGame
//
//  Created by Artem Vavilov on 21.02.2023.
//

import Foundation

protocol GameViewPresenterProtocol: AnyObject {
    func getData()
    func showFinalView()
}

final class GameViewPresenter {
    weak var viewController: GameViewControllerProtocol?
    private let router: GameViewRouterProtocol
    private let gameModel: GameModel
    
    init(
        viewController: GameViewControllerProtocol,
        router: GameViewRouter,
        gameModel: GameModel
    ) {
        self.viewController = viewController
        self.router = router
        self.gameModel = gameModel
    }
}

extension GameViewPresenter: GameViewPresenterProtocol {
    func showFinalView() {
        router.showFinalView(gameModel: gameModel)
    }
    
    func getData() {
        viewController?.loadViewModels(gameModel: gameModel)
    }
}
