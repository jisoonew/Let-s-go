<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>가보자고</title>
  <link href="resources/css/main.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">


  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
    integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
    crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"
    integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA=="
    crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"
    integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
    
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
</head>


<!--MAIN HOME UI-->

<body onload="initTmap()">

  <nav class="navbar bg-light fixed-top border-bottom border-dark">
    <div class="container-fluid">
      <img src="resources/img/logo.png" alt="Logo" width="120" height="50">
      <button type="button" class="btn" data-bs-toggle="offcanvas" data-bs-target="#myOffcanvas"><span class="navbar-toggler-icon"></span></button>
      </div>
  </nav>
  
      <div class="offcanvas offcanvas-end" tabindex="-1" id="myOffcanvas" aria-labelledby="offcanvasNavbarLabel">
        <div class="offcanvas-header">
          <h5 class="offcanvas-title" id="offcanvasNavbarLabel">우지은님</h5>
          <button type="button" data-bs-dismiss="offcanvas" id="logout">로그아웃</button>
        </div>
        <hr>
        <div class="offcanvas-body">
          <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
            <li class="nav-item">
              <button class="nav-link active" type="button" aria-current="page" id="Favorites">즐겨찾기</button>
            </li>
            <li class="nav-item">
              <a class="nav-link active" type="button" aria-current="page" id="History">스케줄 History</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" type="button" aria-current="page" id="Journal">여행 일지</a>
            </li>
          </ul>
        </div>
      </div>
      
      <!-- 즐겨찾기 -->
              <div class="offcanvas offcanvas-end" tabindex="-1" id="Offcanvas_Favorites" aria-labelledby="offcanvasNavbarLabel">
              <div class="offcanvas-header">
<button type="button" class="btn btn-outline-primary" data-bs-dismiss="offcanvas" type="button"><i class="bi bi-arrow-left"></i></button> <!-- 뒤로가기 -->
<button type="button" class="btn btn-outline-primary" ><i class="bi bi-trash-fill"></i>삭제</button> <!-- 즐겨찾기 삭제 -->
</div>
        <div class="offcanvas-body">
          <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
            <li class="nav-item">
              <button class="nav-link active" type="button" aria-current="page" id="Favorites">경민대학교</button>
              <button type="button" id="Favorites_cancel"><i class="bi bi-x"></i></button> <!-- 즐겨찾기 삭제 -->
            </li>
            <li class="nav-item">
              <button class="nav-link active" type="button" aria-current="page" id="Favorites">어린이대공원 후문</button>
                            <button type="button" id="Favorites_cancel"><i class="bi bi-x"></i></button> <!-- 즐겨찾기 삭제 -->
            </li>
            <li class="nav-item">
              <button class="nav-link active" type="button" aria-current="page" id="Favorites">부산역</button>
                            <button type="button" id="Favorites_cancel"><i class="bi bi-x"></i></button> <!-- 즐겨찾기 삭제 -->
            </li>
          </ul>
        </div>
      </div>
      
      
            <!-- 스케줄 History -->
              <div class="offcanvas offcanvas-end" tabindex="-1" id="Offcanvas_History" aria-labelledby="offcanvasNavbarLabel">
              <div class="offcanvas-header">
<button type="button" class="btn btn-outline-primary" data-bs-dismiss="offcanvas" type="button"><i class="bi bi-arrow-left"></i></button> <!-- 뒤로가기 -->
<button type="button" class="btn btn-outline-primary" title="스케줄 추가하기"><i class="bi bi-plus-lg"></i></button> <!-- 스케줄 History 추가 -->
</div>
        <div class="offcanvas-body">
          <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
            <li class="nav-item">
              <button class="nav-link active" type="button" aria-current="page" id="History">부산 여행</button>
              <button type="button" id="History_cancel"><i class="bi bi-x"></i></button> <!-- 스케줄 History 삭제 -->
            </li>
            <li class="nav-item">
              <button class="nav-link active" type="button" aria-current="page" id="History">일본 후쿠오카</button>
                            <button type="button" id="History_cancel"><i class="bi bi-x"></i></button> <!-- 스케줄 History 삭제 -->
            </li>
            <li class="nav-item">
              <button class="nav-link active" type="button" aria-current="page" id="History">제주도 여행</button>
                            <button type="button" id="History_cancel"><i class="bi bi-x"></i></button> <!-- 스케줄 History 삭제 -->
            </li>
          </ul>
        </div>
      </div>
      
      
                  <!-- 여행 일지 -->
              <div class="offcanvas offcanvas-end" tabindex="-1" id="Offcanvas_Journal" aria-labelledby="offcanvasNavbarLabel">
              <div class="offcanvas-header">
