<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
          crossorigin="anonymous"></script>
  <script
      src="https://apis.openapi.sk.com/tmap/vectorjs?version=1&appKey=zMJiV7MhBT2LFF24HwQZXC808gWctsd9ydragwu8"></script>
  <style>
      .custom-img {
          width: 40px;
          height: 40px;
          display: block;
          margin: 0 auto;
      }

      .custom-marker {
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          text-align: center;
          font-size: 12px;
          white-space: nowrap;
      }

      body {
          display: flex;
          flex-direction: column;
          align-items: center;
          margin: 0;
      }

      #board_banner {
          background-color: coral;
          border: 1px solid coral;
          margin-bottom: 10px;
          width: 700px;
          text-align: center;
          border-radius: 5px;
          margin-left: 600px;
      }

      #board_banner > a {
          font-size: 25px;
          color: white;
          text-decoration: none;
      }

      #board_search {
          width: 500px;
          margin-left: 700px;
      }

      .search_type {
          text-align: center;
          background-color: white; /* 배경 색상 투명 */
          color: grey;
          font-weight: bold;
          margin-left: -3px;
      }

      .search_type:hover {
          background-color: grey; /* 배경 색상 투명 */
          color: white;
      }

      .loc {
          display: flex;
          width: auto;
          height: 600px;
          flex-direction: column;
          border: 2px solid #f8f9fa;
          border-radius: 15px;
          margin-right: 50px;
          margin-top: 20px;
      }

      .loc_icon {
          display: flex; /* 플렉스 박스 사용 */
          justify-content: center; /* 가로 중앙 정렬 */
          align-items: flex-start; /* 세로 중앙 정렬 */
          width: 150px;
          height: 150px;
          border: 1px solid lightgray;
          border-radius: 8px;
      }

      .loc_icon > a {
          display: block; /* a 태그를 블록 레벨 요소로 변경하여 전체 div를 클릭 가능하게 만듦 */
          text-decoration: none; /* 링크 밑줄 제거 */
          width: 150px; /* a 태그가 loc_icon의 전체 너비를 차지하도록 */
          height: 100%; /* a 태그가 loc_icon의 전체 높이를 차지하도록 */
          color: black;
      }

      .board_plan {
          background: #f8f9fa;
          display: flex;
          margin-top: 5px;
          width: 800px;
          height: 900px;
          border-radius: 15px;
          flex-wrap: wrap; /* 아이템들이 자동으로 줄바꿈되도록 */
      }

      .loc_row {
          width: 450px;
          display: flex;
      }

      .board_item {
          display: flex;
          flex-direction: column;
          text-align: left;
          list-style: none; /* 점 제거 */
          padding: 0;
          width: 400px;
          height: 165px;
          border-radius: 5px;
      }

      .board_img {
          border: 1px solid lightgray;
          width: 150px;
          height: 150px;
          background-color: white;
          border-radius: 25px;
          margin-bottom: 10px;
          margin-right: 10px;
      }

      .board_title {
          display: flex;
          font-weight: bold;
          font-size: 20px;
          text-decoration: none; /* 링크 밑줄 제거 */
          text-align: left;
          color: black;
      }

      .board_content {
          font-size: 15px;
          text-decoration: none; /* 링크 밑줄 제거 */
          color: black;

      }

      .board_total_content {
          height: auto;
          width: auto;
      }

      .board_img {
          border: 1px solid lightgray;
          width: 140px;
          height: 140px;
          background-color: white;
          border-radius: 25px;
          margin-bottom: 10px;
          margin-right: 10px;
      }

      .board_img > img {
          object-fit: cover;
          width: 140px;
          height: 150px;
      }

      .board_img > a {
          list-style: none;
          text-decoration: none;
          display: flex;
          width: 35px;
      }

      .board_review {
          display: flex;
          margin-top: 5px;
      }

      #body {
          display: flex;
          margin-left: 300px;
      }

      .loc_name {
          display: flex;
          text-decoration: none;
          color: grey;
      }

      .transparent-btn {
          display: flex;
          background-color: transparent; /* 배경을 투명하게 */

      }

      .modal_name {
          font-weight: bold;
          font-size: 25px;
          color: black;
      }

      .modal_img {
          border: 1px solid lightgray;
          width: 700px;
          height: 400px;
      }

      .modal_overview {
          font-weight: bold;
          font-size: 25px;
          color: black;
          border: 1px solid grey;

      }

      #img_1 {
          width: 100px;
          height: 100px;
          background-image: url("${pageContext.request.contextPath}/www/1.png");
          background-repeat: no-repeat;
          background-position: center;
          background-size: 100px 100px;
          border-radius: 50%;
          margin-left: 25px;
          margin-top: 5px;
      }

      #img_2, #img_3, #img_4, #img_5, #img_6, #img_7, #img_8, #img_9,
      #img_10, #img_11, #img_12, #img_13, #img_14, #img_15, #img_16,
      #img_17, #img_18 {
          width: 100px;
          height: 100px;
          background-image: url("${pageContext.request.contextPath}/www/icon_area.png");
          margin-left: 25px;
          margin-top: 5px;
          overflow: hidden;
      }

      #img_2 {
          background-position: 0 -0px;
      }

      #img_3 {
          background-position: 0 -100px;
      }

      #img_4 {
          background-position: 0 -200px;
      }

      #img_5 {
          background-position: 0 -300px;
      }

      #img_6 {
          background-position: 0 -400px;
      }

      #img_7 {
          background-position: 0 -500px;
      }

      #img_8 {
          background-position: 0 -600px;
      }

      #img_9 {
          background-position: 0 -700px;
      }

      #img_10 {
          background-position: 0 -800px;
      }

      #img_11 {
          background-position: 0 -900px;
      }

      #img_12 {
          background-position: 0 -1000px;
      }

      #img_13 {
          background-position: 0 -1100px;
      }

      #img_14 {
          background-position: 0 -1200px;
      }

      #img_15 {
          background-position: 0 -1300px;
      }

      #img_16 {
          background-position: 0 -1400px;
      }

      #img_17 {
          background-position: 0 -1500px;
      }

      #img_18 {
          background-position: 0 -1600px;
      }

      .span {
          margin-top: 15px;
          display: block;
          text-align: center; /* 글자가 가운데 정렬되도록 */
          width: 100%; /* span 요소가 loc_icon의 전체 너비를 차지하도록 */
      }

      .modal_img2 {
          width: 100%;
          height: 100%;
      }

      .modal_content {
          font-weight: bold;
          font-size: 25px;
          color: black;
      }

      .api_addr1 {
          text-align: left;
      }

      .body2 {
          height: 1000px;
      }

      .option_button > a > span {
          border: 1px solid #555555;
          background: #bbbbbb;
          width: 60px;
      }

      .option_button > a {
          text-decoration: none;
      }

      #option_button {
          display: flex;
          margin-right: 6px;
          justify-content: flex-end;
      }

      #map_div {
          margin-top: 20px;
          margin-bottom: 20px;
          border: 1px solid grey;
      }

      #paging {
          margin: auto auto 0;
      }
  </style>
  <title>Title</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<article class="content">
  <thead>
  <div id="board_banner">
    <a href="">모든 지역 관광지</a>
  </div>
  </thead>
  <div>
    <div>
      <input type="search" id="board_search" placeholder="검색: 입력하세요.">
      <button onclick="search()">🔍</button>
    </div>
    <div id="option_button">
      <select class="option_button">
        <option class="search_type" hidden>::선택::</option>
        <option class="search_type" data-contentTypeId="">::전체::</option>
        <option class="search_type" data-contentTypeId="12">::관광지::</option>
        <option class="search_type" data-contentTypeId="32">::숙박::</option>
        <option class="search_type" data-contentTypeId="39">::음식::</option>
      </select>
    </div>
    <br/>
  </div>
  <div id="body">
    <div class="loc">
      <div class="loc_row">
        <div class="loc_icon">
          <a href="#" class="area-icon" data-areacode=""> <!-- 서울 -->
            <div id="img_1"></div>
            <span class="span">전국</span>
          </a>
        </div>
        <div class="loc_icon">
          <a href="#" class="area-icon" data-areacode="1"> <!-- 서울 -->
            <div id="img_2"></div>
            <span class="span">서울</span>
          </a>
        </div>
        <div class="loc_icon">
          <a href="#" class="area-icon" data-areacode="2">
            <div id="img_3"></div>
            <span class="span">인천</span>
          </a>
        </div>
      </div>
      <div class="loc_row">
        <div class="loc_icon">
          <a href="#" class="area-icon" data-areacode="3">
            <div id="img_4"></div>
            <span class="span">대전</span>
          </a>
        </div>
        <div class="loc_icon">
          <a href="#" class="area-icon" data-areacode="4">
            <div id="img_5"></div>
            <span class="span">대구</span>
          </a>
        </div>
        <div class="loc_icon">
          <a href="#" class="area-icon" data-areacode="5">
            <div id="img_6"></div>
            <span class="span">광주</span>
          </a>
        </div>
      </div>
      <div class="loc_row">
        <div class="loc_icon">
          <a href="#" class="area-icon" data-areacode="6">
            <div id="img_7"></div>
            <span class="span">경남</span>
          </a>
        </div>

        <div class="loc_icon">
          <a href="#" class="area-icon" data-areacode="7">
            <div id="img_8"></div>
            <span class="span">울산</span>
          </a>
        </div>
        <div class="loc_icon">
          <a href="#" class="area-icon" data-areacode="31">
            <div id="img_9"></div>
            <span class="span">경기</span>
          </a>
        </div>
      </div>
      <div class="loc_row">
        <div class="loc_icon">
          <a href="#" class="area-icon" data-areacode="32">
            <div id="img_10"></div>
            <span class="span">강원</span>
          </a>
        </div>
        <div class="loc_icon">
          <a href="#" class="area-icon" data-areacode="33">
            <div id="img_11"></div>
            <span class="span">충북</span>
          </a>
        </div>
        <div class="loc_icon">
          <a href="#" class="area-icon" data-areacode="34">
            <div id="img_12"></div>
            <span class="span">충남</span>
          </a>
        </div>
      </div>
      <div class="loc_row">
        <div class="loc_icon">
          <a href="#" class="area-icon" data-areacode="35">
            <div id="img_13"></div>
            <span class="span">경북</span>
          </a>
        </div>
        <div class="loc_row">
          <div class="loc_icon">
            <a href="#" class="area-icon" data-areacode="36">
              <div id="img_14"></div>
              <span class="span">경남</span>
            </a>
          </div>
          <div class="loc_icon">
            <a href="#" class="area-icon" data-areacode="37">
              <div id="img_15"></div>
              <span class="span">전북</span>
            </a>
          </div>
        </div>
      </div>
      <div class="loc_row">
        <div class="loc_row">
          <div class="loc_icon">
            <a href="#" class="area-icon" data-areacode="38">
              <div id="img_16"></div>
              <span class="span">전남</span>
            </a>
          </div>
          <div class="loc_icon">
            <a href="#" class="area-icon" data-areacode="39">
              <div id="img_17"></div>
              <span class="span">제주도</span>
            </a>
          </div>
          <div class="loc_icon">
            <a href="#" class="area-icon" data-areacode="8">
              <div id="img_18"></div>
              <span class="span">세종</span>
            </a>
          </div>
        </div>
      </div>
      <!--모달 생김새~~~~~~~~~~~~~~~~~~~~~~~ -->
      <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
           aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl">
          <div class="modal-content">
            <div class="modal-header">
              <h1 class="modal-title fs-5" id="staticBackdropLabel">
                <div>
                </div>
              </h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <div class="modal_name">
              </div>
              <div class="modal_star">
              </div>
              <div class="modal_img">
                <a href=""><img src="" class="modal_img2"></a>
              </div>
              <div id="map_div" style="width: 500px; height: 400px;">
              </div>
              <button type="button" onclick="Directions()" class="btn btn-primary">길찾기</button>
              <hr style="border: 3px solid #555555;">
              <div class="modal_content">
              </div>
              <br>
              <div class="modal_addr1">
              </div>
              <br>
              <div class="modal_tel">
              </div>
              <div class="modal_overview">
              </div>
              <br>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
              <button type="button" class="btn btn-primary" data-bs-dismiss="modal">닫기</button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="board_plan">
      <c:forEach var="api" items="${ar}">
        <div class="board_review" id="board_review">
          <div class="board_item">
            <div class="board_total_content">
              <button type="button"
                      class="btn transparent-btn"
                      data-bs-toggle="modal"
                      data-bs-target="#staticBackdrop"
                      data-contentid="${api.content_id}"
                      data-title="${api.title}"
                      data-img="${api.thumbnail2}"
                      data-addr1="주소: ${api.addr1}"
                      data-tel="전화번호: ${api.tel}"
                      data-mapx="mapx : ${api.mapx}"
                      data-mapy="mapy : ${api.mapy}"

                      data-content="기본정보">
                <br/>
                <div class="board_img">
                  <img src="${api.thumnail}" alt="thumbnail">
                </div>
                <div>
                  <div class="api_title">
                    <a href="" class="board_title">${api.title}</a>
                  </div>
                  <p></p>
                  <div class="api_addr1">
                    <a href="" class="board_content">${api.addr1}</a>
                  </div>
                  <a href="" class="loc_name"></a>
                </div>
              </button>
            </div>
          </div>
        </div>
      </c:forEach>
      <div id="paging">
        <nav aria-label="Page navigation">
          <ul class="pagination justify-content-center">
            <!-- 이전 블록 -->
            <c:if test="${page.startPage > 1}">
              <li class="page-item">
                <a class="page-link"
                   href="Controller?type=local&cPage=${page.startPage-1}&areacode=${param.areacode}&keyword=${param.keyword}">이전</a>
              </li>
            </c:if>

            <!-- 페이지 번호 -->
            <c:forEach begin="${page.startPage}" end="${page.endPage}" var="p">
              <li class="page-item ${p == page.nowPage ? 'active' : ''}">
                <a class="page-link"
                   href="Controller?type=local&cPage=${p}&areacode=${param.areacode}&keyword=${param.keyword}">${p}</a>
              </li>
            </c:forEach>
            <!-- 다음 블록 -->
            <c:if test="${page.endPage < page.totalPage}">
              <li class="page-item">
                <a class="page-link"
                   href="Controller?type=local&cPage=${page.endPage+1}&areacode=${param.areacode}&keyword=${param.keyword}">다음</a>
              </li>
            </c:if>
          </ul>
        </nav>
      </div>
    </div>
  </div>
