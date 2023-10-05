# AppStoreCloneTest

## Technologies

- Swift 5.8.1
- Xcode 14.3.1
- Design Pattern: MVVM

## API
[Apple's iTunes Search API](https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/)

## Features

- [x]  최근 검색어: 검색했던 검색어를 `UserDefaults` 에 10개까지 저장하고 불러온다.
- [x]  앱 검색: 검색어와 관련된 앱 이름을 필터링하여 앱을 검색한다.
- [x]  네트워크: `URLSession` 와 `Combine` 을 이용하고 제네릭하게 구현하여 실시간 검색어를 처리한다.

## Pages

### 1. SearchTabView
입력했던 검색어를 지우고 저장되어있는 최근 검색어를 불러온다.
검색어가 입력되면 관련앱이 필터링되어 리스트로 보여진다.

### 2. SearchResultListView
검색을 누르거나 최근 검색어, 연관 검색어를 터치하면 이동한다.
검색된 앱들의 간단한 정보와 다운로드 버튼, 스크린샷이 보여진다.
하나의 셀을 선택하면 선택된 앱을 `ViewModel` 에 초기화하고 `AppDetailView` 로 화면을 전환한다.

### 3. AppDetailView
ViewModel에서 선택된 앱 정보를 불러온다.
`discription`이 장문이라면 3줄만 표시하고 `더보기` 버튼을 노출한다.
`더보기` 버튼을 누르면 사라지고 모든 `discription`이 표시된다.

## Screenshots
<div>
  <img width="200" src="https://github.com/doyeonjeong/AppStoreCloneTest/assets/108422901/89da378e-6a8f-40f0-8e16-0fc869bb8645">
  <img width="200" src="https://github.com/doyeonjeong/AppStoreCloneTest/assets/108422901/18c4df0e-f6b6-4eeb-9593-8232939f8363">
  <img width="200" src="https://github.com/doyeonjeong/AppStoreCloneTest/assets/108422901/da007335-c10d-4ab5-919a-c1f51c0ac98b">
  <img width="200" src="https://github.com/doyeonjeong/AppStoreCloneTest/assets/108422901/1e4b6c2f-3732-4b2a-96a9-a91addc8e787">
</div>
