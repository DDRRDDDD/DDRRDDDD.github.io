## 코파일럿 코드 작성 지침 (간단화된 버전)

### 기본 원칙
1. 모르면 "모르겠습니다"라고 말한다.  
2. 추측이면 반드시 "추측입니다"라고 표기한다.  
3. 출처 불분명 정보는 "확실하지 않음"으로 표기한다.  
4. 근거가 있으면 함께 제시한다.  
5. 질문이 애매하면 먼저 맥락을 요청한다.  
6. 참고자료가 있으면 간단히 요약한다.

### 주석
- 모든 주석은 한국어로 작성한다.  
- 주석 표시는 `///`를 사용한다.

### JSON 예시 작성 규칙
- 가능한 경우 `fromJson` 매핑을 우선으로 따른다.  
- 매핑 메서드가 없으면 camelCase → snake_case로 변환한다.  
- 날짜/시간은 `DateTime.parse` 사용 흔적이 보이면 ISO 8601 문자열을 사용한다.  
- 중첩 객체는 깊이(depth)를 포함해 작성하고, 해당 타입의 `fromJson`/`toJson`을 확인한다. 파일을 못 찾으면 "추측입니다"라고 표기한다.  
- enum은 `values.byName`을 사용하면 enum 이름 문자열로 표기한다.  
- 컬렉션은 각 요소의 예시를 포함한다.  
- null, 빈 배열, 빈 객체, 불필요 속성은 제외한다.  
- 모든 키는 알파벳 순으로 정렬한다.  
- 문자열은 큰따옴표, 숫자는 따옴표 없이, 불리언은 소문자(true/false).  
- 중첩된 객체/배열은 2칸 들여쓰기, 각 중첩은 새 줄에 시작·종결한다.

### 모델 위치 및 메서드
- 모델 클래스는 `model` 디렉토리에 위치한다.  
- JSON 관련 메서드는 `fromJson`, `toJson`을 사용한다.  
- JSON 파라미터 타입은 `typedef Json`을 따른다(프로젝트 규약).

### 중첩 클래스 확인 지침
- `Nickname.fromJson`, `Interests.fromJsonList`, `UrlImageResource` 등 호출이 보이면 해당 파일을 열어 실제 매핑을 확인할 것.  
- 파일을 열 수 없으면 예시는 "추측입니다"로 표기한다.

### 예시 JSON (`User.fromJson` 기준, 추측 부분 있음)
{
  "birthday": "1995-06-15T00:00:00Z",
  "gender": "male",
  "id": "user-20251001-001",
  "interests": [
    {
      "id": "catan_cat_01",
      "name": "전략"
    },
    {
      "id": "party_cat_01",
      "name": "파티"
    }
  ],
  "mbti": "ENFP",
  "nickname": {
    "created_at": "2025-01-10T12:34:56Z",
    "id": "nick-001",
    "nickname": "John"
  },
  "profile_image_url": "https://example.com/avatars/ym.jpg"
}