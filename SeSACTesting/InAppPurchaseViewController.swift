//
//  InAppPurchaseViewController.swift
//  SeSACTesting
//
//  Created by 홍수만 on 2023/12/15.
//

/*
1. 유료 계약 활성화 / 개발자 계정 / In App Purchase Capabilities
2. Appstore Connect In App Product 등록
*/

import UIKit
import StoreKit

class InAppPurchaseViewController: UIViewController {
    
    @IBOutlet var productLabel: UILabel!
    
    //1.인앱 상품 ID 정의
    var productIdentifier: Set<String> = ["com.soomanhong.SeSACFirebase.diamond100"]
    
    var productArray = Array<SKProduct>()
    var product: SKProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //2. productIdentifier에 정의된 상품ID 정보 가져오기 + 사용자의 디바이스가 인앱 결제 가능한지 확인
    func requestProductData() {
        if SKPaymentQueue.canMakePayments() {
            print("인앱 결제 가능")
            //3. 인앱 상품 조회
            let request = SKProductsRequest(productIdentifiers: productIdentifier)
            request.delegate = self
            request.start() //인앱 상품 조회 시작
            
        } else {
            print("In App Purchase Not Enabled")
        }
    }
    
    @IBAction func buyButtonClicked(_ sender: UIButton) {
        //5. 구매 버튼 클릭
        let payment = SKPayment(product: product!)
        SKPaymentQueue.default().add(payment)
        SKPaymentQueue.default().add(self)
    }
    
}


extension InAppPurchaseViewController: SKProductsRequestDelegate {
    
    //4. 인앱 상품 정보 조회
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        let products = response.products
        
        if products.count > 0 {
            
            for item in products {
                productArray.append(item)
                product = item //옵션
                
                print(item.productIdentifier)
                print(item.localizedTitle)
                print(item.price)
                print(item.priceLocale)
            }
        }
    }
    
}

//SKPaymentTransactionObserver: 구매 승인, 취소에 대한 프로토콜
extension InAppPurchaseViewController: SKPaymentTransactionObserver {
    
    func receiptValidation(transaction: SKPaymentTransaction, productIdentifier: String) {
        
        //구매ㅐ 영수증 정보
        let receiptFileURL = Bundle.main.appStoreReceiptURL
        let receiptData = try? Data(contentsOf: receiptFileURL!)
        let receiptString = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        print(receiptString)
    }
    
    //updatedTransactions
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            switch transaction.transactionState {
                
            case .purchasing:
                print("구매하는 중")
            case .purchased:
                print("구매 완료 상태")
                print(transaction.payment.productIdentifier)
                receiptValidation(transaction: transaction, productIdentifier: transaction.payment.productIdentifier)
            case .failed:
                print("구매 실패")
                SKPaymentQueue.default().finishTransaction(transaction)
            
            case .restored:
                print("구매 복원")
            default:
                print("default")
            }
        }
    }
    
    //removedTransactions
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        print("removedTransaction")
    }
    
    
}
