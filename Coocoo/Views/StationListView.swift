//
//  StationListView.swift
//  Coocoo
//
//  Created by Administrator on 2/19/23.
//

import AVKit
import Combine
import SwiftUI

struct StationListView: View {
    @State var viewAdapter: ViewAdapter

    let fetchStationsUseCase: FetchStationsUseCase

    init(viewAdapter: ViewAdapter = ViewAdapter(),
         fetchStationsUseCase: FetchStationsUseCase = FetchStationsInteractor())
    {
        _viewAdapter = .init(initialValue: viewAdapter)
        self.fetchStationsUseCase = fetchStationsUseCase
    }

    var body: some View {
        VStack {
            if viewAdapter.isLoading {
                ProgressView()
            } else {
                stationsView(stations: viewAdapter.stations.stationsList)
            }
            if let error = viewAdapter.error {
                Text(error.localizedDescription)
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            fetchStations()
        }
    }

    // MARK: - Views

    @ViewBuilder var notRequestedView: some View {
        Text("").onAppear(perform: fetchStations)
    }

    @ViewBuilder func stationsView(stations: [Station]) -> some View {
        List {
            ForEach(stations, id: \.self) { station in
                HStack {
                    Text(station.name ?? "")
                    Spacer()
                    AudioPlayerComponent(player: $viewAdapter.player,
                                         pauseAll: {
                                             pauseAll(station: station)
                                         },
                                         play: {
                                             viewAdapter.stations.stationsList.forEach { _ in
                                                 viewAdapter.station.isPlaying = false
                                             }
                                             play(station: station,
                                                  url: station.streamUrl ?? "")
                                         },
                                         station: station)
                }
            }
        }
    }

    // MARK: - Side Effects

    func pauseAll(station _: Station) {
        viewAdapter.player.pause()
    }

    func play(station _: Station, url: String) {
        guard let url = URL(string: url) else { return }
        viewAdapter.player = AVPlayer(url: url)
        viewAdapter.player.play()
    }

    func fetchStations() {
        viewAdapter.isLoading = true
        fetchStationsUseCase.fetchStations()
            .sink { completion in
                switch completion {
                case .finished:
                    viewAdapter.isLoading = false
                case let .failure(error):
                    viewAdapter.error = error
                }
            } receiveValue: { stations in

                viewAdapter.stations = stations
            }
            .store(in: &viewAdapter.cancellables)
    }
}

extension StationListView {
    struct ViewAdapter {
        var isPlaying: Bool = false
        var player: AVPlayer = .init()
        var isLoading: Bool = true
        var cancellables = Set<AnyCancellable>()
        var error: Error?
        var stations: Stations = .init(stationsList: [])
        var station: Station = .init()
    }
}

struct StationListView_Previews: PreviewProvider {
    static var previews: some View {
        StationListView()
    }
}