</article>

</body>

<div class="body2"></div>
<jsp:include page="footer.jsp"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
  function search() {

    const searchValue = document.getElementById("board_search").value.trim();

    if (searchValue.length > 0) {
      const apiUrl = `/Controller?type=local&keyword=` + encodeURIComponent(searchValue);
      window.location.href = apiUrl; // 해당 URL로 이동

    } else {
      alert("검색어를 입력하세요!"); // 검색어 없을 경우 알림창 띄우기
      document.getElementById("board_search").value = "";
    }

  }

  let title;
  let mapx;
  let mapy;

  document.addEventListener("DOMContentLoaded", function () {
    const modal = document.getElementById("staticBackdrop");
    modal.addEventListener("show.bs.modal", function (event) {
      const button = event.relatedTarget; // 모달을 연 버튼
      const addr1 = button.getAttribute("data-addr1");
      const img = button.getAttribute("data-img");
      const content = button.getAttribute("data-content");
      const tel = button.getAttribute("data-tel");
      const contentid = button.getAttribute("data-contentid")

      title = button.getAttribute("data-title");
      mapx = extractNumber(button.getAttribute("data-mapx"));
      mapy = extractNumber(button.getAttribute("data-mapy"));
      console.log(mapx);
      console.log(mapy);

      // 모달 내부 요소 업데이트
      document.querySelector(".modal_name").textContent = title;
      document.querySelector(".modal_img img").src = img;
      document.querySelector(".modal_content").textContent = content;
      document.querySelector(".modal_addr1").textContent = addr1;
      document.querySelector(".modal_tel").textContent = tel;

      let apiUrl = "http://apis.data.go.kr/B551011/KorService1/detailCommon1?" +
          "serviceKey=7O%2BS3FUEPYFub2Ap2u9bYHh%2BsjDTjijIZZEm8c08xQTLQQgv7IehSi5I%2FG1hMPE6x6%2B3A3IzhIztXbdrLMc90A%3D%3D" +
          "&numOfRows=1&pageNo=1&MobileOS=ETC&MobileApp=AppTest" +
          "&contentId=" + contentid + "&overviewYN=Y";
      $.ajax({
        url: apiUrl,
        type: "GET",
        dataType: "xml",
        success: function (data) {
          let overview = $(data).find("overview").text() || "설명 없음";
          document.querySelector(".modal_overview").textContent = overview;
        },
        error: function (xhr, status, error) {
          console.error("Error fetching overview:", error);
          alert("정보를 불러오는 데 실패했습니다.");
        }
      });

    });
  });

  function sendArea() {
    console.log("클릭");
  }

  document.addEventListener("DOMContentLoaded", function () {
    const areaIcons = document.querySelectorAll('.area-icon');

    console.log(areaIcons);  // 아이콘이 제대로 선택됐는지 확인

    areaIcons.forEach(icon => {
      icon.addEventListener('click', function (e) {
        e.preventDefault(); // 기본 동작 방지

        const areaCode = icon.getAttribute('data-areacode');  // data-areacode 속성 값 가져오기
        console.log(areaCode); // 해당 값이 제대로 나오는지 확인

        if (areaCode > 0) {
          // API 요청 URL 에 areacode 파라미터 추가
          const apiUrl = `/Controller?type=local&areacode=` + areaCode;
          // 페이지를 해당 URL로 리다이렉트
          window.location.href = apiUrl;
        } else {
          const apiUrl = `/Controller?type=local`;
          // 페이지를 해당 URL로 리다이렉트
          window.location.href = apiUrl;
        }
      });
    });
  });

  function sendContentId() {
    console.log("클릭");
  }

  document.addEventListener("DOMContentLoaded", function () {
    const searchTypeSelect = document.querySelector(".option_button"); //select 태그에 있는 요소들 다 가져오기.

    searchTypeSelect.addEventListener("change", function () {
      const selectedOption = searchTypeSelect.options[searchTypeSelect.selectedIndex]; // 선택된 옵션 가져오기
      const contentTypeId = selectedOption.getAttribute("data-contentTypeId"); // data-contentTypeId 값 가져오기
      const urlParams = new URLSearchParams(window.location.search); // 현재 URL의 파라미터 가져오기

      if (contentTypeId) {
        // 기존 areacode가 있으면 유지하고, 없으면 추가하지 않음
        const areaCode = urlParams.get("areacode"); // 현재 areacode 값 가져오기

        let apiUrl = `/Controller?type=local`;

        if (areaCode !== "" && contentTypeId !== "") {
          apiUrl += `&areacode=` + areaCode; // 기존 areacode 유지
        }
        apiUrl += `&contentTypeId=` + contentTypeId; // contentTypeId 추가

        console.log("새로운 URL:", apiUrl);
        window.location.href = apiUrl;
      } else {

        let apiUrl = `/Controller?type=local`;
        window.location.href = apiUrl;
        console.error(apirul);
      }
    });
  });

  let map;
  let marker;
  let coordinates = {lat: 37.56520450, lng: 126.98702028, title: '기본 위치'};

  function updateMarker(lat, lng, title) {
    if (marker) {
      marker.setMap(null);
    }
    marker = new Tmapv3.Marker({
      position: new Tmapv3.LatLng(lat, lng),
      iconHTML: '<div class="custom-marker"><img class="custom-img" src="./www/logo.png" alt="로고"><div>' + title + '</div></div>',
      map: map
    });
  }

  function initTmap() {
    if (!map) {
      map = new Tmapv3.Map("map_div", {
        center: new Tmapv3.LatLng(coordinates.lat, coordinates.lng),
        width: "100%",
        height: "400px",
        zoom: 16
      });
    } else {
      map.zoom = 16;
      map.setCenter(new Tmapv3.LatLng(coordinates.lat, coordinates.lng));
    }
  }

  function setCoordinates(lat, lng, title) {
    coordinates = {lat: lat, lng: lng, title: title};
  }

  const modal = document.getElementById('staticBackdrop');
  modal.addEventListener('shown.bs.modal', () => {
    setCoordinates(mapy, mapx, title);
    initTmap();
    updateMarker(coordinates.lat, coordinates.lng, coordinates.title);
  });

  function extractNumber(input) {
    const match = input.match(/\d+\.\d+/);
    return match ? match[0] : null;
  }

  function Directions() {
    // 1. URL 생성
    const url = '/Controller?type=directions&title=' + title + '&mapx=' + mapx + '+&mapy=' + mapy;

    // 2. 새 창에서 URL 열기
    window.open(url, '_blank');
  }
</script>
</html>
