//
//  AudioPlayerComponent.swift
//  Coocoo
//
//  Created by Administrator on 2/19/23.
//

import AVKit
import SwiftUI

struct AudioPlayerComponent: View {
    let index: Int
    @Binding var selectedIndex: Int?
    let pause: () -> Void
    let play: () -> Void

    var body: some View {
        Button(action: {
            if selectedIndex == index {
                selectedIndex = nil
                pause()
            } else {
                selectedIndex = index
                play()
            }
        }) {
            Image(systemName: selectedIndex == index ? "pause.circle.fill" : "play.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
        }
    }
}

struct AudioPlayerComponent_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerComponent(index: 1, selectedIndex: .constant(nil)) {} play: {}
    }
}
