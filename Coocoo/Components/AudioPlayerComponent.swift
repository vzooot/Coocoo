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
    let pauseAll: () -> Void
    let play: () -> Void
    @State var station: Station
    
    var body: some View {
        Button(action: {
            if station.isPlaying {
                pauseAll()
                station.isPlaying = false
            } else {
                play()
                station.isPlaying = true
            }
        }) {
            Image(systemName: station.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
        }
    }
}


// struct AudioPlayerComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        AudioPlayerComponent(url: "http://sokfm.lalala.gr:8000/;stream/1")
//    }
// }
