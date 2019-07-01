//
//  RoomType.swift
//  HotelApp
//
//  Created by MacOS on 3/18/19.
//  Copyright © 2019 MacOS. All rights reserved.
//

import Foundation

struct RoomType: Equatable {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    static var all: [RoomType]{
        return [
            RoomType(id: 0, name: "TwoQueens", shortName: "2Q", price: 179),
            RoomType(id: 1, name: "One King", shortName: "K", price: 209),
            RoomType(id: 2, name: "Penthouse", shortName: "PHS", price: 309)
        ]
    }

    
}
func ==(lhs: RoomType, rhs: RoomType) -> Bool {
    return lhs.id == rhs.id
}
