//
//  File.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/04.
//  Copyright © 2020 hyeon. All rights reserved.
//

import Foundation

let DEBUG_MODE = true

let API_PATH_NAVER_CSS = "https://naveropenapi.apigw.ntruss.com/voice/v1/tts"

let PARAM_NAME_CONTENT_TYPE = "Content-Type"
let PARAM_NAME_API_ID = "X-NCP-APIGW-API-KEY-ID"
let PARAM_NAME_API_KEY = "X-NCP-APIGW-API-KEY"

let PARAM_NAME_SPEAKER = "speaker"
let PARAM_NAME_SPEED = "speed"
let PARAM_NAME_TEXT = "text"

let PARAM_VALUE_CONTENT_TYPE = "application/x-www-form-urlencoded"
let PARAM_VALUE_CLIENT_ID = "awolaeoidn"
let PARAM_VALUE_CLIENT_SECRET = "V0ey9lXGi6qPTyJ9weY9w2afbMmTohsKBYud16oJ"


let arrPlatform = ["Naver", "Kakao", "AWS", "Google", "Microsoft", "IBM"]


enum PlatformType: Int {
    
    case NAVER = 0
    case KAKAO
    case AWS
    case GOOGLE
    case MICROSOFT
    case IBM

}

var platformType = PlatformType.NAVER

let arrTitle = ["한국어, 정상속도", "한국어, 정상속도", "영어, 정상속도", "영어, 정상속도", "중국어, 정상속도"]

let arrContent = [
    "이상 그들을 되는 작고 사라지지 그리하였는가? 속잎나고, 그들은 싶이 얼마나 있는 것이다. 눈이 소리다.이것은 귀는 거선의 그들은 교향악이다."
    , "가슴이 이것이야말로 못할 있는가? 심장은 착목한는 굳세게 칼이다. 남는 같이 피가 보배를 하였으며, 들어 그림자는 때문이다."
    , "이 그들에게 평화스러운 가슴이 발휘하기 원대하고, 교향악이다. 가치를 것은 우리의 구하지 이것이다. 풍부하게 새가 이상은 속에서 피고,"
    , "자신과 못할 이상 끓는 끓는다. 그들에게 청춘은 따뜻한 동력은 교향악이다. 청춘 이 실로 사라지지 고동을 그들에게 넣는 곳으로 귀는 사막이다."
    , "두손을 하는 이 만천하의 대고, 것은 같이, 속에 이것이야말로 때문이다. 소리다.이것은 이상은 황금시대를 소금이라 실로 우리의 봄바람을 것이다."
]
