# Flow

### Flow :: 파일 버전 관리 시스템

<img src="Icon/logo.png" width="20%" height="20%">

이 프로젝트는 2023학년도 KSA 자료구조 프로젝트를 위해 진행되었습니다.      

- - -
      
## PURPOSE     
> :: 개발 목적

파일 작업을 하던 도중 전 버전으로 되돌리고 싶다던가, 혹은 새로운 아이디어가 생각나서 새롭게 작업을 하고 싶을 경우, 이전 파일을 따로 복사해두고 덮어 씌워
작업해야합니다. 만약에 원래대로 되돌려야 하는데 원본 파일이 남아있지 않다면, 했던 작업을 새로 다시 해야하는 불상사가 발생할 수 있다. 기존 파일 버전 관리
시스템인 git은 일반인들이 사용하기에 불편하다는 단점이 있었다. Flow는 이러한 불편함을 해결하기 위해 개발되었습니다. Flow는 매우 직관적인 UI와 편리한
기능의 파일 버전 관리 시스템을 제공합니다.

## GUIDELINES & ALGORITHM
> :: 사용 가이드 및 알고리즘

1. **Flow 생성**                  
New 버튼을 클릭한 후 원하는 폴더 혹은 파일을 선택하면, 자동으로 Flow가 생성되며 버전 관리 시스템이 설정됩니다. .flow 파일에는 기본적인 Flow 시스템
정보가 저장되고, .flowdata 폴더에는 각종 브랜치와 히스토리 정보, 메타 데이터 등이 저장됩니다. 따라서 파일 혹은 폴더를 통째로 옮기려면 .flow와
.flowdata를 함께 옮겨주어야합니다. 대신, 모든 경로는 .flow에 대한 상대경로로 결정되기에 위치 변경은 매우 자유롭습니다.                  
                  
3. **Flow 열기**                  
만약 기존 Flow를 열어야 한다면 Open 버튼을 눌러서 .flow파일을 열 수 있습니다. .flow 파일의 정보를 바탕으로 .flowdata를 탐색하여 자동으로 Flow
데이터를 로딩합니다.                  
                  
5. **변경 내역 확인하기**                        
Change Log 창에는 (메인 화면의 우측 창) 추적 중인 파일 혹은 폴더의 변경
사항을 표시해줍니다. 상대 경로와 함께 Added, Deleted, Modified 정보가
표시됩니다. History 별 기록된 Metadata와 현재 Metadata 중 파일 크기와
최종 수정 시간을 대조하여 변경 내역을 추적합니다. Refresh 버튼을 누르면
실시간으로 Chnage Log를 작성하여 화면에 보여줍니다.                  
                  
7. **History 관리하기**                  
변경 사항이 있는 경우에만 History를 작성할 수 있습니다. Save Progress 버튼을 누르면, 현재 파일 혹은 폴더의 작업 상황을 History로 저장합니다. History
에는 필수적으로 Title이 포함되며, 간단한 Description을 추가할 수 있습니다. 특정 Histroy를 삭제하려면 더블 클릭 후 Delete 버튼을 누르면 Histroy가
삭제되며, 특정 Histroy 상황으로 돌아가려면 더블 클릭 후 Revert 버튼을 눌러서 되돌릴 수 있습니다. (단, 되돌리면 되돌린 값이 새로운 History로 자동 저장
되기에 기존 History가 삭제되지 않습니다. 하지만 Revert를 진행하면 저장하지 않은 수정 사항은 삭제되기에 주의해야 합니다.) History는 압축한 두 데이터를
xor연산 시켜서 차이 값을 구하고, 이를 압축하여 저장 하므로 매우 작은 크기로 변경 사항이 기록됩니다. (평균 압축률 : 80% 이상)                  
                  
9. **Branch 관리하기**                  
Flow를 생성하면 자동으로 Main Branch가 생성됩니다. 만약 새로운 시도를 위해 새로운 작업 환경이 필요하다면 Sub Branch를 만들어 작업할 수 있습니다.
또한, 특정 Branch의 이름을 변경하거나, 삭제하는 것 역시 가능합니다. Branch에 대한 작업은 Branch를 더블 클릭하면 뜨는 창에서 수행할 수 있으며,
Branch를 클릭하면 Branch가 변경됩니다. Branch가 변경되면 작업 환경이 자동으로 변경됩니다. (기존 수정 데이터를 유지되니 걱정하지 않으셔도 됩니다.)
Branch를 합치기 위해서는 Merge 혹은 Replace를 활용할 수 있습니다. Replace는 Origin Branch의 최종 결과를 Target Branch에 덮어 씌우고
새로운 History를 제작함으로써 Branch를 합칩니다. Merge는 Origin Branch와 Target Branch 데이터를 비교하여 파일 단위로 둘 중 어느 파일을
활용할지, 혹은 아예 넣지 말지 선택하여 좀 더 유연하게 Branch를 합칠 수 있습니다. Merge와 Replace 모두 합친 결과는 Target Branch에 새로운 Histroy
형태로 기록됩니다.                  

## DETAILS 
> :: 개발 세부 디테일

파일을 관리하는 프로그램은 C++코드로 이루어져 있고, 이에 반해 GUI는 PyQt6을 사용하여 모두 Python으로 이루어져 있습니다. 여기서 한가지 문제점에 봉착하는데,
C++과 Python의 바인딩은 두 언어의 기본 구조마져 다른 관계로 복잡합니다. 이에 대한 해결책으로 프로그램이 작동하는 방식을 조금 수정하게 되었는데, 파일 관리
프로그램은 C++로 빌드하되, 터미널에서 지정된 명령어를 사용하여 조작할 수 있게 하고, Python GUI는 터미널에 popen을 사용해 명령을 실행하도록 제작했습니다.

## CONCLUSION 
> :: 기대 효과 및 느낀점

Flow는 사용자 친화적으로 파일의 버전 관리를 매우 편리하게 만들어줍니다. 이 프로그램이 상용화 된다면 파일 혹은 폴더의 수정 내역을 기록하고, 되돌리고, 쉽게 작업
환경을 오갈수 있기에 모든 분야에서 작업의 능률 향상을 기대할 수 있으리라 기대됩니다. 특히 그래픽 작업 혹은 영상 작업 과정에서 새로운 시도를 할 때 번거롭게 작업
환경을 마련하고, 이를 합치는 작업이 필요 없어질 것이며, 행정 업무에서 문서를 작성할 때 훨씬 유동적이고 효율적으로 문서 작업이 가능할 것 입니다.
이번 프로젝트를 통해 저희가 느낀 사실은 바로 프로그램은 사용자와 유기적인 관계를 이루는 존재라는 점입니다. 프로그램이 어떤 기능을 지원하고, 성능이 좋은 것 보다도,
범용적인 도구를 사용자 친화적이고 직관적인 방법으로 제공하는 것이 더 어렵고, 가치있는 것이라는 점을 느꼈습니다. 기술이 빠르게 발전하는 사회에서, 사용자가 친해질
수 있는, 대중화가 가능한 프로그램의 가치를 느꼈습니다.
   
- - -
      
### License : GPL 2.0

### Copyright (C) 2023 CLiF and Name95014

This program was developed with PyQt
