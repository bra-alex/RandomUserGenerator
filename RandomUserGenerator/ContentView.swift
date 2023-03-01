//
//  ContentView.swift
//  RandomUserGenerator
//
//  Created by Don Bouncy on 01/03/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var ruc = RandomUserController()
    var body: some View {
        VStack {
            Text(ruc.user?.email ?? "")
        }
        .task {
            await ruc.loadData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
