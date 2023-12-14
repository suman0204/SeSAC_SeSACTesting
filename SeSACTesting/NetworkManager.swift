//
//  NetworkManager.swift
//  SeSACTesting
//
//  Created by 홍수만 on 2023/12/13.
//

import Foundation
import Alamofire

protocol NetworkProvider {
    func fetchLotto(completionHandler: @escaping (Lotto) -> Void)
}

//네트워크를 테스트할 때는, Mock데이터를 통해 실제 네트워크 통신을 하지 않고 테스트를 진행하는 것이 적합하다
//네트워크 통신을 통해 오는 응답값을 더미값으로 대체해서 테스트
//외부환경에 영향을 받지 않는 테스트를 하기 위해 Mock데이터를 사용하고 이를 위해 protocol을 활용한다

class NetworkManager: NetworkProvider {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1000"
    
    func fetchLotto(completionHandler: @escaping (Lotto) -> Void) {
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let success):
                print(success)
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
     
}

struct Lotto: Codable {
    let drwNoDate: String
    let bnusNo: Int
    let drwtNo1: Int
}
