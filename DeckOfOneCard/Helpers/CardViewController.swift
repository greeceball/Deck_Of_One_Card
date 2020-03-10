//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Colby Harris on 3/10/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func fetchImageAndUpdateViews(for card: Card) {
        
        CardController.fetchImage(for: card) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.cardImageView.image = image
                    self?.cardLabel.text = card.value + " of " + card.suit
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    @IBAction func drawButtonTapped(_ sender: Any) {
        CardController.fetchCard { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let card):
                    self?.fetchImageAndUpdateViews(for: card)
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
