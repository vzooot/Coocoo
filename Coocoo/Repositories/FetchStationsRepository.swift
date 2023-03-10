//
//  FetchStationsRepository.swift
//  Coocoo
//
//  Created by Administrator on 2/19/23.
//

import Combine
import Foundation

protocol FetchStationsRepository {
    func fetchStations() -> AnyPublisher<[Station], Error>
}

struct FetchStationsDataStore: FetchStationsRepository {
    let stationsAPI: StationsApiAdapter.Type
    let stationDtoMapper: StationDtoMapper

    init(stationsAPI: StationsApiAdapter.Type = DefaultStationsApi.self,
         stationDtoMapper: StationDtoMapper = ServerDtoMapper())
    {
        self.stationsAPI = stationsAPI
        self.stationDtoMapper = stationDtoMapper
    }

    func fetchStations() -> AnyPublisher<[Station], Error> {
        stationsAPI.getStations()
            .tryMap { stationsDto in
                stationsDto.results.map { stationDto in

                    stationDtoMapper.mapStation(stationDto: stationDto)
                }
            }
            .eraseToAnyPublisher()
    }
}
