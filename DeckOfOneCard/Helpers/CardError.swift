//
//  CardError.swift
//  DeckOfOneCard
//
//  Created by Colby Harris on 3/10/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation

enum CardError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach desired website."
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "Server responded with no data."
        case .unableToDecode:
            return "Server responded with bad data."

        }
    }


}
