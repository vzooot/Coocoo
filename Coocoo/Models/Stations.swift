//
//  Stations.swift
//  Coocoo
//
//  Created by Administrator on 2/18/23.
//

import Foundation

struct Stations: Codable, Hashable {
    var stationsList: [Station]
}

struct Station: Codable, Hashable {
    var id: String?
    var genreId: String?
    var name: String?
    var country: String?
    var genreName: String?
    var streamUrl: String?
    var logo: String?
    var isPlaying: Bool = false

    enum CodingKeys: String, CodingKey {
        case id = "i"
        case genreId = "d"
        case name = "n"
        case country = "c"
        case genreName = "g"
        case streamUrl = "u"
        case logo = "l"
    }
}
