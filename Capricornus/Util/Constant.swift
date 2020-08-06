//
//  File.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/04.
//  Copyright © 2020 hyeon. All rights reserved.
//

import Foundation

let DEBUG_MODE = true

enum PlatformType: Int {
    
    case NAVER_CSS = 0
    case NAVER_CPV
    case KAKAO
    case AWS
    case GOOGLE
    case MICROSOFT
    case IBM

}
var platformType = PlatformType.NAVER_CSS

let arrPlatform = ["Naver_CSS", "Naver_CPV", "Kakao", "AWS", "Google", "Microsoft", "IBM"]


//------------------------------
// NAVER
//------------------------------

let PARAM_NAME_CONTENT_TYPE = "Content-Type"
let PARAM_NAME_API_ID = "X-NCP-APIGW-API-KEY-ID"
let PARAM_NAME_API_KEY = "X-NCP-APIGW-API-KEY"

let PARAM_NAME_TEXT = "text"
let PARAM_NAME_SPEAKER = "speaker"
let PARAM_NAME_SPEED = "speed"
let PARAM_NAME_VOLUME = "volume"
let PARAM_NAME_PITCH = "pitch"
let PARAM_NAME_EMOTION = "emotion"
let PARAM_NAME_FORMAT = "format"

let PARAM_VALUE_CONTENT_TYPE = "application/x-www-form-urlencoded"
let PARAM_VALUE_CLIENT_ID = "awolaeoidn"
let PARAM_VALUE_CLIENT_SECRET = "V0ey9lXGi6qPTyJ9weY9w2afbMmTohsKBYud16oJ"

//------------------------------
// NAVER - CSS
//------------------------------
let API_PATH_NAVER_CSS = "https://naveropenapi.apigw.ntruss.com/voice/v1/tts"

let arrNaverCSSTitle = ["한국어, 여자", "한국어, 남자", "영어, 여자", "영어, 남자"]
let arrNaverCSSSpeaker = ["mijin", "jinho", "clara", "matt"]

let arrNaverCSSContent = [
    "이상 그들을 되는 작고 사라지지 그리하였는가? 속잎나고, 그들은 싶이 얼마나 있는 것이다. 눈이 소리다.이것은 귀는 거선의 그들은 교향악이다."
    , "가슴이 이것이야말로 못할 있는가? 심장은 착목한는 굳세게 칼이다. 남는 같이 피가 보배를 하였으며, 들어 그림자는 때문이다."
    , "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's"
    , "It is a long established fact that a reader will be distracted by the readable content of a page when looking"
]

//------------------------------
// NAVER - CPV
//------------------------------
let API_PATH_NAVER_CPV = "https://naveropenapi.apigw.ntruss.com/voice-premium/v1/tts"

let arrNaverCPVTitle = ["한국어, 여자"]
let arrNaverCPVSpeaker = ["nara"]

let arrNaverCPVContent = [
    "이상 그들을 되는 작고 사라지지 그리하였는가? 속잎나고, 그들은 싶이 얼마나 있는 것이다. 눈이 소리다.이것은 귀는 거선의 그들은 교향악이다."
]
