//
//  FrontCard.swift
//  SpyGame
//
//  Created by Artem Vavilov on 21.02.2023.
//

import UIKit

final class FrontCard: UIView {
    
    let playerLabel = UILabel()
    let textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setup() {
        addSubviews()
        setupConstraints()
        setupViews()
    }
    
    private func addSubviews() {
        [playerLabel, textLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            playerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -32),
            
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 32),
        ])
    }
    
    private func setupViews() {
        backgroundColor = .white
        
        playerLabel.textColor = .black
        playerLabel.textAlignment = .center
        playerLabel.font = UIFont.systemFont(ofSize: 18)
        
        textLabel.textColor = .black
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 18)
        textLabel.text = "Flip card"
    }
    
    func configure(with player: Player) {
        playerLabel.text = "Player - \(player.playerNumber)"
    }
}
