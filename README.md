# Travel DB Table

<details>
    <summary>참고 단위</summary>
    * AI: Auto_Increment ( 자동 증가 )<br/>
    * tinyint: -128 ~ 127<br/>
    * smallint: -32,768 ~ 32,767<br/>
    * mediumint: -823만 ~ 823만<br/>
    * int: -21억 ~ 21억<br/>
    * bigint: -922경 ~ 922경
</details>

### 유저 ( user_table )

| Key | Column | Korean   | Data type    | Etc        |
|:---:|:-------|:---------|:-------------|:-----------|
| PK  | idx    | 고유 식별자   | bigint       | AI         |
|     | email  | 이메일(아이디) | varchar(50)  |            |
|     | nick   | 닉네임      | varchar(50)  |            |
|     | pw     | 비밀번호     | varchar(255) |            |
|     | status | 상태       | tinyint      | 0:정상, 1:탈퇴 |

### 뱃지 ( badge_table )

| Key | Column   | Korean    | Data type    | Etc        |
|:---:|:---------|:----------|:-------------|:-----------|
| PK  | idx      | 고유 식별자    | bigint       | AI         |
| FK  | user_idx | 유저 고유 식별자 | bigint       |            |
|     | type     | 종류        | varchar(20)  |            |
|     | grade    | 등급        | tinyint      | 1/2/3/4/5  |

### 여행계획 - 메인 ( plan_table )

| Key | Column     | Korean    | Data type   | Etc         |
|:---:|:-----------|:----------|:------------|:------------|
| PK  | idx        | 고유 식별자    | bigint      | AI          |
| FK  | user_idx   | 유저 고유 식별자 | bigint      |             |
|     | area_code  | 지역 코드     | tinyint     |             |
|     | title      | 제목        | varchar(30) |             |
|     | start_date | 시작일       | date        |             |
|     | end_date   | 종료일       | date        |             |
|     | status     | 상태        | tinyint     | 0:활성, 1:비활성 |

### 여행계획 - 날짜 ( date_table )

| Key | Column   | Korean         | Data type    | Etc       |
|:---:|:---------|:---------------|:-------------|:----------|
| PK  | idx      | 고유 식별자         | bigint       | AI        |
| FK  | plan_idx | 여행계획-메인 고유 식별자 | bigint       |           |
|     | date     | 날짜             | date         | 당일~최대10일  |
|     | memo     | 메모             | varchar(500) |           |


### 여행계획 - 장소 ( place_table )

| Key | Column           | Korean         | Data type    | Etc               |
|:---:|:-----------------|:---------------|:-------------|:------------------|
| PK  | date_idx         | 여행계획-날짜 고유 식별자 | bigint       |                   |
| PK  | visit_order      | 여행 순서          | tinyint      | 최대 20             |
|     | content_id       | 장소 고유값         | varchar(20)  |                   |
|     | content_type_id  | 장소 구분          | tinyint      | 숙박/식당/관광지 등       |
|     | title            | 장소 이름          | varchar(50)  |                   |
|     | thumbnail        | 대표이미지          | varchar(100) | firstimage2(api)  |
|     | map_x            | 위도             | double       |                   |
|     | map_y            | 경도             | double       |                   |
|     | time             | 시간             | time         |                   |


### 장소 ( 좋아요 ) ( place_like_table )

| Key | Column              | Korean     | Data type    | Etc                  |
|:---:|:--------------------|:-----------|:-------------|:---------------------|
| PK  | content_id          | 장소 고유값     | varchar(20)  | contentid(api)       |
| PK  | user_idx            | 유저 고유 식별자  | bigint       |                      |
|     | area_code           | 지역 코드      | tinyint      | areaCode(api)        |
|     | content_type_id     | 장소 구분      | tinyint      | contenttypeid(api)   |
|     | title               | 장소 이름      | varchar(50)  |                      |
|     | thumbnail           | 대표이미지      | varchar(100) | firstimage2(api)     |
|     | selected_datetime   | 좋아요 누른 시간  | datetime     |                      |
|     | unselected_datetime | 좋아요 해제한 시간 | datetime     | 해제한 시간이 null인 값만 사용  |


### 장소 ( 추천 ) ( place_recommend_table )

| Key | Column     | Korean | Data type   | Etc                  |
|:---:|:-----------|:-------|:------------|:---------------------|
| PK  | content_id | 장소 고유값 | varchar(20) | contentid(api)       |
|     | area_code  | 지역 코드  | tinyint     | areaCode(api)        |
|     | status     | 상태     | tinyint     | 0:활성, 1:비활성          |


### 여행후기 ( journal_table )

