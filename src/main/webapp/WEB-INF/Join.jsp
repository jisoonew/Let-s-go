<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!doctype html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>회원가입</title>
  <link rel="stylesheet" href="login.css" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>

<body>

  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-4 mt-4 mb-4 signup-container">
        <h1 class="signup-title text-center">회원가입</h1>
        <form>
          <div class="form-group mt-3">
            <label for="username">아이디</label>
            <input type="text" class="form-control mt-2" id="username" placeholder="아이디를 입력하세요">
          </div>
          <div class="form-group mt-3">
            <label for="email">이메일</label>
            <div class="input-group mt-2">
              <input type="text" class="form-control" placeholder="email을 입력해주세요">
              <span class="input-group-text">@</span>
              <div class="input-group-append">
                <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown"
                  aria-haspopup="true" aria-expanded="false">naver.com</button>
                <div class="dropdown-menu">
                  <a class="dropdown-item" href="#">naver.com</a>
                  <a class="dropdown-item" href="#">gmail.com</a>
                </div>
              </div>
            </div>
          </div>
          <div class="form-group mt-3">
            <label for="email_verification">이메일 인증</label>
            <div class="input-group mt-2">
              <input type="text" class="form-control" id="email_verification" placeholder="인증 코드를 입력하세요">
              <button class="btn btn-primary" class="btn btn-primary">인증</button>
            </div>
          </div>
          <div class="form-group mt-3">
            <label for="password">비밀번호</label>
            <input type="password" class="form-control mt-2" id="password" placeholder="비밀번호를 입력하세요">
          </div>

          <div class="form-group mt-3">
            <label for="password">확인 비밀번호</label>
            <div class="input-group mb-3 mt-2">
              <input type="password" class="form-control" placeholder="비밀번호 확인" aria-label="비밀번호 확인">
              <button class="btn btn-primary" type="button">확인</button>
            </div>
          </div>

          <button type="submit" class="btn btn-primary mt-4 btn-block" style="width: 100%;">회원가입</button>
        </form>
      </div>
    </div>
  </div>
  </div>

  <script>
    // 드롭다운 메뉴의 항목을 클릭했을 때 이벤트 처리
    const dropdownItems = document.querySelectorAll('.dropdown-item');
    const dropdownButton = document.querySelector('.dropdown-toggle');

    dropdownItems.forEach(item => {
      item.addEventListener('click', function () {
        const selectedOption = this.textContent;
        dropdownButton.textContent = selectedOption;
      });
    });
  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous">
  </script>
</body>

</html>
