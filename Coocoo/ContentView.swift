//
//  ContentView.swift
//  Coocoo
//
//  Created by Administrator on 2/18/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedIndex: Int?

    var body: some View {
//        NotificationView()
        StationListView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
