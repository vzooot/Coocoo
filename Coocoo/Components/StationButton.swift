//
//  StationButton.swift
//  Coocoo
//
//  Created by Administrator on 2/20/23.
//

import SwiftUI

struct StationButton: View {
    let station: Station
    @Binding var selectedStation: Station?
    let pause: () -> Void
    let play: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(station.name ?? "")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
            Spacer()

            Button(action: {
                if selectedStation == station {
                    selectedStation = nil
                    pause()
                } else {
                    selectedStation = station
                    play()
                }

            }) {
                Image(systemName: selectedStation == station ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color("fg_01"))
                    .frame(width: 50, height: 50)
            }
        }
        .padding(20)
        .background(Color("bg_02"))
        .cornerRadius(50)
    }
}

struct StationButton_Previews: PreviewProvider {
    static var previews: some View {
        StationButton(station: dev.station, selectedStation: .constant(dev.station)) {} play: {}
    }
}
