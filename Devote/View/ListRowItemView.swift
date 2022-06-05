//
//  ListRowItemView.swift
//  Devote
//
//  Created by Tin Tran on 05/06/2022.
//

import SwiftUI

struct ListRowItemView: View {

    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item

    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? Color.pink : Color.primary)
                .padding(.vertical, 12)
                .animation(.default)
        }
            .onReceive(item.objectWillChange, perform: { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        })
    }
}

struct ListRowItemView_Previews: PreviewProvider {
    static var item: Item {
        let newItem = Item(context: PersistenceController.shared.container.viewContext)
        newItem.timestamp = Date()
        newItem.task = "Sample task No 1"
        newItem.completion = false
        newItem.id = UUID()
        return newItem
    }
    static var previews: some View {
        ListRowItemView(item: item)
            .previewDevice("iPhone 13 Pro")
    }
}