| Key | Column   | Korean    | Data type    | Etc                  |
|:---:|:---------|:----------|:-------------|:---------------------|
| PK  | idx      | 고유 식별자    | bigint       | AI                   |
| FK  | plan_idx | 플랜 고유 식별자 | bigint       |                      |
|     | title    | 후기 제목     | varchar(50)  |                      |
|     | subtitle | 후기 요약     | varchar(500) |                      |
|     | hit      | 조회수       | mediumint    |                      |
|     | reg_date | 등록일       | datetime     |                      |
|     | status   | 상태        | tinyint      | 0:활성, 1:비활성          |


### 여행후기 (좋아요) ( journal_like_table )

| Key | Column      | Korean    | Data type | Etc                  |
|:---:|:------------|:----------|:----------|:---------------------|
| PK  | idx         | 고유 식별자    | bigint    |                      |
| FK  | journal_idx | 후기 고유 식별자 | bigint    |                      |
| FK  | user_idx    | 유저 고유 식별자 | bigint    |                      |
|     | status      | 상태        | tinyint   | 0:활성, 1:비활성          |


### 리뷰 ( review_table )

| Key | Column     | Korean | Data type    | Etc              |
|:---:|:-----------|:-------|:-------------|:-----------------|
| PK  | idx        | 고유 식별자 | bigint       | AI               |
| FK  | user_idx   | 유저 고유 식별자 | bigint |                  |
| FK  | content_id | 여행 장소  | varchar(20)  |                  |
|     | rate       | 별점     | tinyint      | scale 0.5, max 5 |
|     | review     | 리뷰 내용  | varchar(500) |                  |
|     | reg_date   | 작성일    | datetime     |                  |
|     | status     | 상태     | tinyint      | 0:활성, 1:비활성      |


### 이미지 ( image_table )

| Key | Column      | Korean     | Data type    | Etc                        |
|:---:|:------------|:-----------|:-------------|:---------------------------|
| PK  | idx         | 고유 식별자     | bigint       | AI                         |
| FK  | journal_idx | 후기 식별자     | bigint       | journal_table 기본키, null 가능 |
| FK  | review_idx  | 리뷰 식별자     | bigint       | review_table 기본키, null 가능  |
| FK | place_idx | 계획-장소 식별자 | bigint       | place_table 기본키            |
|     | type        | 종류         | varchar(10)  | journal / review           |
|     | upload_date | 이미지 업로드 일자 | datetime     |                            |
|     | file_path   | 파일 경로      | varchar(255) |                            |


### 여행후기 (베스트) ( journal_best_table )

| Key | Column      | Korean    | Data type | Etc            |
|:---:|:------------|:----------|:----------|:---------------|
| PK  | idx         | 고유 식별자    | bigint    | AI             |
| FK  | journal_idx | 후기 고유 식별자 | bigint    |                |
|     | tier        | 베스트 티어    | tinyint   | 1/2/3          |
|     | act_date    | 베스트 선정일   | date      |                |
|     | decat_date  | 베스트 해지일   | date      |                |
|     | status      | 상태        | tinyint   | 0:활성, 1:비활성    |


### 공지사항 ( notice_table )

| Key | Column      | Korean  | Data type    | Etc         |
|:---:|:------------|:--------|:-------------|:------------|
| PK  | idx         | 고유 식별자  | bigint       | AI          |
|     | title       | 제목      | varchar(100) |             |
|     | content     | 내용      | text         |             |
|     | reg_date    | 등록일     | datetime     |             |
|     | update_date | 수정일     | datetime     |             |
|     | hit         | 조회수     | mediumint    |             |
|     | status      | 상태      | tinyint      | 0:활성, 1:비활성 |

### 1:1문의 ( support_table )

| Key | Column   | Korean    | Data type     | Etc               |
|:---:|:---------|:----------|:--------------|:------------------|
| PK  | idx      | 고유 식별자    | bigint        | AI                |
| FK  | user_idx | 유저 고유 식별자 |               |
|     | title    | 제목        | varchar(100)  |                   |
|     | content  | 내용        | varchar(5000) |                   |
|     | reg_date | 등록일       | datetime      |                   |
|     | type     | 문의종류      | varchar(20)   |                   |
|     | status   | 상태        | tinyint       | 0:미확인, 1:확인, 2:삭제 |

### 이벤트 이미지 ( event_image_table )

| Key | Column      | Korean | Data type    | Etc |
|:---:|:------------|:-------|:-------------|:----|
| PK  | idx         | 고유 식별자 | bigint       |     |
|     | upload_date | 등록 일시  | datetime     |     |
|     | file_path   | 파일 경로  | varchar(255) |     |

### FAQ ( faq_table )

| Key | Column   | Korean | Data type    | Etc        |
|:---:|:---------|:-------|:-------------|:-----------|
| PK  | idx      | 고유 식별자 | bigint       | AI         |
|     | title    | 제목     | varchar(250) |            |
|     | content  | 내용     | text         |            |
|     | reg_date | 등록일시   | reg_date     |            |
|     | status   | 상태     | tinyint      | 0:정상, 1:삭제 |
