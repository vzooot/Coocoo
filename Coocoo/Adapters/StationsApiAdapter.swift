//
//  StationsApiAdapter.swift
//  Coocoo
//
//  Created by Administrator on 2/19/23.
//

import Combine
import Foundation

protocol StationsApiAdapter {
    static func getStations() -> AnyPublisher<StationsDto, Error>
}

extension StationsApi: StationsApiAdapter {}

typealias DefaultStationsApi = StationsApi
