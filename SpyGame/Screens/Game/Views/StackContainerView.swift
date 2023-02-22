//
//  StackContainerView.swift
//  SpyGame
//
//  Created by Artem Vavilov on 21.02.2023.
//

import UIKit

protocol StackContainerViewDelegate {
    func didSwipeCard(on view: CardView)
    func getLocation() -> String
}

final class StackContainerView: UIView {
    
    //MARK: - Properties
    var cardViews: [CardView] = []
    
    let horizontalInset: CGFloat = 5.0
    let verticalInset: CGFloat = 5.0
    
    var dataSource: GameViewDatasourse! {
        didSet {
            loadData()
        }
    }
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func loadData() {
        guard let datasource = dataSource else { return }
        setNeedsLayout()
        layoutIfNeeded()
        
        for i in 0..<datasource.numberOfCards() {
            addCardView(cardView: datasource.card(index: i), atIndex: i )
        }
    }
    
    //MARK: - Configurations
    private func addCardView(cardView: CardView, atIndex index: Int) {
        cardView.delegate = self
        addCardFrame(index: index, cardView: cardView)
        cardViews.append(cardView)
        insertSubview(cardView, at: 0)
    }
    
    private func addCardFrame(index: Int, cardView: CardView) {
        var cardViewFrame = bounds
        let horizontalInset = (CGFloat(index) * self.horizontalInset)
        let verticalInset = CGFloat(index) * self.verticalInset
        
        cardViewFrame.size.width -= 2 * horizontalInset
        cardViewFrame.origin.x += horizontalInset
        cardViewFrame.origin.y += verticalInset
        
        cardView.frame = cardViewFrame
    }
}

//MARK: - Datasource delegate
extension StackContainerView: StackContainerViewDelegate {
    func getLocation() -> String {
        dataSource.getLocation()
    }
    
    func didSwipeCard(on view: CardView) {
        guard let index = cardViews.firstIndex(of: view) else { return }
        view.removeFromSuperview()
        if index == cardViews.count - 1 {
            cardViews = []
            dataSource.resultView()
        } else {
            var nextIndex = 0
            for i in index + 1..<cardViews.count{
                let card = cardViews[i]
                addCardFrame(index: nextIndex, cardView: card)
                nextIndex += 1
            }
        }
    }
}
