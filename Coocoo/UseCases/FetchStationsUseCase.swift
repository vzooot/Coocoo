//
//  FetchStationsUseCase.swift
//  Coocoo
//
//  Created by Administrator on 2/19/23.
//

import Combine

protocol FetchStationsUseCase {
    func fetchStations() -> AnyPublisher<[Station], Error>
}

struct FetchStationsInteractor: FetchStationsUseCase {
    private let fetchStationsRepository: FetchStationsRepository

    init(fetchStationsRepository: FetchStationsRepository = FetchStationsDataStore()) {
        self.fetchStationsRepository = fetchStationsRepository
    }

    func fetchStations() -> AnyPublisher<[Station], Error> {
        fetchStationsRepository.fetchStations()
    }
}
