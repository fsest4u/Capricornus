//
//  File.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/04.
//  Copyright © 2020 hyeon. All rights reserved.
//

import Foundation
import AVFoundation

let DEBUG_MODE = true

//------------------------------
//MARK: TTS
//------------------------------

enum TTSPlatformType: Int {
    
    case NAVER_CSS
    case NAVER_CPV
    case KAKAO
    case GOOGLE
    case AWS
//    case MICROSOFT
//    case IBM

}
var ttsPlatformType = TTSPlatformType.NAVER_CSS

let arrTTSPlatform = [
    "Naver_CSS"
    , "Naver_CPV"
    , "Kakao"
    , "Google"
    , "AWS"
//    , "Microsoft"
//    , "IBM"
]




//------------------------------
//MARK: NAVER
//------------------------------
let API_PATH_NAVER_HOST = "https://naveropenapi.apigw.ntruss.com"

let PARAM_NAME_NAVER_CONTENT_TYPE = "Content-Type"
let PARAM_NAME_NAVER_API_ID = "X-NCP-APIGW-API-KEY-ID"
let PARAM_NAME_NAVER_API_KEY = "X-NCP-APIGW-API-KEY"

let PARAM_VALUE_NAVER_TTS_CONTENT_TYPE = "application/x-www-form-urlencoded"
let PARAM_VALUE_NAVER_STT_CONTENT_TYPE = "application/octet-stream"
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
<voice name="MAN_DIALOG_BRIGHT"> 정현아 사랑해. 말인지.'뭐야, 이 아저씨는.' 그리고 대체 누구인지. 굳은 머리로 곰곰이 생각해봤지만 모르겠다. 이 정도로 일상 회화를 주고 받을 만한 인간이 최근에는 없었다.</voice>
</speak>
"""
]

//------------------------------
//MARK: Google - General
//------------------------------
let API_PATH_GOOGLE_HOST = "https://texttospeech.googleapis.com"

let API_PATH_GOOGLE_SYN = "/v1/text:synthesize"

let PARAM_NAME_GOOGLE_CONTENT_TYPE = "Content-Type"
let PARAM_NAME_GOOGLE_AUTHORIZATION = "Authorization"

let PARAM_VALUE_GOOGLE_CONTENT_TYPE = "application/json; charset=utf-8"
//let PARAM_VALUE_GOOGLE_AUTHORIZATION = "Bearer $(gcloud auth application-default print-access-token)"
let PARAM_VALUE_GOOGLE_AUTHORIZATION = "Bearer $(gcloud auth  print-access-token)"

let arrGoogleTitle = ["en-GB-Standard-A"]

let arrGoogleContent = [
"""
{
  'input':{
    'text':'Android is a mobile operating system developed by Google,
       based on the Linux kernel and designed primarily for
       touchscreen mobile devices such as smartphones and tablets.'
  },
  'voice':{
    'languageCode':'en-gb',
    'name':'en-GB-Standard-A',
    'ssmlGender':'FEMALE'
  },
  'audioConfig':{
    'audioEncoding':'MP3'
  }
}
"""
]


//------------------------------
//MARK: AWS - General
//------------------------------



//------------------------------
// AWS - Neural Network
//------------------------------



//------------------------------
//MARK: STT
//------------------------------

enum STTPlatformType: Int {
    
    case NAVER

}
var sttPlatformType = STTPlatformType.NAVER

let arrSTTPlatform = [
    "Naver"
]

//------------------------------
//MARK: Record
//------------------------------

let API_PATH_NAVER_CSR = "/recog/v1/stt"

// mp3, aac, ac3, ogg, flac, wav

let RECORD_SETTING = [
    
    AVFormatIDKey : NSNumber(value : kAudioFormatAppleLossless as UInt32),
    AVEncoderAudioQualityKey : AVAudioQuality.high.rawValue,
    AVEncoderBitRateKey : 16,
    AVNumberOfChannelsKey : 1,
    AVSampleRateKey : 12000
    
] as [String : Any]



