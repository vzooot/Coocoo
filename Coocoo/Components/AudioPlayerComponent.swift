//
//  AudioPlayerComponent.swift
//  Coocoo
//
//  Created by Administrator on 2/19/23.
//

import AVKit
import SwiftUI

struct AudioPlayerComponent: View {
    @Binding var player: AVPlayer
    @Binding var station: Station
    let pause: () -> Void
    let play: () -> Void

    var body: some View {
        Button(action: {
            if station.isPlaying {
                pause()
            } else {
                play()
            }
        }) {
            Image(systemName: station.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
        }
    }
}

struct AudioPlayerComponent_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerComponent(player: .constant(AVPlayer()), station: .constant(Station())) {} play: {}
    }
}
