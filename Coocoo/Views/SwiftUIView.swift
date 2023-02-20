//
//  SwiftUIView.swift
//  Coocoo
//
//  Created by Vasileios Zotikas on 2023-02-20.
//

import SwiftUI

struct PlayButton: View {
    let index: Int
    @Binding var selectedIndex: Int?

    var body: some View {
        Button(action: {
            if selectedIndex == index {
                selectedIndex = nil
            } else {
                selectedIndex = index
            }
        }) {
            Image(systemName: selectedIndex == index ? "pause.circle.fill" : "play.circle.fill")
        }
    }
}

// struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
// }
