<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>로그인</title>
  <link rel="stylesheet" href="login.css" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>

<body>

  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-4 mt-4 mb-4">
        <h1 class="text-center">로그인</h1>
        <form>
          <div class="form-group mt-4">
            <label for="id">아이디</label>
            <input type="id" class="form-control mt-2" id="id" placeholder="아이디를 입력하세요">
          </div>
          <div class="form-group mt-4">
            <label for="password">비밀번호</label>
            <input type="password" class="form-control mt-2" id="password" placeholder="비밀번호를 입력하세요">
          </div>

          <div class="row mt-2">
            <div class="col text-left">
              <a class="link-offset-2 link-underline-opacity-0 text-decoration-none" href="#" id="id_link_search">아이디
                찾기</a>
            </div>
            <div class="col text-end">
              <a class="link-offset-2 link-underline-opacity-0 text-decoration-none" href="#" id="pw_link_search">비밀번호
                찾기</a>
            </div>
          </div>

          <button type="submit" class="btn btn-primary mt-4 btn-block" style="width: 100%;">로그인</button>

          <div class="d-flex justify-content-between mt-2">
            <p class="text-left">계정이 없으신가요?</p>
            <p class="text-right"><a class="link-no-underline text-decoration-none" href="#" id="signup_link">회원가입</a>
            </p>
          </div>
        </form>
      </div>
    </div>
  </div>



  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous">
  </script>
</body>

</html>