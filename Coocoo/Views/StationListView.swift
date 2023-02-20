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
         fetchStationsUseCase: FetchStationsUseCase = FetchStationsInteractor()) {
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
        EmptyView().onAppear(perform: fetchStations)
    }

    @ViewBuilder func stationsView(stations: [Station]) -> some View {
        List {
            ForEach(stations.indices, id: \.self) { index in
                HStack {
                    Text(viewAdapter.stations.stationsList[index].name ?? "")
                    Spacer()
                    AudioPlayerComponent(index: index, selectedIndex: $viewAdapter.selectedIndex) {
                        pauseAll()
                    } play: {
                        play(station: viewAdapter.stations.stationsList[index],
                             url: viewAdapter.stations.stationsList[index].streamUrl ?? "")
                    }
                }
            }
        }
    }

    // MARK: - Side Effects

    func pauseAll() {
        viewAdapter.player.pause()
    }

    func play(station: Station, url: String) {
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
        var player: AVPlayer = .init()
        var isLoading: Bool = true
        var cancellables = Set<AnyCancellable>()
        var error: Error?
        var stations: Stations = .init(stationsList: [])
//        var station: Station = .init()
        var selectedIndex: Int? = nil
    }
}

struct StationListView_Previews: PreviewProvider {
    static var previews: some View {
        StationListView()
    }
}