<button type="button" class="btn btn-outline-primary" data-bs-dismiss="offcanvas" type="button"><i class="bi bi-arrow-left"></i></button> <!-- 뒤로가기 -->
<button type="button" class="btn btn-outline-primary" title="여행 일지 추가하기"><i class="bi bi-plus-lg"></i></button> <!-- 여행 일지 추가 -->
</div>
        <div class="offcanvas-body">
          <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
            <li class="nav-item">
              <button class="nav-link active" type="button" aria-current="page" id="Journal">부산 여행 일지</button>
  <input class="form-check-input" type="checkbox" value="" id="Journal_Check">
            </li>
            <li class="nav-item">
              <button class="nav-link active" type="button" aria-current="page" id="Journal">일본 후쿠오카 일지</button>
  <input class="form-check-input" type="checkbox" value="" id="Journal_Check">
            </li>
            <li class="nav-item">
              <button class="nav-link active" type="button" aria-current="page" id="Journal">제주도 여행 일지</button>
  <input class="form-check-input" type="checkbox" value="" id="Journal_Check">
            </li>
          </ul>
        </div>
        
        <button type="button" class="btn btn-outline-primary" id="Journal_btn">확인</button>
      </div>
      
      


  

  <div class="container-fluid-table">
    <div class="row date_container" style="margin-left: 0px;">
      <!-- 여기에 날짜 넣기 -->
      <div class="col column date">5.15</div>
      <div class="col column date">5.16</div>
      <div class="col column date">5.17</div>
      <div class="col column date">5.18</div>
      <div class="col column date">5.19</div>
      <div class="col column date">5.20</div>
      <div class="col column date">5.21</div>
    </div>

    <div class="table-row">
      <!-- 세로 리스트 박스 -->
      <div class="column table-box1">
        <!-- 각 카드 리스트 박스 -->
        <div class="card text-white bg-primary">
          <div class="card-title">
            <div class="title">Header</div>
            <div class="deleteBox">x</div>
          </div>
        </div>
        <!-- 각 카드 리스트 박스 -->
        <div class="card text-white bg-primary">
          <div class="card-title">
            <div class="title">Header</div>
            <div class="deleteBox">x</div>
          </div>
        </div>

        <label class="createBox1"> [추가]</label>
      </div>

      <!-- 세로 리스트 박스 -->
      <div class="column table-box2">
        <div class="card text-white bg-success">
          <div class="card-title">
            <div class="title">Header</div>
            <div class="deleteBox">x</div>
          </div>
        </div>
        <label class="createBox2"> [추가]</label>
      </div>

      <!-- 세로 리스트 박스 -->
      <div class="column table-box3">
        <!-- 각 카드 리스트 박스 -->
        <div class="card text-white bg-danger">
          <div class="card-title">
            <div class="title">Header</div>
            <div class="deleteBox">x</div>
          </div>
        </div>
        <!-- 각 카드 리스트 박스 -->
        <div class="card text-white bg-warning">
          <div class="card-title">
            <div class="title">Header</div>
            <div class="deleteBox">x</div>
          </div>
        </div>
        <!-- 각 카드 리스트 박스 -->
        <div class="card text-white bg-info">
          <div class="card-title">
            <div class="title">Header</div>
            <div class="deleteBox">x</div>
          </div>
        </div>
        <!-- 각 카드 리스트 박스 -->
        <div class="card bg-danger">
          <div class="card-title">
            <div class="title">Header</div>
            <div class="deleteBox">x</div>
          </div>
        </div>

        <!-- 각 카드 리스트 박스 -->
        <div class="card text-white bg-primary">
          <div class="card-title">
            <div class="title">Header</div>
            <div class="deleteBox">x</div>
          </div>
        </div>

        <label class="createBox3"> [추가]</label>
      </div>

      <!-- 세로 리스트 박스 -->
      <div class="column table-box4">
        <!-- 각 카드 리스트 박스 -->
        <div class="card text-white bg-primary">
          <div class="card-title">
            <div class="title">Header</div>
            <div class="deleteBox">x</div>
          </div>
        </div>
        <!-- 각 카드 리스트 박스 -->
        <div class="card text-white bg-info">
          <div class="card-title">
            <div class="title">Header</div>
            <div class="deleteBox">x</div>
          </div>
        </div>

        <label class="createBox4"> [추가]</label>
      </div>

      <!-- 세로 리스트 박스 -->
      <div class="column table-box5">
        <!-- 각 카드 리스트 박스 -->
        <div class="card text-white bg-primary">
          <div class="card-title">
            <div class="title">Header</div>
            <div class="deleteBox">x</div>
          </div>
        </div>
        <!-- 각 카드 리스트 박스 -->
        <div class="card text-white bg-info">
          <div class="card-title">
            <div class="title">Header</div>
            <div class="deleteBox">x</div>
          </div>
        </div>

        <label class="createBox5"> [추가]</label>
      </div>

      <!-- 세로 리스트 박스 -->
      <div class="column table-box6">
        <!-- 각 카드 리스트 박스 -->
        <div class="card text-white bg-primary">
          <div class="card-title">
            <div class="title">Header</div>
            <div class="deleteBox">x</div>
          </div>
        </div>
        <!-- 각 카드 리스트 박스 -->
        <div class="card text-white bg-info">
          <div class="card-title">
            <div class="title">Header</div>
            <div class="deleteBox">x</div>
          </div>
        </div>

        <label class="createBox6"> [추가]</label>
      </div>

      <!-- 세로 리스트 박스 -->
      <div class="column table-box7">
        <!-- 각 카드 리스트 박스 -->
        <div class="card text-white bg-primary">
          <div class="card-title">
            <div class="title">Header</div>
            <div class="deleteBox">x</div>
          </div>
        </div>
        <!-- 각 카드 리스트 박스 -->
        <div class="card text-white bg-info">
          <div class="card-title">
            <div class="title">Header</div>
            <div class="deleteBox">x</div>
          </div>
        </div>

        <label class="createBox7"> [추가]</label>
      </div>
    </div>
  </div>


  <div id="map_div_container">
