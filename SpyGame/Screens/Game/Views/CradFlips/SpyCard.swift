//
//  FrontCard.swift
//  SpyGame
//
//  Created by Artem Vavilov on 21.02.2023.
//

import UIKit

final class SpyCard: UIView {
    
    let playerLabel = UILabel()
    let textLabel = UILabel()
    let image = UIImageView()
    
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
        [image, playerLabel, textLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            image.heightAnchor.constraint(equalToConstant: 300),
            image.widthAnchor.constraint(equalToConstant: 200),
            
            playerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -32),
            
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func setupViews() {
        backgroundColor = .red
        
        playerLabel.textColor = .black
        playerLabel.textAlignment = .center
        playerLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        textLabel.textColor = .black
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 12)
        textLabel.text = "Spy"
        
//        image.backgroundColor = .darkGray
        image.layer.cornerRadius = 24
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
    }
    
    func configure(with player: Player) {
        playerLabel.text = "Player - \(player.playerNumber)"
    }
}
