//
//  StationsAPI.swift
//  Coocoo
//
//  Created by Administrator on 2/18/23.
//

import Combine
import Foundation
import SwiftUI

class StationsAPI: ObservableObject {
    @Published var stationsList: Stations = .init(results: [])

    func getStations() -> AnyPublisher<Stations, Error> {
        let headers = [
            "X-RapidAPI-Key": "b8435d1d0dmsh085a73df994d451p133d3ajsnb8747b0eb5a2",
            "X-RapidAPI-Host": "30-000-radio-stations-and-music-charts.p.rapidapi.com",
        ]

        guard let url = URL(string: "https://30-000-radio-stations-and-music-charts.p.rapidapi.com/rapidapi?country=ALL&keyword=0&genre=ALL") else {
            return Fail(outputType: Stations.self, failure: NSError(domain: "100", code: 100)).eraseToAnyPublisher()
        }

        guard let localUrl = URL(string: "http://localhost:3000/api") else {
            return Fail(outputType: Stations.self, failure: NSError(domain: "100", code: 100)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: Stations.self, decoder: JSONDecoder())
            .map { [weak self] result in
                self?.stationsList = result
                return result
            }
            .eraseToAnyPublisher()
    }
}
