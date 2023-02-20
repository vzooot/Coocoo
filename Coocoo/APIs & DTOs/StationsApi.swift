//
//  StationsApi.swift
//  Coocoo
//
//  Created by Administrator on 2/18/23.
//

import Combine
import Foundation
import SwiftUI

open class StationsApi: ObservableObject {
    open class func getStations() -> AnyPublisher<StationsDto, Error> {
        let headers = [
            "X-RapidAPI-Key": "b8435d1d0dmsh085a73df994d451p133d3ajsnb8747b0eb5a2",
            "X-RapidAPI-Host": "30-000-radio-stations-and-music-charts.p.rapidapi.com",
        ]

        guard let url = URL(string: "https://30-000-radio-stations-and-music-charts.p.rapidapi.com/rapidapi?country=GR&keyword=0&genre=ALL") else {
            return Fail(outputType: StationsDto.self, failure: NSError(domain: "100", code: 100)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: StationsDto.self, decoder: JSONDecoder())
            .map { result in
                result
            }
            .eraseToAnyPublisher()
    }
}
