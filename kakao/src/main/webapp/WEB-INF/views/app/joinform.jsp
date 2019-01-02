<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="../resources/css/styles.css">
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
    <form role="form" action="/app/new" method="post">   
    <input type="hidden" id="mno" name='mno' value="0"/>   
    <input type="hidden" id="authList" name='authList'/>   
      <div style="text-align: center; margin-top: 130px;">
      <div class="profile__container">
      <input type="text" id="userid" name='userid' placeholder="카카오계정 (이메일 또는 전화번호)"/>
      <div class="profile__actions">
      </div>
    </div>
    <div style="text-align: center; margin-top: -40px;">
          <div class="profile__container">
      <input type="password" id="userpw" name='userpw' placeholder="비밀번호 (4~32자)"/>
      <div class="profile__actions">
      </div>
    </div>
    <div style="text-align: center; margin-top: -40px;">
    <div class="profile__container">
      <input type="text" id="uid" name='uid' placeholder="Id"/>
      <div class="profile__actions">
      </div>
    </div>
    <div style="text-align: center; margin-top: -40px;">
    <div class="profile__container">
      <input type="text" id="username" name='userName' placeholder="이 름"/>
      <div class="profile__actions">
      </div>
    </div>
    <div style="text-align: center; margin-top: -40px;">
    <div class="profile__container">
      <input type="text" id="address" name='address' placeholder="주 소"/>
      <div class="profile__actions">
      </div>
    </div>
    <div style="text-align: center; margin-top: -40px;">
    <div class="profile__container">
      <input type="text" id="code" name='code' placeholder="주민번호(-없이)"/>
      <div class="profile__actions">
      </div>
    </div>
    
            <div class="profile__container" style="margin-top: 50px;">
                <input type="submit" value="회 원 가 입" id="btn-join"> </div>
</div>
</div>
</div>
</div>
</div>  
</div>
</form>
   <div style="margin-top: 100px; text-align: center;color: darkgray; font-size: 12px;"><a href="loginform" style="color: gray;">로 그 인</a>  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <a href="#" style="color: gray;">나 가 기</a></div>
    
    </header>
   
  <main class="profile">
    
  </main>
  <div class="bigScreenText">
    Please make your screen smaller
  </div>
</body>
        
    
    
    
    
    
</html>