//
//  ContentView.swift
//  Notes
//
//  Created by Anqi on 2023/10/12.
//

import SwiftUI

struct Home: View {
    
    @State var notes = [Note]() // update the UI everytime notes changes
    
    @State var showAdd = false
    
    @State var showAlert = false
    @State var deleteItem: Note?
    var alert: Alert {
        Alert(title: Text("Delete"), message: Text("Are you sure you want to delete this note"), primaryButton: .destructive(Text("Delete"), action: deleteNote), secondaryButton: .cancel())
    }
    
    @State var isEditMode: EditMode = .inactive
    @State var updateNote = ""
    @State var updateNoteId = ""
    
    var body: some View {
        
        NavigationView {
            List(self.notes) { el in
                if(isEditMode == .inactive) {
                    Text(el.note)
                        .padding()
                        .onLongPressGesture(perform: {
                            self.showAlert.toggle()
                            deleteItem = el
                        })
                } else {
                    HStack {
                        Image(systemName: "pencil.circle.fill")
                            .foregroundColor(.yellow)
                        Text(el.note)
                            .padding()
                    }
                    .onTapGesture {
                        self.updateNote = el.note
                        self.updateNoteId = el.id
                        self.showAdd.toggle()
                    }
                }
               
            }
            .alert(isPresented: $showAlert, content: {
                alert
            })
            .sheet(isPresented: $showAdd, onDismiss: fetchNotes, content: {
                if(self.isEditMode == .inactive) {
                    AddNoteView()
                } else {
                    UpdateNoteView(note: $updateNote, noteId: $updateNoteId)
                }
            })
            .onAppear(perform: {
                fetchNotes()
            })
            .navigationTitle("Notes")
            .navigationBarItems(
                leading:
                    Button(
                        action:{
                            if(isEditMode == .inactive) {
                                isEditMode = .active
                            } else {
                                isEditMode = .inactive
                            }},
                        label:{
                           if(isEditMode == .inactive) {
                               Text("Edit")
                           } else {
                               Text("Done")
                           }
                           }),
                trailing:
                    Button(action:{self.showAdd.toggle()},label:{Text("Add")})
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
            } catch {
                print(error)
            }
        })
        
        task.resume()
        
        if(isEditMode == .active) {
            isEditMode = .inactive
        }
    }
    
    func deleteNote() {
        guard let id = deleteItem?._id else { return }
        let url = URL(string: "http://localhost:3000/notes/\(id)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, res, err in
            guard err == nil else { return }
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                }
            } catch let error {
                print(error)
            }
        })
        task.resume()
        fetchNotes()
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
