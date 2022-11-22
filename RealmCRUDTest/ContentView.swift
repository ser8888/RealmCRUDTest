//
//  ContentView.swift
//  RealmCRUDTest
//
//  Created by John Doe on 22/11/2022.
//

import SwiftUI
import RealmSwift
import PhotosUI

//final class Item: Object, ObjectKeyIdentifiable {
//    @Persisted(primaryKey: true) var _id: ObjectId
//    @Persisted var name = "item name"
//    @Persisted var isFavorite = false
//    @Persisted var itemDescription = "item details"
//    @Persisted (originProperty: "items") var group: LinkingObjects<ItemGroup>
//
//}

final class ItemGroup: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
//    @Persisted var items = RealmSwift.List<Item>()
    @Persisted var name = ""
    @Persisted var picture: Data
}

struct ContentView: View {
//    @ObservedResults(ItemGroup.self) var itemGroups
    @ObservedRealmObject var itemGroup: ItemGroup
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    @State private var name = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        NavigationView {
            VStack {
                TextField("Enter the text", text: $name)
                    .textFieldStyle(.roundedBorder)
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Text("Select a photo")
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
//                                   Retrive selected asset in the form of Data
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            selectedImageData = data
                        }
                    }
                }
                if let selectedImageData,
                   let uiImage = UIImage(data: selectedImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                }
                
                Button ( action: {
                    
                    let itemGroup = ItemGroup()
                    itemGroup.name = itemGroup.name
                    itemGroup.picture = selectedImageData!
                    
//                    let group = Groups()
//                    group.name = name
//                    group.details = details
//                    group.picture = selectedImageData
//
//                    $groups.append(group)
         
                    dismiss()
                })
                {
                    Text("Добавить товарную группу")
                }
                .frame(width: 650, alignment: .center)
                .buttonStyle(.bordered)
                
                //               Image(uiImage: UIImage(data: itemGroup.picture as Data)!)
            }
        }
        
       
    }
}
    
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
