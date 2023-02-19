//
//  StationDtoMapper.swift
//  Coocoo
//
//  Created by Administrator on 2/19/23.
//

import Foundation

// MARK: - Fetch Wallet User

struct ServerDtoMapper {}

protocol StationDtoMapper {
    func mapStation(stationDto dto: StationDto) -> Station
}

extension ServerDtoMapper: StationDtoMapper {
    func mapStation(stationDto dto: StationDto) -> Station {
        Station(id: dto.i, name: dto.n, country: dto.c, genreName: dto.g, streamUrl: dto.u, logo: dto.l)
    }
}
