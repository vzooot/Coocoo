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
                stationsView(stations: viewAdapter.stations)
                    .background(Color("bg_01"))
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
        ScrollView {
            ForEach(viewAdapter.stations, id: \.self) { station in
                StationButton(station: station, selectedStation: $viewAdapter.selectedStation) {
                    pauseAll()
                } play: {
                    play(url: station.streamUrl ?? "")
                }
                .padding([.horizontal, .bottom], 10)
            }
        }
    }

    // MARK: - Side Effects

    func pauseAll() {
        viewAdapter.player.pause()
    }

    func play(url: String) {
        guard let url = URL(string: url) else { return }
        let audioSession = AVAudioSession.sharedInstance()

        do {
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            viewAdapter.player = AVPlayer(url: url)
            viewAdapter.player.play()
        } catch {
            print("Error starting playback: \(error.localizedDescription)")
        }
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
        var audioPlayer: AVAudioPlayer!
        var player: AVPlayer = .init()
        var isLoading: Bool = true
        var cancellables = Set<AnyCancellable>()
        var error: Error?
        var stations: [Station] = []
        var selectedStation: Station? = nil
    }
}

struct StationListView_Previews: PreviewProvider {
    static var previews: some View {
        StationListView()
    }
}
