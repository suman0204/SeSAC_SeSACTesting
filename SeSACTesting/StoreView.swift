//
//  StoreView.swift
//  SeSACTesting
//
//  Created by 홍수만 on 2023/12/18.
//

import SwiftUI
import StoreKit

struct StoreView: View {
    
    @StateObject var shop = SeSACShop()
    
    var body: some View {
        VStack {
            HStack {
                Text("다이아몬드 100")
                Spacer()
                Button("$999.99") {
                    print("구매 버튼 클릭")
                }
            }
            .padding()
            
            ForEach(shop.allProuducts, id: \.id) { item in
                ProductView(item)
                    .productViewStyle(.compact)
//                Text("\(item.displayName)")
            }
//            StoreView(shop: <#T##SeSACShop#>)
//            SubscriptionStoreView(subscriptions: <#T##Collection#>)
        }
        .task {
            await shop.fetchAllProducts()
        }
    }
}

#Preview {
    StoreView()
}
