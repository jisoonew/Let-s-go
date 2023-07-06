<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>MAIN HOME</title>
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
</head>


<!--MAIN HOME UI-->

<body onload="initTmap()">

  <nav class="navbar bg-light fixed-top border-bottom border-dark">
    <div class="container-fluid">
      <img src="resources/img/logo.png" alt="Logo" width="120" height="50">
      <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
        aria-controls="offcanvasNavbar">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
        <div class="offcanvas-header">
          <h5 class="offcanvas-title" id="offcanvasNavbarLabel">Offcanvas</h5>
          <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body">
          <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
            <li class="nav-item">
              <a class="nav-link active" aria-current="page" href="#">Home</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Link</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                aria-expanded="false">
                Dropdown
              </a>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="#">Action</a></li>
                <li><a class="dropdown-item" href="#">Another action</a></li>
                <li>
                  <hr class="dropdown-divider">
                </li>
                <li><a class="dropdown-item" href="#">Something else here</a></li>
              </ul>
            </li>
          </ul>
          <form class="d-flex mt-3" role="search">
            <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success" type="submit">Search</button>
          </form>
        </div>
      </div>
    </div>
  </nav>

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

        <div class="card-body" style="height: 50px;">
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