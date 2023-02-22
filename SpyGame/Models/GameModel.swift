//
//  GameModel.swift
//  SpyGame
//
//  Created by Artem Vavilov on 18.02.2023.
//

import UIKit

enum PlayerType {
    case player
    case spy
}

struct GameModel {
    let location: String
    let players: [Player]
}

struct Player {
    let playerNumber: Int
    let playerType: PlayerType
}

struct PassStruct {
    let gameModel: GameModel
    let time: Int
    let mainViewDelegate: (() -> (Void))?
}