<div id="map_div"></div>
  </div>

  <div class="memo_padding">
    <div class="memo_write">
      <div class="card" style="width: 65.5rem;">
        <div class="card-body" style="height: 50px;">
          <p class="card-text" id="memo_title">제목 : </p>
          <input type="text" id="memo_text" placeholder="title">
        </div>

        <div class="card-body" style="height: 50px;">
          <p class="card-text" id="memo_date">날짜 : </p>
          <input class="datepicker" id="datepicker" placeholder="date">
          <script>
            $(function () {
              $('.datepicker').datepicker();
            })
          </script>
        </div>

        <div class="card-body" style="height:50px;">
          <p class="card-text" id="memo_time_text">시간 : </p>
          <p><input type="time" id="memo_time"></p>
        </div>

        <div class="card-body" style="height: 50px;">
          <p class="card-text" id="memo_place_text">장소 : </p>
          <input type="text" id="memo_place" placeholder="place">
        </div>

        <div class="card-body" style="height: 230px;">
          <textarea id="content" name="content" rows="8" cols="132" placeholder="memo"></textarea>
        </div>

        <div class="card-body" style="height: 230px;">
          <textarea id="content" name="content" rows="8" cols="132" placeholder="review"></textarea>
        </div>

      </div>
    </div>
  </div>

  <div class="container_1"></div>

  <div class="advertisement">광고</div>




  <!-- 스크립트-->
  <!--이 js링크가 제일 핵심인듯-->
  <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>


  <!--아래 2개의 스크립트는 무엇을 위한것? 이거 없어도 돌아감-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
  <!-- 부트스트랩 3.x를 사용한다. -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

  <!--계획표 스크립트-->
  <script>
    $(function () {
      $(".column").sortable({
        // 드래그 앤 드롭 단위 css 선택자
        connectWith: ".column",
        // 움직이는 css 선택자
        handle: ".title",
        // 움직이지 못하는 css 선택자
        cancel: ".no-move",
        // 이동하려는 location에 추가 되는 클래스
        placeholder: "card-placeholder"
      });
      // 해당 클래스 하위의 텍스트 드래그를 막는다.
      $(".column .card").disableSelection();
    });
  </script>

  <script type="text/javascript">
    // 삭제 라벨
    $(document).on('click', ".deleteBox", function () {
      $(this).parent().parent().remove();
    });

    // 추가 라벨1
    $(document).on('click', '.createBox1', function () {
      innerHtml = ""
      innerHtml += '<div class="card text-white bg-info" style="background-color: skyblue;">
    	   <div class="card-title">
			<div class="title">Header</div>
			<div class="deleteBox">x</div>
		</div>
           </div>'
      $(".table-box1").append(innerHtml);
    });

    // 추가 라벨2
    $(document).on('click', '.createBox2', function () {
      innerHtml = ""
      innerHtml += '<div class="card text-white bg-info" style="background-color: skyblue;">
    	   <div class="card-title">
			<div class="title">Header</div>
			<div class="deleteBox">x</div>
		</div>
           </div>'
      $(".table-box2").append(innerHtml);
    });

    // 추가 라벨3
    $(document).on('click', '.createBox3', function () {
      innerHtml = ""
      innerHtml += '<div class="card text-white bg-info" style="background-color: skyblue;">
    	   <div class="card-title">
			<div class="title">Header</div>
			<div class="deleteBox">x</div>
		</div>
           </div>'
      $(".table-box3").append(innerHtml);
    });

    // 추가 라벨4
    $(document).on('click', '.createBox4', function () {
      innerHtml = ""
      innerHtml += '<div class="card text-white bg-info" style="background-color: skyblue;">
    	   <div class="card-title">
			<div class="title">Header</div>
			<div class="deleteBox">x</div>
		</div>
           </div>'
      $(".table-box4").append(innerHtml);
    });

    // 추가 라벨5
    $(document).on('click', '.createBox5', function () {
      innerHtml = ""
      innerHtml += '<div class="card text-white bg-info" style="background-color: skyblue;">
    	   <div class="card-title">
			<div class="title">Header</div>
			<div class="deleteBox">x</div>
		</div>
           </div>'
      $(".table-box5").append(innerHtml);
    });

    // 추가 라벨6
    $(document).on('click', '.createBox6', function () {
      innerHtml = ""
      innerHtml += '<div class="card text-white bg-info" style="background-color: skyblue;">
    	   <div class="card-title">
			<div class="title">Header</div>
			<div class="deleteBox">x</div>
		</div>
           </div>'
      $(".table-box6").append(innerHtml);
    });

    // 추가 라벨7
    $(document).on('click', '.createBox7', function () {
      innerHtml = ""
      innerHtml += '<div class="card text-white bg-info" style="background-color: skyblue;">
    	   <div class="card-title">
			<div class="title">Header</div>
			<div class="deleteBox">x</div>
		</div>
           </div>'
      $(".table-box7").append(innerHtml);
    });
  </script>


  <!--TMAP 호출-->
  <script src="https://apis.openapi.sk.com/tmap/vectorjs?version=1&appKey=5A53DsGwddaFFyXqIjgmU8VGi3Vsx3Yb8DYy3kT7">
  </script>
  
  <script>
         var map = new Tmapv2.Map("map_div", { // 지도가 생성될 div
            center: new Tmapv2.LatLng(37.57560320760612, 126.99800491333039),    // 지도의 중심좌표
            width : "750px", // 지도의 넓이
            height : "750px", // 지도의 높이
            zoom : 12, // 지도의 줌레벨
            httpsMode: true,    // https모드 설정
        });
        
        // 마커 생성
        var marker = new Tmapv2.Marker({
            position: new Tmapv2.LatLng(37.570028, 126.986072), //Marker의 중심좌표 설정.
            draggable: true, //Marker의 드래그 가능 여부.
            map: map //Marker가 표시될 Map 설정..
        });
        
        
        // 팝업 스타일 1
        var infoWindowContent = '
            <div class="_tmap_preview_popup_1">
                <div class="_tmap_preview_popup_image_s">
                    <img src="https://tmapapi.sktelecom.com/resources/images/sample/img-skt.png" alt="">
                </div>
                <div class="_tmap_preview_popup_info">
                    <div class="_tmap_preview_popup_title">티맵 모빌리티</div>
                    <div class="_tmap_preview_popup_address">서울 중구 삼일대로 343 (우)04538</div>
                    <div class="_tmap_preview_popup_address">(지번) 저동1가 114</div>
                </div>
            </div>
        ';
        
        //Popup 객체 생성.
        var infoWindow = new Tmapv2.InfoWindow({
            position: new Tmapv2.LatLng(37.570028, 126.986072), //Popup 이 표출될 맵 좌표
            content: infoWindowContent, //Popup 표시될 text
            border:'0px solid #FF0000', //Popup의 테두리 border 설정.
            background: false,
            type: 2, //Popup의 type 설정.
            map: map //Popup이 표시될 맵 객체
        });
        
        // GeoLocation으로 마커 표시하기
        function MarkerGeoLocation() {
            // HTML5의 geolocation으로 사용할 수 있는지 확인합니다      
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                    function(position) {
                        // 기존 마커 삭제
                        marker.setMap(null);
                        
                        var lat = position.coords.latitude;
                        var lon = position.coords.longitude;

                        //팝업 생성
                        var content = "<div class='m-pop' style='display: flex; font-size: 18px; box-shadow: 5px 5px 5px #00000040; border-radius: 10px; width : 100px; height:50px; background-color: #FFFFFF; align-items: center; padding: 10px; justify-content: center;'>"+
                            "현재위치"+
                            "</div>";

                        marker = new Tmapv2.Marker({
                            position : new Tmapv2.LatLng(lat,lon),
                            draggable: true, //Marker의 드래그 가능 여부.
                            map : map
                        });

                        new Tmapv2.InfoWindow({
                            position : new Tmapv2.LatLng(lat,lon),
                            content : content,
                            type : 2,
                            map : map
                        });
                        map.setCenter(new Tmapv2.LatLng(lat,lon));
                        map.setZoom(15);
                    });
            }
        }
        
        //Marker에 클릭이벤트 등록.
        marker.addListener("click", function(evt) {
            alert('마커를 클릭했습니다!');
        });
        
        //Marker에 마우스가 마커 영역에 들어왔을때 이벤트 등록.
        marker.addListener("mouseenter", function(evt) {
            console.log('마커에 mouseover 이벤트가 발생했습니다!');
        });
        
        //Marker에 마우스가 마커를 벗어났을때 이벤트 등록.
        marker.addListener("mouseleave", function(evt) {
            console.log('마커에 mouseout 이벤트가 발생했습니다!');
        });
        
        //Marker draggable: true일때, 마커가 움직일때 이벤트 등록
        marker.addListener("drag", function (evt) {
            console.log('마커에 dragstart 이벤트가 발생했습니다! ' + evt.latLng);
        });
        
        //Marker draggable: true일때, 마커의 움직임이 끝날때 이벤트 등록
        marker.addListener("dragend", function (evt) {
            console.log('마커에 dragend 이벤트가 발생했습니다! ' + evt.latLng);
        });

        // 도형 그리기 공통함수 
        var drawingObject = null;
        function getDrawingObject() {
            if (drawingObject == null) {
                // 도형을 그리는 객체 생성
                drawingObject = new Tmapv2.extension.Drawing(
                    {
                        map:map, // 지도 객체
                        strokeWeight: 3, // 테두리 두께
                        strokeColor:"#FF4444", // 테두리 색상
                        strokeOpacity: 1, // 테두리 투명도
                        fillColor:"#FC7B1E", // 도형 내부 색상
                        fillOpacity:0.5, // 도형 내부 투명도
                    }
                );
            }
            // 객체 반환
            return drawingObject;
        }
        
        // 도형 객체의 원을 그리는 함수
        getDrawingObject().drawCircle();
        
        // (장소API) 주소 찾기
        map.addListener("click", function onClick(evt) {
            var mapLatLng = evt.latLng;

            var markerPosition = new Tmapv2.LatLng(
                    mapLatLng._lat, mapLatLng._lng);
            //마커 올리기
            marker1 = new Tmapv2.Marker({
                position : markerPosition,
                icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_p.png",
                iconSize : new Tmapv2.Size(24, 38),
                map : map
            });

            var lon = mapLatLng._lng;
            var lat = mapLatLng._lat;
           
            var optionObj = {
                coordType: "WGS84GEO",       //응답좌표 타입 옵션 설정 입니다.
                addressType: "A10"           //주소타입 옵션 설정 입니다.
            };
            var params = {
                onComplete:function(result) { //데이터 로드가 성공적으로 완료 되었을때 실행하는 함수 입니다.
                    var arrResult = result._responseData.addressInfo;

                    var fullAddress = arrResult.fullAddress.split(",");
                    var newRoadAddr = fullAddress[2];
                    var jibunAddr = fullAddress[1];
                    if (arrResult.buildingName != '') {//빌딩명만 존재하는 경우
                        jibunAddr += (' ' + arrResult.buildingName);
                    }

                    result = "새주소 : " + newRoadAddr;
                    result += "지번주소 : " + jibunAddr;
                    result += "좌표(WSG84) : " + lat + ", " + lon;
                    console.log(result);
                },      
                onProgress:function() {},   //데이터 로드 중에 실행하는 함수 입니다.
                onError:function() {        //데이터 로드가 실패했을때 실행하는 함수 입니다.
                    alert("onError");
                }             
            };
            tData.getAddressFromGeoJson(lat, lon, optionObj, params);
        });

        // (장소API) 통합 검색 함수
        function searchPois() {
            var searchKeyword = $("#searchAddress").val();

            var optionObj = {
                resCoordType : "WGS84GEO",
                reqCoordType : "WGS84GEO",
                count: 10
            };

            var params = {
                onComplete: function(result) {
                    // 데이터 로드가 성공적으로 완료되었을 때 발생하는 이벤트입니다.
                    var resultpoisData = result._responseData.searchPoiInfo.pois.poi;

                    var innerHtml ="";    // Search Reulsts 결과값 노출 위한 변수
                    var positionBounds = new Tmapv2.LatLngBounds();        //맵에 결과물 확인 하기 위한 LatLngBounds객체 생성
                    
                    for(var k in resultpoisData){
                        var name = resultpoisData[k].name;
                        
                        var lat = Number(resultpoisData[k].noorLat);
                        var lon = Number(resultpoisData[k].noorLon);
                        
                        var frontLat = Number(resultpoisData[k].frontLat);
                        var frontLon = Number(resultpoisData[k].frontLon);

                        var markerPosition = new Tmapv2.LatLng(lat, lon);
                        
                        var fullAddressRoad = resultpoisData[k].newAddressList.newAddress[0].fullAddressRoad;
                        
                        var marker2 = new Tmapv2.Marker({
                            position : markerPosition,
                            icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_" + k + ".png",
                            iconSize : new Tmapv2.Size(24, 38),
                            title : name,
                            map:map
                        });
                        
                        innerHtml += "<li><img src='http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_" + k + ".png' style='vertical-align:middle;'/><span>"+name+
                            "</span><br><span>"+fullAddressRoad+
                            "</span><br><span>중심점: "+lat+","+lon+
                            "</span><br><span>입구점: "+frontLat+","+frontLon+
                            "</span></li>"+
                        
                        markerArr.push(marker2);
                        positionBounds.extend(markerPosition);    // LatLngBounds의 객체 확장
                    }
                    innerHtml = "<ul>"+innerHtml+"</ul>";
                    $("#apiResult").html(innerHtml);    //searchResult 결과값 노출
                    map.panToBounds(positionBounds);    // 확장된 bounds의 중심으로 이동시키기
                    map.zoomOut();
                },
                onProgress: function() {},
                onError: function(){}
            }
            tData.getPOIDataFromSearchJson(searchKeyword, optionObj, params);
        }    

        // 직선거리 안내
        function measureDistance() {
            measureDistanceObject = new Tmapv2.extension.MeasureDistance({
                map: map
            });
        }

        // 반경 안내
        function measureRadius() {
            measureRadiusObject = new Tmapv2.extension.MeasureRadius({
                map: map
            });
        }

        // 사각형 지도 
        function squareMap() {
            var bounds = new Tmapv2.base.LatLngBounds();
            var array = [];
            for (var i = 0; i < 1000; i++) {
                var object = {};
                object.lng = 126.977028 + Math.random() / 40;
                object.lat = 37.565354 + Math.random() / 40;
                object.value = Math.round((Math.random() * 100 % 10));
                array.push(object);
                bounds.extend(new Tmapv2.LatLng(object.lat, object.lng));
            }

            squareMapObject = new Tmapv2.extension.SquareMap({
                map: map,
                strokeOpacity: 0.8,
                fillOpacity: 0.6,
                size: 200,
                values: [10, 20, 30, 40, 50, 60],
                colors: ['#f8fcca', '#ecf8b2', '#91d4b9', '#1e90bf', '#24489d', '#1e2f89'],
                data: {
                    data: array,
                    max: 10
                }
            });
            map.fitBounds(bounds);
        }

        // 교통정보
        function autoTraffic() {
            tData.autoTraffic(map, {"trafficOnOff" : true});
        }
    </script>


