//
//  MainViewPresenter.swift
//  SpyGame
//
//  Created by Artem Vavilov on 18.02.2023.
//

import Foundation

protocol MainViewPresenterProtocol {
    func startButtonPressed(players: Int, spies: Int)
}

final class MainViewPresenter {
    weak var viewController: MainViewControllerProtocol?
    private let router: MainViewRouterProtocol
    
    init(
        viewController: MainViewControllerProtocol,
        router: MainViewRouterProtocol
    ) {
        self.viewController = viewController
        self.router = router
    }
    
    private func createPlayersArray(numberOfPlayers: Int, numberOfSpies: Int) -> [Player] {
        var players: [Player] = []
        for _ in 0..<numberOfPlayers - numberOfSpies {
            players.append(Player(playerNumber: 0, playerType: .player))
        }
        
        for _ in 0..<numberOfSpies {
            players.append(Player(playerNumber: 0, playerType: .spy))
        }
        
        for index in 0..<numberOfPlayers {
            let i = Int.random(in: 0..<numberOfPlayers)
            let currentPlayer = players[index]
            players[index] = players[i]
            players[i] = currentPlayer
        }
        
        for index in 0..<numberOfPlayers {
            let player = Player(playerNumber: index + 1, playerType: players[index].playerType)
            players[index] = player
        }
        
        return players
    }
}

extension MainViewPresenter: MainViewPresenterProtocol {
    func startButtonPressed(players: Int, spies: Int) {
        let location = Dictionary.getLocation()
        let playersArray = createPlayersArray(numberOfPlayers: players, numberOfSpies: spies)
        let gameModel = GameModel(location: location, players: playersArray)
        router.presentGameView(gameModel: gameModel)
    }
}
