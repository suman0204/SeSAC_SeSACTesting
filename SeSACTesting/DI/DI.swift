//
//  DI.swift
//  SeSACTesting
//
//  Created by 홍수만 on 2023/12/12.
//

import Foundation

//1. 브랜님이 브랜반점을 차림.
//2. 브랜반점에서 휴님이 뭘 드심.
// B가 변화했을 때, A에게 영향을 미친다 (브랜 반점이 변화했을 때, 휴님에게 영향을 미친다)
// => A가 B를 의존한다

// 휴님(상위 모듈) -> 브랜(코종)반점(하위 모듈) 형태로 의존 관계가 형성이 되어 있기 때문에,
// 브랜(코종)반점에서의 코드 변화가 휴님에게 영향을 미치는 것을 확인할 수 있다.
// 하위 모듈에서의 코드 변화가 상위 모듈에게 영향을 미치는 것을 확인할 수 있다.
// => 하위모듈의 변화가 상위모듈에 영향을 미치지 않게 하려면?
// => 즉 중국집이 바뀌어도, 중국집 주인장이 바뀌어도 휴님의 코드에는 영향이 없으려면?
// 브랜반점과 코종반점이 중국집 프로토콜을 따르도록,
// 브랜과 코코종은 주방장레시피 프로토콜을 따르도록.
// => 구현체가 아닌 추상화에 의존하도록 변경!
// => 인터페이스(프로토콜)로 의존 관계를 추상화

//DI: Dependency Injection 의존 관계 주입
//DIP: Dependency Inversion Principle 의존 역전 원칙

//이니셜라이저 시점에 주입을 하고,
//DI(의존성 주입)를 통해 객체의 생성과 사용을 분리한다!

//=> DI를 한다고 해서 DIP를 준수하는 것은 아니다.
//=> DIP를 구현하는 기법 중의 하나로 DI를 사용할 수 있다.

//추상화. 인터페이스. 프로토콜. 콘크리트 타입

protocol 중국집 {
    func 근사한점심메뉴() -> String
}

protocol 주방장레시피 {
    func 요리1() -> String
    func 요리2() -> String
    func 요리3() -> String
}

class 브랜: 주방장레시피 {
    func 요리1() -> String {
        return "브랜의 정성이 듬뿍 담긴 꿔바로우"
    }
    
    //국밥 -> 돈까스
//    func 국밥() -> String {
//        return "브랜의 최애 국밥"
//    }
    func 요리2() -> String {
        return "브랜의 최애 국밥"
    }
    
    func 요리3() -> String {
        return "브랜의 을밀대"
    }
}

class 코코종: 주방장레시피 {
    func 요리1() -> String {
        return "코종의 특별한 마법 소스가 들어간 탕수육"
    }
    
    func 요리2() -> String {
        return "마장동 한우 소머리국밥"
    }
    
    func 요리3() -> String {
        return "코종의 최애 밀면"
    }
}

class 코종반점: 중국집 { //하위
//    private var 주인: 코코종
    private var 주인: 주방장레시피
    
    init(주인: 주방장레시피) {
        self.주인 = 주인
    }

    func 근사한점심메뉴() -> String {
        return 주인.요리1() + 주인.요리2() + 주인.요리3()
    }
}

class 브랜반점: 중국집 { //하위
    private var 주인: 주방장레시피!
    
    //점심특선 -> 스페셜세트
//    func 점심특선() -> String {
//        return 주인.국밥() + 주인.특제꿔바로우() + 주인.평양냉명()
//    }
    func 근사한점심메뉴() -> String {
        return 주인.요리1() + 주인.요리2() + 주인.요리3()
    }
}


//코종반점의 생성 시점과 사용을 분리!
//객체의 생성과 사용의 관심을 분리한다. 즉, 생성자을 통해서 의존성을 주입한다.
class 휴님 { //상위
//    var 중국집 = 브랜반점()
//    var 중국집: 코종반점
    var 중국집: 중국집
    
    init(중국집: 중국집) {
        self.중국집 = 중국집
    }
    
    func 점심밥() -> String {
        중국집.근사한점심메뉴()
    }
}


// => 구현체가 아닌 인터페이스 추상화에 의존한다

//protocol NetworkProvider {
//    func fetchLotto()
//}
//
////네트워크를 테스트할 때는, Mock데이터를 통해 실제 네트워크 통신을 하지 않고 테스트를 진행하는 것이 적합하다
////네트워크 통신을 통해 오는 응답값을 더미값으로 대체해서 테스트
////외부환경에 영향을 받지 않는 테스트를 하기 위해 Mock데이터를 사용하고 이를 위해 protocol을 활용한다
//
//class NetworkManager {
//    
//    func fetchLott() { //실제 네트워크 통신을 진행하는 부분
//        //Almofire코드, 제이슨코드.. 상태코드처리... 등등 인터넷 연결 상태 확인..
//    }
//     
//    //인터넷이 연결되어 있어야만 테스크가 성공하겠군!...
//    //외부환경에 영향을 받으면 테스트를 올바르게 달성했다고 할 수 없다
//    //테스트는 인터넷이 연결되든 안되든 동일한 결과를 가져야 한다
//}
