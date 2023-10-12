//
//  ContentView.swift
//  Notes
//
//  Created by Anqi on 2023/10/12.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
