//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Colby Harris on 3/10/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import UIKit

class CardController {
    
    //URL Constants
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/")
    static let cardEndPoint = "new/draw/"
    
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
        
        // 1 - Prepare URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let cardURL = baseURL.appendingPathComponent(cardEndPoint)
        print(cardURL)
        // 2 - Contact server
        URLSession.shared.dataTask(with: cardURL) { (data, _, error) in
            // 3 - Handle errors from the server
            if let error = error {
                print("There was an error: \(error) \(error.localizedDescription)")
                return completion(.failure(.thrownError(error)))
            }
            // 4 - Check for json data
            guard let data = data else { return completion(.failure(.noData))}
            // 5 - Decode json into a Card
            do {
                let decoder = JSONDecoder()
                let card = try decoder.decode(TopLevelObject.self, from: data).cards[0]
                return completion(.success(card))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.noData))
            }
            
        }.resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result <UIImage, CardError>) -> Void) {

        // 1 - Prepare URL
        let cardURL = card.image
        print(cardURL)
        // 2 - Contact server
        URLSession.shared.dataTask(with: cardURL) { (data, _, error) in
            // 3 - Handle errors from the server
            if let error = error {
                print("There was an error: \(error) \( error.localizedDescription)")
                return completion(.failure(.thrownError(error)))
            }
            // 4 - Check for image data
            guard let data = data else { return completion(.failure(.noData))}
            // 5 - Initialize an image from the data
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            return completion(.success(image))
        }.resume()
    }}
