//
//  CRUDVIew.swift
//  RealmCRUDTest
//
//  Created by John Doe on 22/11/2022.
//

import SwiftUI
import RealmSwift
import PhotosUI

struct CRUDVIew: View {
    @ObservedRealmObject var itemGroup: ItemGroup
    @ObservedResults(ItemGroup.self) var itemGroups
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                
                
                Text("itemGroup.name")
                //       Text(itemGroups.count)
                Text(itemGroup.name)
                TextField("Группа", text: $itemGroup.name)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
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
                    
                    itemGroup.picture = selectedImageData
                    $itemGroups.append(itemGroup)
                    
                    
                    dismiss()
                })
                {
                    Text("Добавить товарную группу")
                }
                .frame(width: 650, alignment: .center)
                .buttonStyle(.bordered)
            }
        }
    }
}

//struct CRUDVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        CRUDVIew()
//    }
//}
