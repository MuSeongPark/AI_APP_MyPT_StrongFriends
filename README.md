<p align="center"><img src="/images/logo_mypt.png"></p>

# 내 손안의 개인 트레이너: MyPT

## 1. 프로젝트 소개

| 시연영상 |
|:----:|
|[![Video Label](https://img.youtube.com/vi/LHzZhv7nk6M/0.jpg)](https://youtu.be/LHzZhv7nk6M)|

&nbsp; 내 손안의 개인 트레이너 MyPT 앱은 인공지능 트레이너 모델을 이용해 장병들의 운동 자세를 분석하고 피드백합니다. MyPT는 운동하는 장병들의 부상을 방지하고 순위보드를 제공하여 체력 단련을 고취시키는 앱입니다. MyPT는 이용자의 운동 동작을 인식해 정확한 자세를 취햇는지, 목표 운동량을 채웠는지 확인합니다. 비대면 운동 효과를 입증하는 앱입니다.

### *Notice.*
*앱의 UI, AI, BackEnd의 유기적인 동작이 필요한 MyPT앱의 특성 상 현재 APP폴더 안에 APP의 UI, BackEnd 및 AI까지 모두 포함되어 있으며, AI 내용의 경우 Colab으로 먼저 알고리즘을 최적화 한 후, 다트코드로 변환을 거져 알고리즘을 적용 했기에, Colab으로 표현한 개수측정 및 자세평가 알고리즘과 해당 알고리즘을 다트 코드로 변환한 내용이 같이 포함되어 있습니다.*)

## 2. 기능 설명

### &nbsp; 🏋️‍♂️ 개수세기 & 운동자세분석
#### &nbsp; 1) 기본 서비스
MyPT는 사용자의 <strong>우측관절</strong>의 각도와 위치로 운동개수를 세고, 자세를 분석합니다.<br>
<strong>GoogleTTS</strong>를 이용해 운동 1회마다 음성으로 <strong>운동 횟수</strong>를 알려주며, 2회마다 사용자의 <strong>자세에 대한 피드백</strong>을 해줍니다.
#### &nbsp; 2) 운동자세분석 화면

| 푸쉬업 측정 화면 | 풀업 측정 화면 | 스쿼트 측정 화면 |
|:----:|:----:|:----:|
|<img src="/images/pushup_screen.PNG" width=300 > |<img src="/images/pullup_screen.PNG" width=300 > |<img src="/images/squat_screen.PNG" width=300 >|

<br>화면의 좌측상단에 실시간으로 운동분석에 사용되는 관절의 각도를 표시합니다.
<br>화면의 상단에 실시간으로 운동분석상태(운동분석대기중, 운동분석중, 운동분석완료)와 운동개수를 표시합니다.
<br>화면의 우측상단에 실시간으로 피드백 결과를 보여줍니다. 해당 피드백 결과가 좋으면 <font color="green">초록색</font>, 아니면 <font color="red">빨강색</font>입니다.
<br>
| 각도  | 분석결과 및 개수 | 올바른 자세 피드백 | 잘못된 자세 피드백 |
|:----:|:----:|:----:|:----:|
|<img src="/images/angle_screen.PNG">|<img src="/images/repetition_screen.PNG">|<img src="/images/feedback_good.PNG"> |<img src="/images/feedback_not_good.PNG">|
<br>

#### &nbsp; 3) 운동 피드백 
MyPT앱에서 현재 제공하는 PT 서비스는 <strong>Pushups, Squats, Pullups</strong>입니다. 

| 푸쉬업 | 스쿼트 | 풀업 |
|:----:|:----:|:----:|
| 완전 이완하지 않았는지 (not_elbow_up) | 완전 이완하지 않았는지 (not_elbow_up) | 완전 이완하지 않았는지 (not_elbow_up) |
| 완전 수축하지 않았는지 (not_contraction) | 완전 수축하지 않았는지 (not_contraction) | 완전 수축하지 않았는지 (not_contraction) |
| 골반이 내려갔는지 (is_hip_down) | 무릎보다 골반이 먼저 수축하였는지 (hip_dominant) | 운동 시 팔꿈치가 안정적이지 않은지 (not_elbow_stable) |
| 골반이 올라갔는지 (is_hip_up) | 골반보다 무릎이 먼저 수축하였는지 (knee_dominant) | 반동을 사용하였는지 (is_recoil) |
| 무릎이 펴지지않고 굽었는지 (is_knee_down) | 무릎이 발끝보다 앞으로 나갔는지 (not_knee_in) | 운동 수행속도가 빠른지 (is_speed_fast) |
| 운동 수행속도가 빠른지 (is_speed_fast) | 운동 수행속도가 빠른지 (is_speed_fast) |  |

#### &nbsp; 4) 피드백 결과

운동이 끝나면 결과페이지에서 사용자의 <strong>운동자세 분석 결과, 운동 개수, 운동 점수</strong>와 그에 맞는 <strong>피드백</strong>이 주어집니다.

|예시 결과페이지|
|:------------:|
|![result_page](https://github.com/osamhack2021/AI_APP_MyPT_StrongFriends/blob/main/images/result_page_example.gif)|

### &nbsp; 💻 UI 페이지

#### &nbsp; 1) 초기 MyPT 와이어프레임
<img src="/images/wireframe.jpg" height="450px">

<br> 먼저 Figma라는 웹사이트를 통해 기본적인 와이어프레임(Wireframe)을 구축했으며 팀원 모두에게 공개해 전체적인 앱의 워크플로우를 함께 의논했습니다. 이 와이어프레임을 통해 전체적인 앱 기능 흐름을 파악했으며 유저가 순조롭게 앱을 사용할 수 있는 앱을 개발할 수 있도록 초기 계획 작업을 진행했습니다. Figma에는 오픈된 다양한 UI 디자인 샘플들을 참고해서 전체적 UI 테마를 구성했습니다. 

#### &nbsp; 2) 서비스 플로우
<img src="/images/workflow.jpg">

#### &nbsp; 3) UI 페이지 소개
| 화면 | 이름 | 설명 |
|:-----:|:-----:|:------:|
| <img src="/images/login_page.PNG" width=600> | <strong>로그인 화면</strong> | 구글 계정또는 MyPT 앱의 아이디로 로그인 하는 화면입니다. |
| <img src="/images/home_page.PNG" width=600> | <strong>홈페이지 화면</strong> | 로그인시 바로 보이는 화면입니다.<br> 부위별 운동화면과 운동분석결과폴더 화면으로 넘어갈 수 있습니다. |
| <img src="/images/category_list_page.PNG" width=600> | <strong>부위별 운동 화면</strong> | 홈페이지의 categories의 운동부위를 클릭하면 부위별 운동화면으로 넘어옵니다.<br> 부위별로 테스트할 수 있는 운동이 나열되어 있습니다.<br> 운동을 선택시 운동분석 설명 화면으로 넘어갑니다. |
| <img src="/images/workout_description_page.PNG" width=600> | <strong>운동분석 설명 화면</strong> | 해당 운동에 대한 AI자세분석 서비스에 대한 간략한 설명이 있습니다. 목표개수를 지정하고 AI 자세분석을 시작할 수 있습니다. |
| <img src="/images/result_list_page.PNG" width=600> | <strong>운동분석결과폴더 화면</strong> | 사용자의 운동자세분석결과들이 저장되어있는 화면입니다.<br> 사용자는 자신의 과거 운동분석결과를 확인할 수 있습니다. |
| <img src="/images/result_page.PNG" width=600> | <strong>운동분석결과 화면</strong> | AI 운동자세분석 서비스가 끝나면 운동분석결과 화면으로 넘어갑니다.<br> 이 화면에서 사용자의 피드백 결과들의 개수를 한눈에 볼 수 있고,<br> 가장 많이 나온 안좋은 자세 두가지에 대해 text로 피드백을 받아볼 수 있습니다.<br> 운동분석결과 화면은 운동분석결과폴더 화면에서도 볼 수 있습니다. |
| <img src="/images/community_page.PNG" width=600> | <strong>커뮤니티 화면</strong> | 사용자들이 운동과 관련된 영상을 공유하고 볼 수 있는 화면입니다. |
| <img src="/images/leader_board_page.PNG" width=600> | <strong>리더보드 화면</strong> | MyPT앱 사용자들의 운동점수 총합이 리더보드에서 랭킹으로 만들어집니다. |


## 3. 기술 설명




### &nbsp; 🤔 How AI Used?
#### &nbsp; AI Workflow
<br> 인공지능에서 쓰이는 전반적인 workflow입니다. 각각에 대한 설명은 아래에 있습니다.
<br><img src="/images/AI_workflow.png">

#### &nbsp; 1) pose detection model 사용한 angle 추출
<img src="/images/Pose_detection.png" width=700 height=450 alt="ML kit posedetection PoseLandmark"/>
<br> MyPT앱에서는 Google MLkit의 Pose Detection model를 매 frame에 적용하여 33종류의 관절 위치를 3차원 (x,y,z)좌표로 확인합니다. 개수와 자세를 판단하는 알고리즘을 Colab 개발 환경을 통해 실험했습니다. 여러 운동영상을 input으로 하여 각 관절의 각도 변화그래프를 그리고, 특징있는 관절의 움직임을 포착하여 threshold값을 설정했습니다. 이를 통해서 운동시 up state인지, down state인지 나누게 하고, 운동시 특정 조건을 충족했는지 여부에 따라 올바른 자세와 잘못된 자세를 분류했습니다. 완성된 알고리즘을 dart언어로 변환하고 Edge-device의 pose detection model에 맞도록 threshold값을 수정했습니다.<br>
<br>💡 <strong>python으로 분석한 Angle graph 예시</strong>
<br>
        
| 운동 | 시간별 Angle graph |
|:----:|:------:|    
| squat |<img src="/images/squats_example/3D2.jpg">|
| push up |<img src="/images/pushups_example/3D2.jpg">|
| pull up |<img src="/images/pullups_example/3D2.jpg">|


<br>

#### &nbsp; 2) 잘못된 관절정보 분류
<br>isOutlierPushUps, isOutlierSquats, isOutlierPullups 함수는 Pose Detection이 올바르게 되었는지 판단하여 주는 함수입니다. Pose Detection이 올바르게 되면 true를, 올바르지 않게 되었으면 false를 return합니다. 앱 내에서 실시간으로 매 프레임 별로 자세 분석 시 관절의 위치를 잘못 찍는 노이즈 값들이 간혹 식별되었습니다. 이 노이즈 값들이 자세 평가에 반영이 되지 않도록 하는 함수입니다. 매 frame별로 관찰을 하다가 점을 잘못찍었다고 판단이 되면(관찰하고자하는 관절의 각도의 변화량이 급격하면) 해당 프레임을 무시합니다. 즉, 각도가 연속적으로 변하도록 하는 함수입니다. 운동 종류 및 관절에 따라 프레임별로 변화할 수 있는 threshold를 설정해두고, 각도 변화가 해당 threshold값보다 클 경우 false를 return합니다.

💡 <strong>isOutlier 함수 적용 예시</strong>
<br><br>
isOutlier함수의 사용 예시입니다. 우측 팔꿈치, 손목 부분을 보면 차이를 알 수 있습니다.
| Pose detection이 잘 된 경우 | Pose detection이 잘못 된 경우 | 작동 예시 영상 |
|:---:|:---:|:---:|
|<img src="/images/good.PNG" width=300>|<img src="/images/bad.PNG" width=300>|<img src="/images/is_outlier_example.gif" width=300>|
| return true | return false | 잘못된 관절정보를 <br> 운동분석에 반영하지 않습니다 |

<br><br>

#### &nbsp; 3) segmentation model 사용해서 더 정교한 운동분석 (앱상에 미적용)
Colab상에서 <strong>Pose Detection model</strong>과 <strong>Selfie Segmentation model</strong>을 매 frame에 적용하여 Pull-up 운동 시 Shoulder Packing을 했는지 여부를 판단하는 모델을 만들었습니다. flutter에서 사용할 수 있는 API의 부재로 아직 앱에 적용하지 않았습니다. 추후 API를 만들어 앱에 적용할 수 있습니다.<br>
&nbsp; 아래 그림과 같이 어깨와 골반을 양 끝으로 하는 변을 만들고, 그 변을 빗변으로 하고 나머지 변들이 x축과 y축에 평행하는 변 2개를 만들어 직각삼각형을 만듭니다. 이 삼각형 내의 특징을 잡는 선분(초록색 선분)을 판단하여, 완전 수축 시 해당 선분의 몇 퍼센트가 사람에 해당하는지 파악하게 합니다. 사람에 해당하는 비율이 특정 값 이상일 경우, Shoulder Packing을 하지 않았다고 판단할 수 있습니다. 관절 정보만으로는 허리가 굽었는지 여부를 판단하는데 한계가 있어, selfie segmentation 모델을 이용하여 사람과 배경을 경계면으로 나누어 이 문제점을 해결하였습니다.
<br><img src="/images/draw_triangle.png" width=300 height=400 alt="segmentation model 적용 예시">

&nbsp; 💡 <strong>segmentation model 적용 예시-숄더패킹</strong>
<br>Pose Detection model, Selfie Segmentation model을 같이 사용하여 등이 굽었는지를 판단한 예시입니다.
<br>
| 초록색 직선이 사람의 등에 해당하지 않음 | 초록색 직선이 사람의 등에 해당함 |
|:---:|:---:|
|<img src="/images/shoulder_packing.png" width=300 height=400 alt="segmentation model 적용 예시">|<img src="/images/not_shoulder_packing.png" width=300 height=400 alt="segmentation model 적용 예시">|
| Shoulder Packing O | Shoulder Packing X |
<br>



## 4. MyPT 앱 설치 필수 조건 안내
**MyPT 앱은 Android SDK Version 21(Android 5.0 LOLLIPOP) 이상부터 지원**
|Android PLATFORM VERSION|API LEVEL|지원 여부|
|:-----|:-----:|:-----:|
|10.0 Android 10|29|지원|
|9.0 Pie|28|지원|
|8.1 Oreo|27|지원|
|8.0 Oreo|26|지원|
|7.1 Nougat|25|지원|
|7.0 Nougat|24|지원|
|6.0 Marshmallow|23|지원|
|5.1 Lollipop|22|지원|
|5.0 Lollipop|21|지원|
|4.4 KitKat|19|***미지원***|
|4.3 Jelly Bean|18|***미지원***|
|4.2 Jelly Bean|17|***미지원***|
|4.1 Jelly Bean|16|***미지원***|
|4.0 Ice Cream Sandwich|15|***미지원***|


## 5. 기술 스택(Technique Used)
### &nbsp; 1. AI (인공지능)
- Dart Language
- ML Kit Flutter Plugin
- GoogleTTS
#### 인공지능 Colab File
- Python
- Python Opencv
- Numpy
- Mediapipe
- Matplotlib
### &nbsp; 2. 프론트 엔드 (Front-End)
| Language | Mobile-App Framework | Wireframe |
| :---:    |        :---:         |      :---: |
|<a href="https://dart.dev/"><img src="/APP(Android)/assets/images/dart.jpg" height="100px"></a>|<a href="https://flutter.dev/"><img src="/APP(Android)/assets/images/flutter.png" height="100px"></a>|<a href="https://www.figma.com/"><img src="/APP(Android)/assets/images/figma.png" height="100px"></a>| </p>


| 사용한 오픈소스 패키지  | 용도 |
| :-------------: | :-------------: |
| Line Awesome Flutter | 아이콘 |
| Get 4.3.8 | 앱 Navigator |
| Camera Plugin | 플러터 내 카메라 기능 |
| FL_chart  | 그래프 작성 |
| Validators | 유저 Input 관리 |
| Youtube Player Iframe | 유튜브 영상 추가 |

<!--

<br> 프론트엔드 개발팀은 구글의 모바일앱 프레임워크인 플러터(Flutter) 기술을 활용했으며 시각적으로 매력적인 UI(User Interface)를 구현하고 유저에게 보다 편리한 앱 사용 경험(UX, User Experience)을 제공하자는 목표를 수립했습니다.

<br> (초기 MyPT 와이어프레임) </p>
<img src="/images/wireframe.jpg" height="450px">

<br> 먼저 Figma라는 웹사이트를 통해 기본적인 와이어프레임(Wireframe)을 구축했으며 이 팀원 모두에게 공개해 전체적인 앱의 워크플로우를 함께 의논했습니다. 이 와이어프레임을 통해 전체적인 앱 기능 흐름을 파악했으며 유저가 순조롭게 앱을 사용할 수 있는 앱을 개발할 수 있도록 초기 계획 작업을 진행했습니다. 또한 Figma에는 오픈된 다양한 UI 디자인 샘플들이 있기에 이들을 많이 참고하고 이에 기반해 전체적 UI 테마를 구성했습니다. 이후, GitHub에서 지원하는 Codespace를 통해 UI 개발에 착수했습니다. 

<br> MyPT 앱의 포론트엔드는 포괄적으로 다섯 가지 목적을 바탕으로 페이지들을 분류할 수 있습니다. 

1. 로그인 및 회원가입 페이지
2. Bottom Navigation Bar를 통한 메인 페이지 (운동 종목 리스트, 커뮤니티, 리더보드)
3. 운동 리스트 및 개수 설정 페이지
4. 카메라를 통한 Pose Detection 페이지
5. 분석/그래프 페이지 

-->


### &nbsp; 3. Server(back-end)
- Firebase Authentication
- Cloud Firestore(NoSQL)


## 6. 설치 안내 (Installation Process)
1. APP 빌드(Aplication Build apk)
  - Test 환경
```
APK 빌드 컴퓨터(APK Build Computer)
iMac(4k, 21.5-inch, 2019)
프로세서 : 3GHz 6 core intel Core i5
메모리 : 32GB 2667MHz DDR4
저장장치 : 1TB SSD
그래픽카드 : Radeon Pro 560X 4GB
JAVA : OpenJDK 11
Android SDK : 31
Flutter : 2.5.0
Dart : 2.14.0
VScode : 3.27.0
```
  - Test 환경에서 apk build
```
$ git clone https://github.com/osamhack2021/AI_APP_MyPT_StrongFriends.git
$ cd APP(Android)
$ flutter build apk --release
```



2. Android APK 다운로드 

  * First : APK 다운로드 링크에서 다운로드 받기

       [APK Download Link](https://drive.google.com/file/d/1595hTpuSuOu6rwMr_gfpSnx1In-Lu18y/view?usp=sharing)

  * Second : 다운로드 받은 APK 파일 Android 기기에 설치



3. Colab 상에서 Android에 구현한 Model 실행 방법
  * Colab에서 실행
    * [Colab 실행 링크](https://colab.research.google.com/github/osamhack2021/AI_APP_MyPT_StrongFriends/blob/main/AI(BE)/Count_Evaluate.ipynb)

  - 사전에 해야할 것
    - First : Google Drive에 학습할 자료 넣어 두기
      - 다운로드 해야할 것 : 스쿼트, 턱걸이, 팔굽혀펴기
      - [모델 사전 데이터 다운로드](https://drive.google.com/drive/folders/1sCHku9nK93Dm1MzkTj50wY4OILUaTQAj?usp=sharing)
    -   Second : 다운받은 폴더를 Google Drive 안에 저장해야하는 경로(만약 구글 드라이브에 국방부 폴더와 input 폴더가 없을 시 생성) <br>

```
$ MyDrive/국방부 해커톤/input/
```


## 7. 프로젝트 사용법 (Getting Start)

### 앱 사용시 주의점

1. 운동자세분석 서비스를 사용할 시에 오른쪽 관절을 카메라쪽으로 보여주어야 합니다.
2. 사용자가 몸의 체형이 잘보이는 옷을 입고 있을수록, 사용자의 몸이 카메라에 꽉차게 보일 수록, 좋은 운동분석결과를 얻을 수 있습니다.
3. 카메라에 찍히는 주변환경에 따라 pose estimation 정확성이 달라질 수 있습니다. 물건들이 사람의 관절로 분류되는 경우가 있습니다. 

### &nbsp; AI Model 사용법
MyPT 앱의 포즈추정, 개수세기, 자세평가 모델을 사용하는 방법을 안내합니다.

|Environment|Pose Estimation|Counting|Pose Evaluation|
|:-----:|:-----:|:-----:|:-----:|
|Android or IOS|[Google ML Kit](https://pub.dev/packages/google_ml_kit)|[Analysis Model](APP(Android)/lib/models/)|[Analysis Model](APP(Android)/lib/models/)|
|Window or Linux|[MediaPipe](https://mediapipe.dev/)|[Tflite Model](AI(BE)/Previous_materials/)| - |

## 8. 팀 정보
|Name|GitHub|Responsibility|Major|Contact Us|
|:-----:|:-----:|:-----:|:-----:|:-----:|
|Hyun mingu|alsrnwlgp|Team Leader / Sub App UI Developer & Camera Service Developer|대구경북과학기술원(DGIST) 16학번 기초학부|alsrnwlgp@gmail.com|
|Jongin Jun|jonginj0130|Main App UI Developer(Front-end)|Georgia Institute of Technology 20학번 컴퓨터과학부|jonginj0130@gmail.com|
|Taehyun Park|todd-park|APP TEST & Backend developer|한밭대학교 18학번 컴퓨터공학과|pth0325@gmail.com|
|Jaejun Han|HackerTiger|AI Engineer & Main Algorithm Developer|한국과학기술원(KAIST) 17학번 전기및전자공학부|hanjj03@naver.com|
|MuSeong Park|MuSeongPark|AI Engineer & Sub Algorithm Developer & Voice Feedback System Developer|경상대학교 19학번 항공소프트웨어공학부|pms3620@gmail.com|


## 9. 저작권 및 사용권 정보 (Copyleft / End User License)
&nbsp; [MIT License](license.md)

## 10. 발전 가능성, 독창성, 협업 방식
&nbsp; a) 발전 가능성(확장 가능성)
<br>MyPT에서 제공하는 운동 종류는 pushup, squat, pullup 3가지입니다. MyPT앱은 이 3가지 운동에 대해서만 국한되지 않고, 동일한 기술을 이용하여 다른 운동들에 대해서도 확장해나갈 수 있습니다. 오픈소스로 코드를 제공하는만큼, StrongFriends 팀의 코드를 보고 이를 이용하여 MyPT앱이 발전해나가면 좋겠습니다. 또한 위에서 언급한 selife segmentation같은 기능도 추가하여 평가 요소를 더욱 다양화할 수 있습니다.

&nbsp; b) 독창성
<br>Edge-device에서 Real time(실시간)으로 사용할 수 있게, 경량화 된 모델을 사용하였습니다. 경량화된 모델을 사용하여 관절의 위치를 점찍는데 노이즈 값이 생겨 간혹 자세 분석이 부정확한 경우가 있습니다. 이런 오류는 위에서 설명한 isOutlier을 이용하여 운동 평가에 반영하지 않게 구현하였습니다. 동영상을 웹상으로 보내고 Backend에서 이를 평가하는 것이 정확성이 높지만, 운동 시 즉각적으로 피드백을 받지 못하고, 영상을 웹상으로 보내면 network latency 과도하게 커지는 단점이 있습니다. 사용자에게 편리하게, 즉각적으로 피드백을 해줄 수 있도록 가능한 연산량을 최소화하고 실시간으로 자세파악을 할 수 있게하였습니다. 실시간으로 앱을 돌려보면 calculation latency가 약 25ms로 나오며, 앱 사용에 지장이 없습니다.

&nbsp; c) 협업 방식
- Notion: https://flax-eocursor-d20.notion.site/OSAM-b4539a3870f24ffda2423e92f7b86926
- Gdrive: https://drive.google.com/drive/folders/11Z-AgT0SLZ74gdZk9Ddx1umY44_bx77z?usp=sharing
- Github Repository: https://github.com/osamhack2021/AI_APP_MyPT_StrongFriends
- KaKaoTalk 단체톡방으로 이용한 전체회의, 채팅
- 회의 내용은 팀 블로그 내 협업 게시판에 간결히 정리
