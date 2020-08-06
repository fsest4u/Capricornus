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
//MARK: NAVER
//------------------------------
let API_PATH_NAVER_HOST = "https://naveropenapi.apigw.ntruss.com"

let PARAM_NAME_NAVER_CONTENT_TYPE = "Content-Type"
let PARAM_NAME_NAVER_API_ID = "X-NCP-APIGW-API-KEY-ID"
let PARAM_NAME_NAVER_API_KEY = "X-NCP-APIGW-API-KEY"

let PARAM_VALUE_NAVER_CONTENT_TYPE = "application/x-www-form-urlencoded"
let PARAM_VALUE_NAVER_CLIENT_ID = "awolaeoidn"
let PARAM_VALUE_NAVER_CLIENT_SECRET = "V0ey9lXGi6qPTyJ9weY9w2afbMmTohsKBYud16oJ"

let PARAM_NAME_NAVER_TEXT = "text"
let PARAM_NAME_NAVER_SPEAKER = "speaker"
let PARAM_NAME_NAVER_SPEED = "speed"
let PARAM_NAME_NAVER_VOLUME = "volume"
let PARAM_NAME_NAVER_PITCH = "pitch"
let PARAM_NAME_NAVER_EMOTION = "emotion"
let PARAM_NAME_NAVER_FORMAT = "format"



//------------------------------
// NAVER - CSS
//------------------------------
let API_PATH_NAVER_CSS = "/voice/v1/tts"

let arrNaverCSSTitle = ["한국어, 여자", "한국어, 남자", "영어, 여자", "영어, 남자"]
let arrNaverCSSSpeaker = ["mijin", "jinho", "clara", "matt"]

let arrNaverCSSContent = [
    "대체 무슨 말인지.'뭐야, 이 아저씨는.' 그리고 대체 누구인지. 굳은 머리로 곰곰이 생각해봤지만 모르겠다. 이 정도로 일상 회화를 주고 받을 만한 인간이 최근에는 없었다."
    , "가슴이 이것이야말로 못할 있는가? 심장은 착목한는 굳세게 칼이다. 남는 같이 피가 보배를 하였으며, 들어 그림자는 때문이다."
    , "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's"
    , "It is a long established fact that a reader will be distracted by the readable content of a page when looking"
]

//------------------------------
// NAVER - CPV
//------------------------------
let API_PATH_NAVER_CPV = "/voice-premium/v1/tts"

let arrNaverCPVTitle = ["한국어, 여자"]
let arrNaverCPVSpeaker = ["nara"]

let arrNaverCPVContent = [
    "대체 무슨 말인지.'뭐야, 이 아저씨는.' 그리고 대체 누구인지. 굳은 머리로 곰곰이 생각해봤지만 모르겠다. 이 정도로 일상 회화를 주고 받을 만한 인간이 최근에는 없었다."
]

//------------------------------
// AWS - General
//------------------------------



//------------------------------
// AWS - Neural Network
//------------------------------


//------------------------------
//MARK: KAKAO
//------------------------------
let API_PATH_KAKAO_HOST = "https://kakaoi-newtone-openapi.kakao.com"

let API_PATH_KAKAO_SYN = "/v1/synthesize"

let PARAM_NAME_KAKAO_CONTENT_TYPE = "Content-Type"
let PARAM_NAME_KAKAO_AUTHORIZATION = "Authorization"

let PARAM_VALUE_KAKAO_CONTENT_TYPE = "application/xml"
let PARAM_VALUE_KAKAO_AUTHORIZATION = "KakaoAK d3be46c0e606e3b7ecd081da415d3760"

let arrKakaoTitle = ["WOMAN_READ_CALM", "MAN_READ_CALM", "WOMAN_DIALOG_BRIGHT", "MAN_DIALOG_BRIGHT"]

let arrKakaoContent = [
    """
<speak>
<voice name="WOMAN_READ_CALM"> 대체 무슨 말인지.'뭐야, 이 아저씨는.' 그리고 대체 누구인지. 굳은 머리로 곰곰이 생각해봤지만 모르겠다. 이 정도로 일상 회화를 주고 받을 만한 인간이 최근에는 없었다.</voice>
</speak>
"""
    , """
<speak>
<voice name="MAN_READ_CALM"> 대체 무슨 말인지.'뭐야, 이 아저씨는.' 그리고 대체 누구인지. 굳은 머리로 곰곰이 생각해봤지만 모르겠다. 이 정도로 일상 회화를 주고 받을 만한 인간이 최근에는 없었다.</voice>
</speak>
"""
    , """
<speak>
<voice name="WOMAN_DIALOG_BRIGHT"> 대체 무슨 말인지.'뭐야, 이 아저씨는.' 그리고 대체 누구인지. 굳은 머리로 곰곰이 생각해봤지만 모르겠다. 이 정도로 일상 회화를 주고 받을 만한 인간이 최근에는 없었다.</voice>
</speak>
"""
    , """
<speak>
<voice name="MAN_DIALOG_BRIGHT"> 대체 무슨 말인지.'뭐야, 이 아저씨는.' 그리고 대체 누구인지. 굳은 머리로 곰곰이 생각해봤지만 모르겠다. 이 정도로 일상 회화를 주고 받을 만한 인간이 최근에는 없었다.</voice>
</speak>
"""
]


