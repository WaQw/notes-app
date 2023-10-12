//
//  ContentView.swift
//  Notes
//
//  Created by Anqi on 2023/10/12.
//

import SwiftUI

struct Home: View {
    
    @State var notes = [Note]() // update the UI everytime notes changes
    
    var body: some View {
        
        NavigationView {
            List(self.notes) { el in
                Text(el.note)
                    .padding()
            }
            .onAppear(perform: {
                fetchNotes()
            })
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
    
    func fetchNotes() {
        let url = URL(string: "http://localhost:3000/notes")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, res, err in
            guard let data = data else { return } // if there is data, then goto next line
            do {
                let notes = try JSONDecoder().decode([Note].self, from: data)
                self.notes = notes
                print("Hi \(notes)")
            } catch {
                print(error)
            }
        })
        
        task.resume()
    }
}

struct Note: Identifiable, Codable {
    var id: String { _id }
    var _id: String
    var note: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
