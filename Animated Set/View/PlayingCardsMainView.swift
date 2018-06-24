//
//  PlayingCardsMainView.swift
//  Set
//
//  Created by Peter Wu on 5/17/18.
//  Copyright © 2018 Zero. All rights reserved.
//

import UIKit

class PlayingCardsMainView: UIView {
    
    private struct AspectRatio {
        static let cardViewRectangle: CGFloat = 5.0 / 8.0
    }
    
    lazy var grid = Grid(layout: Grid.Layout.aspectRatio(AspectRatio.cardViewRectangle), frame: self.bounds)
//    private weak var timer: Timer?
    lazy var deckFrame = CGRect(x: self.frame.minX, y: self.frame.maxY, width: self.frame.width/20, height: self.frame.width/20)
    var numberOfCardViews: Int = 0 {
        didSet {
            // recalculate grid every time number of cards are set
            grid.cellCount = numberOfCardViews
//            layoutIfNeeded()
        }
    }
    
    var cardViews: [CardView] = []
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        print(#function)
        setNeedsLayout()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        grid.frame = self.bounds
        print(#function)
        updateCardsFrame()

    }
    
    /// Update each cardView's frame with the new CGRect from grid object
    func updateCardsFrame() {
        print(#function)
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.7, delay: 0, options: [.allowAnimatedContent], animations: {
            for (index, cardView) in self.cardViews.enumerated() {
                guard let rect = self.grid[index] else { return }
                let newRect = rect.insetBy(dx: rect.width / 10, dy: rect.height / 10)
                cardView.frame = newRect
            }
        })
    }
    
    func reset() {
        self.cardViews.forEach{ $0.removeFromSuperview() }
        self.cardViews.removeAll()
        numberOfCardViews = 0
    }
    

}

