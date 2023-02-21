////
////  AudioPlayerComponent.swift
////  Coocoo
////
////  Created by Administrator on 2/19/23.
////
//
//import AVKit
//import SwiftUI
//
//struct AudioPlayerComponent: View {
//    let station: Station
//    @Binding var selectedStation: Station?
//    let pause: () -> Void
//    let play: () -> Void
//
//    var body: some View {
//        Button(action: {
//            if selectedStation == station {
//                selectedStation = nil
//                pause()
//            } else {
//                selectedStation = station
//                play()
//            }
//        }) {
//            Image(systemName: selectedStation == station ? "pause.circle.fill" : "play.circle.fill")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 40, height: 40)
//        }
//    }
//}
//
//struct AudioPlayerComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        AudioPlayerComponent(station: dev.station, selectedStation: .constant(nil)) {} play: {}
//    }
//}
