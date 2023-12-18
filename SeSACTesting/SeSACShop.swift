//
//  SeSACShop.swift
//  SeSACTesting
//
//  Created by 홍수만 on 2023/12/18.
//

import Foundation
import StoreKit

class SeSACShop: ObservableObject {
    
    @Published var allProuducts: [Product] = [] // 인앱 상품 조회한 내용을 담아줄 배열 (SKProduct = Product)
    
    func fetchAllProducts() async {
        
        do {
            
            let product = try await Product.products(for: [
                "com.soomanhong.SeSACFirebase.diamond100",
                "com.soomanhong.SeSACFirebase.premium",
                "com.soomanhong.Firebase.upgrade"
            ])
            
            allProuducts = product
            
        } catch {
            print(error)
        }
    }
    
    
}
