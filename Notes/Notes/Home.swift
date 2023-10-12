//
//  ContentView.swift
//  Notes
//
//  Created by Anqi on 2023/10/12.
//

import SwiftUI

struct Home: View {
    var body: some View {
        
        NavigationView {
            List(0..<9) { i in
                Text("We are at \(i)")
                    .padding()
            }
            .navigationTitle("Notes")
            .navigationBarItems(trailing: Button(action:
                                                    {print("Add a note")},
                                                 label:
                                                    {Text("Add")}
                                                )
            )
        }
        
        
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
