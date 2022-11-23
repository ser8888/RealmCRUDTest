//
//  ContentView.swift
//  RealmCRUDTest
//
//  Created by John Doe on 22/11/2022.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedResults(ItemGroup.self) var itemGroups
    @State private var isPresented: Bool = false
    
    var body: some View {
        Text("content view ")
        NavigationView {
            VStack {
                if itemGroups.isEmpty {
                    Text("Nothing inside")
                } else { Text("записи есть")}
                List {
                    ForEach(itemGroups , id: \.id) { itemGroup in
                        NavigationLink {
                            ItemsView(itemGroup: itemGroup)
                            } label: {
                                Text(itemGroup.name)
                               // Text("Идем дальше")
                        }
                        
                    }
                    .onDelete(perform: $itemGroups.remove)
                }
               
            }
            .sheet(isPresented: $isPresented, content: {
                CRUDVIew(itemGroup: ItemGroup())
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // action
                        isPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }

                }
        }
        }
    }
}
//        ItemsView()
      
 //       ItemsView()
//        if itemGroups.isEmpty {
//            Text("No shopping lists!")
//        }
//        if let itemGroup = itemGroups.first {
//            ItemsView()
//            
//        }
        
//        if let itemGroup = itemGroups.first {
//            ItemsView(itemGroup: itemGroup)
//        } else {
//            ProgressView()
////                .onAppear(perform: ItemsView(itemGroup: itemGroup))
//
//        }
  

    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
