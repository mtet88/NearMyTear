//
//  APIData.swift
//  NearMyTier
//
//  Created by Mauricio Torres Mejia on 22.05.21.
//

import Foundation

struct APIDataStats: Decodable {
    var open: Int?
    var assigned: Int?
    var resolved: Int?
}

struct APIData: Decodable {

    var stats: APIDataStats
    var current: [APIVehicle]
}

struct APIResponse: Decodable {
    var data: APIData
}
