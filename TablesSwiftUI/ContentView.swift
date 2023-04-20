//
//  ContentView.swift
//  TablesSwiftUI
//
//  Created by Vasichko Anna on 20.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var products = Product.getProducts()
    @State private var sortOrder = [KeyPathComparator(\Product.name)]
    @State private var selected = Set<Product.ID>()
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    private var isCompact: Bool {
        horizontalSizeClass == .compact
    }
    
    var body: some View {
        NavigationStack {
            Table(products, selection: $selected, sortOrder: $sortOrder) {
                TableColumn("Name", value: \.name) { product in
                    VStack(alignment: .leading) {
                        Text(product.name)
                        
                        if isCompact {
                            Text(product.code.formatted())
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                 //   .width(140)
                TableColumn("Category", value: \.category)
                TableColumn("Code", value: \.code) { product in
                    Text(product.code.formatted())
                }
                TableColumn("Available", value: \.isAvailableToInt) { product in
                    Text(product.isAvailable ? "🟢" : "❌")
                }
            }
            .onChange(of: sortOrder) { newValue in
                products.sort(using: newValue)
            }
            .navigationTitle("Products")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
        }
    }
}
