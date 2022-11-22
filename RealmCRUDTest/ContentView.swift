//
//  ContentView.swift
//  RealmCRUDTest
//
//  Created by John Doe on 22/11/2022.
//

import SwiftUI
import RealmSwift

final class Item: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name = "item name"
    @Persisted var isFavorite = false
    @Persisted var itemDescription = "item details"
    @Persisted (originProperty: "items") var group: LinkingObjects<ItemGroup>

}

final class ItemGroup: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var items = RealmSwift.List<Item>()
}

struct ContentView: View {
    @ObservedResults(ItemGroup.self) var itemGroups
    
    var body: some View {
        if let itemGroup = itemGroups.first {
            ItemsView(itemGroup: itemGroup)
        } else {
            ProgressView().onAppear {
                $itemGroups.append(ItemGroup())
            }
        }
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
//        }
//        .padding()
    }
}

struct ItemsView: View {
    @ObservedRealmObject var itemGroup: ItemGroup
    var leadingBarButton: AnyView?
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(itemGroup.items) { item in
                        ItemRow(item: item)
                    }.onDelete(perform: $itemGroup.items.remove)
                        .onMove(perform: $itemGroup.items.move)
                    }
                .listStyle(GroupedListStyle())
                .navigationBarTitle("Items", displayMode: .large)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                            leading: self.leadingBarButton,
                            trailing: EditButton())
                HStack {
                    Spacer()
                    Button(action: {
                        $itemGroup.items.append(Item())
                    }) {Image(systemName: "plus")}
                }.padding()
            }
        }
    }
    
}

//struct ItemsView_Previews: PreviewProvider {
//    static var previews: some View {
//        let realm = ItemGroup.previewRealm
//        let itemGroup = realm.objects(ItemGroup.self)
//        ItemsView(itemGroup: itemGroup.first!)
//    }
//
//}

struct ItemRow: View {
    @ObservedRealmObject var item: Item
    var body: some View {
        NavigationLink(destination: ItemDetailsView(item: item)) {
            Text(item.name)
            if item.isFavorite {
                Image(systemName: "heart.fill")
            }
        }
    }
}

struct ItemDetailsView: View {
    @ObservedRealmObject var item: Item
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Enter a new name:")
            TextField("New name", text: $item.name)
                .navigationBarTitle(item.name)
                .navigationBarItems(trailing: Toggle(isOn: $item.isFavorite) {
                    Image(systemName: item.isFavorite ? "heart.fill" : " heart")
                })
        }.padding()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
