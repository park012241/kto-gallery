# KTO Gallery

* [한국관광공사의 관광 사진 정보 API](https://www.data.go.kr/data/15101914/openapi.do)를 이용한 Gallery입니다.

## 직접 실행 하기

1. `.sample.env`파일을 복사하여 `.env` 파일로 저장합니다.
2. `.env` 파일의 Encoded API Key의 값을 발급 받은 API 키로 수정해 줍니다.
3. `flutter pub get`을 사용하여 dependency를 다운로드합니다.
4. `dart run build_runner build`를 실행하여 필요한 파일(Provider, JSON 관련 코드 등)을 생성합니다.
5. `flutter run`을 실행하여 빌드하고 실행합니다.
