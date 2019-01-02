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
  
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="../resources/css/styles.css">
    <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
  <title>Friends</title>

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

<body>
  <header class="top-header">
    <div class="header__top">
      <div class="header__column">
        <!-- plane icon -->
        <i class="fa fa-plane"></i>

        <!-- wifi icon -->
        <i class="fa fa-wifi"></i>

      </div>
      <div class="header__column">
        <span class="header__time">18:38</span>
      </div>
      <div class="header__column">
        <!-- moon icon -->
        <i class="fa fa-moon-o"></i>

        <!-- blue icon -->
        <i class="fa fa-bluetooth-b"></i>

        <span class="header__battery">66% <!-- battery icon --><i class="fa fa-battery-full"></i></span>
      </div>
    </div>
    <div class="header__bottom">
      <div class="header__column">

      </div>
      <div class="header__column">
        <span class="header__text">More</span>
      </div>
      <div class="header__column">
        <i class="fa fa-cog fa-lg"></i>
      </div>
    </div>
  </header>
  <%@include file="../includes/server.jsp"%>
  
  <main class="more">
    <header class="more__header">
      <div class="more-header__column">
        <img src="images/avatar.png" alt="">
        <div class="more-header__info">
          <h3 class="more-header__title">
            Seungyong Lee
          </h3>
          <span class="more-header__subtitle">
            bongbongco@gmail.com
          </span>
        </div>
      </div>
      <i class="fa fa-comment-o fa-2x"></i>
    </header>
    <section class="more__options">
      <div class="more__option">
        <i class="fa fa-smile-o fa-2x"></i>
        <span class="more__option-title">Emoticons</span>
      </div>
      <div class="more__option">
        <i class="fa fa-paint-brush fa-2x"></i>
        <span class="more__option-title">Themes</span>
      </div>
      <div class="more__option">
        <i class="fa fa-hand-peace-o fa-2x"></i>
        <span class="more__option-title">Plus Friend</span>
      </div>
      <div class="more__option">
        <i class="fa fa-user-circle-o fa-2x"></i>
        <span class="more__option-title">Account</span>
      </div>
    </section>
    <section class="more__plus-friends">
      <header class="plus-friends__header">
        <h2 class="plus-friends__title">Plus Friends</h2>
        <span class="plus-friends__learn-more">
          <i class="fa fa-info-circle"></i>
          Learn More
        </span>
      </header>
      <div class="plus-friends__items">
        <div class="plus-friends__item">
          <i class="fa fa-cutlery"></i>
          <span class="plus-friends__item-title">Order</span>
        </div>
        <div class="plus-friends__item">
          <i class="fa fa-home"></i>
          <span class="plus-friends__item-title">Store</span>
        </div>
        <div class="plus-friends__item">
          <i class="fa fa-television"></i>
          <span class="plus-friends__item-title">TV Channel/Radio...</span>
        </div>
        <div class="plus-friends__item">
          <i class="fa fa-pencil"></i>
          <span class="plus-friends__item-title">Creation</span>
        </div>
        <div class="plus-friends__item">
          <i class="fa fa-graduation-cap"></i>
          <span class="plus-friends__item-title">Education</span>
        </div>
        <div class="plus-friends__item">
          <i class="fa fa-university"></i>
          <span class="plus-friends__item-title">Politics/Society</span>
        </div>
        <div class="plus-friends__item">
          <i class="fa fa-krw"></i>
          <span class="plus-friends__item-title">Finance</span>
        </div>
        <div class="plus-friends__item">
          <i class="fa fa-video-camera"></i>
          <span class="plus-friends__item-title">Movies/Music</span>
        </div>
      </div>
    </section>
    <section class="more__links">
      <div class="more__option">
        <img src="images/kakaoStory.png" alt="" class="more__options-image">
        <span class="more__options-title">Kakao Story</span>
      </div>
      <div class="more__option">
        <img src="images/path.png" alt="" class="more__options-image">
        <span class="more__options-title">Path</span>
      </div>
      <div class="more__option">
        <img src="images/kakaoFriends.png" alt="" class="more__options-image">
        <span class="more__options-title">Kakao friends</span>
      </div>
    </section>
  </main>
  <nav class="tab-bar">
    <a href="friends" class="tab-bar__tab">
      <i class="fa fa-user"></i>
      <span class="tab-bar__title">Friends</span>
    </a>
    <a href="chats" class="tab-bar__tab">
      <i class="fa fa-comment"></i>
      <span class="tab-bar__title">Chats</span>
    </a>
    <a href="find" class="tab-bar__tab ">
      <i class="fa fa-search"></i>
      <span class="tab-bar__title">Find</span>
    </a>
    <a href="more" class="tab-bar__tab tab-bar__tab--selected">
      <i class="fa fa-ellipsis-h"></i>
      <span class="tab-bar__title">More</span>
    </a>
  </nav>
  <div class="bigScreenText">
    Please make your screen smaller
  </div>
  
</body>
</html>