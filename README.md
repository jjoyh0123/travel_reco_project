# ✈️ 관광지 추천 및 일정 관리 (travel_reco_project)

## 📌 프로젝트 개요
사용자가 원하는 지역의 관광 정보를 탐색하고, 직접 여행 일정을 계획·관리할 수 있도록 구현한 팀 프로젝트입니다.
사용자 간의 일정 및 리뷰 공유, '좋아요'를 통한 인기 콘텐츠 추천 등
여행 계획부터 경험 공유까지 이어지는 전체 과정을 웹 서비스로 구현했습니다.

---

## 👨‍💻 담당 역할 (My Contribution)
- 메인 화면 구현
- 로그인 기능 개발
- 마이페이지 기능 개발
- 1:1 문의하기 기능 구현

---

## 🔧 Tech Stack
- **Language**: Java
- **Web**: JSP / Servlet
- **Database**: MySQL
- **Persistence**: MyBatis
- **Frontend**: HTML, CSS, JavaScript, JSTL
- **Build Tool**: Maven
- **Libraries**:
  - MyBatis 3.5.16
  - MySQL Connector/J 8.0.33
  - Gson 2.11.0
  - Commons FileUpload 1.5

---

## 🏗️ Architecture & Structure
- `pom.xml` → Maven 빌드 및 라이브러리 의존성 관리
- `src/main/java` → Servlet(Controller), DTO, Service, DAO 등 Java 클래스 패키지
- `src/main/resources` → MyBatis Mapper XML 파일 위치
- `src/main/webapp` → JSP(View), CSS, JS 등 웹 리소스 파일 위치
- `Script.sql` → 프로젝트에 사용된 테이블 구조(DDL) 정의

---

## 🖼️ Architecture Diagram
MVC 패턴을 기반으로 사용자의 요청이 Controller → Service → DAO → Database 순으로 전달되어 처리된 후, View를 통해 사용자에게 응답이 전달됩니다.
