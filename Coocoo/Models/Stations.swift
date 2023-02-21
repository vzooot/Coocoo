//
//  Stations.swift
//  Coocoo
//
//  Created by Administrator on 2/18/23.
//

import SwiftUI

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

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

struct DeveloperPreview {
    static let instance = DeveloperPreview()

    let station = Station(id: "18107", genreId: "8", name: "Radio Athens Deejay", country: "GR", genreName: "AC", streamUrl: "http://94.23.0.114:41972/;stream.mp3", logo: "radio-athens-deejay.jpg", isPlaying: false)
}