<!-- 마이페이지 오프캔버스 -->
<script>
    // 이벤트 리스너 추가
    $(document).ready(function() {
        $('#myOffcanvas').on('shown.bs.offcanvas', function () {
            // 다른 오프캔버스가 나타날 때 실행할 작업을 여기에 작성합니다.
            console.log('Offcanvas is shown.');
        });

        $('#Favorites').click(function() {
            $('#Offcanvas_Favorites').offcanvas('show');
        });
        
        $('#History').click(function() {
            $('#Offcanvas_History').offcanvas('show');
        });
        
        $('#Journal').click(function() {
            $('#Offcanvas_Journal').offcanvas('show');
        });
    });
</script>

<!-- 날짜 선택 -->
  <script type="text/javascript">
    // 페이지가 로딩이 된 후 호출하는 함수입니다.
    function initTmap() {
      // map 생성
      // Tmapv3.Map을 이용하여, 지도가 들어갈 div, 넓이, 높이를 설정합니다.
      var map = new Tmapv3.Map("map_div", { // 지도가 생성될 div
        center: new Tmapv3.LatLng(37.56520450, 126.98702028),
        width: "500px", // 지도의 넓이
        height: "500px", // 지도의 높이
        zoom: 16 // 지도 줌레벨
      });
    }

    $.datepicker.setDefaults({
      dateFormat: 'yy-mm-dd',
      prevText: '이전 달',
      nextText: '다음 달',
      monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
      monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
      dayNames: ['일', '월', '화', '수', '목', '금', '토'],
      dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
      dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
      showMonthAfterYear: true,
      yearSuffix: '년'
    });

    $(function () {
      $('.datepicker').datepicker();
    });
  </script>


  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous">
  </script>
  <script type="text/javascript" src="/path/to/jquery.js"></script>
  <script type="text/javascript" src="/path/to/moment.js"></script>
  <script type="text/javascript" src="/path/to/tempusdominus-bootstrap-4.min.js"></script>



</body>

</html>