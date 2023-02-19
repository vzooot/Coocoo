//
//  StationsDto.swift
//  Coocoo
//
//  Created by Administrator on 2/19/23.
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct StationsDto: Codable, Hashable, Equatable {
    let results: [StationDto]
}

public struct StationDto: Codable, Hashable, Equatable {
    let i, d, n, c, g, u, l: String

    enum CodingKeys: String, CodingKey {
        case i, d, n, c, g, u, l
    }
}
