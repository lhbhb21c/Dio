<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>    

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="/resources/css/styles.css">
    <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
  <title>Profile</title>
    
    <script>
    $(document).ready(function(){
        
        var timer = setInterval(function(){
            

        // 변수에 데이터 저장
        var now = new Date();
        var hr = now.getHours();
        var min = now.getMinutes();
        var sec = now.getSeconds();
        
        // p 태그 안에 시간 출력
        $("p span").eq(0).text(hr);
        $("p span").eq(1).text(min);
        $("p span").eq(2).text(sec);
        
            },1000)///1초의 시간마다 안쪽의 구문을 반복 실행
    });
    </script>
</head>
<body style="background-color: rgb(254, 235, 0)">
  <header class="top-header top-header--transparent">
    <div class="header__top">
      <div class="header__column">
        <!-- plane icon -->
        <i class="fa fa-plane"></i>

        <!-- wifi icon -->
        <i class="fa fa-wifi"></i>

      </div>
      <div class="header__column">
        <p><span class="header__time">00</span>:<span class="header__time">00</span>:<span class="header__time">00</span></p>
      </div>
      <div class="header__column">
        <!-- moon icon -->
        <i class="fa fa-moon-o"></i>

        <!-- blue icon -->
        <i class="fa fa-bluetooth-b"></i>

        <span class="header__battery">100% <!-- battery icon --><i class="fa fa-battery-full"></i></span>
      </div>
    </div>
    
      <form role="form" action="/app/login" method="post">
          <div style="text-align: center; margin-top: 100px;"><img src="/resources/image/KakaoLogo2.png"></div>
      <div style="text-align: center; margin-top: 60px;">
      <div class="profile__container">
      <input type="text" id="userid" name="userid" placeholder="카카오계정 (이메일 또는 전화번호)" />
      <div class="profile__actions">
      </div>
    </div>
          <div class="profile__container"  style="margin-top:-50px;">
      <input type="password" id="userpw" name="userpw" placeholder="패스워드"/>
      <div class="profile__actions">
      </div>
    </div>
            <div class="profile__container" style="margin-top: 10px;">
                <input type="submit" value="로 그 인"> </div>
</div>
      <div style="margin-left: 100px;">
        <h1 style="color: darkslateblue; font-size: 13px;"><input type="checkbox">잠금모드로 자동로그인</h1>
      </div>
      
      </form>
   <div style="margin-top: 120px; text-align: center;color: darkgray; font-size: 12px;"><a href="#" style="color: gray;">계정찾기</a>  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <a href="joinform" style="color: gray;">회원가입</a></div>
    
    </header>
   
  <main class="profile">
    
  </main>
  <div class="bigScreenText">
    Please make your screen smaller
  </div>
</body>
    
</html>