//
//  FinalViewPresenter.swift
//  SpyGame
//
//  Created by Artem Vavilov on 22.02.2023.
//

import Foundation

protocol FinalViewPresenterProtocol: AnyObject {
    func popToRoot()
    func getSpyName() -> String
}

final class FinalViewPresenter {
    weak var viewController: FinalViewControllerProtocol?
    private let router: FinalViewRouterProtocol
    private let gameModel: GameModel
    
    init(
        viewController: FinalViewControllerProtocol,
        router: FinalViewRouterProtocol,
        gameModel: GameModel
    ) {
        self.viewController = viewController
        self.router = router
        self.gameModel = gameModel
    }
}

extension FinalViewPresenter: FinalViewPresenterProtocol {
    func getSpyName() -> String {
        var spies = gameModel.players.filter({ $0.playerType == .spy })
        spies.sort {(p1, p2) in
            return p1.playerNumber < p2.playerNumber
        }
        var array: [String] = []
        spies.forEach {
            array.append("Player \($0.playerNumber)")
        }
        let joined = array.joined(separator: " ,")
        return spies.count > 1 ? "Spies are: \(joined)" : "Spy is - \(joined)"
    }
    
    func popToRoot() {
        router.popOutToRootController()
    }
}
