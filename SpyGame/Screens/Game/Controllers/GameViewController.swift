//
//  GameViewController.swift
//  SpyGame
//
//  Created by Artem Vavilov on 21.02.2023.
//

import UIKit

protocol GameViewControllerProtocol: AnyObject {
    func loadViewModels(gameModel: GameModel)
}

protocol GameViewDatasourse {
    func numberOfCards() -> Int
    func card(index: Int) -> CardView
    func resultView()
    func getLocation() -> String
}

class GameViewController: UIViewController {
    var presenter: GameViewPresenterProtocol?
    
    private var gameModel: GameModel! {
        didSet {
            stackContainer.dataSource = self
        }
    }
    
    private let stackContainer = StackContainerView()
    
    override func loadView() {
        super.loadView()
        setup()
        addSubviews()
        setupConstraints()
        setupViews()
//        configureNavigationBarButtonItem()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Game"
        presenter?.getData()
    }
    
    func setup() {
        addSubviews()
        setupConstraints()
        setupViews()
    }
    
    func addSubviews() {
        view.addSubview(stackContainer)
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -64),
            stackContainer.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -256),
        ])
    }
    
    func setupViews() {
        view.backgroundColor = .white
    }
}

extension GameViewController: GameViewDatasourse {
    func getLocation() -> String {
        return gameModel.location
    }
    
    func numberOfCards() -> Int {
        gameModel.players.count
    }
    
    func card(index: Int) -> CardView {
        let card = CardView()
        card.dataSource = gameModel.players[index]
        return card
    }
    
    func resultView() {
        presenter?.showFinalView()
    }
}

extension GameViewController: GameViewControllerProtocol {
    func loadViewModels(gameModel: GameModel) {
        self.gameModel = gameModel
    }
}
