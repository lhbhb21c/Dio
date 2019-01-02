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
 
 
</head>
<body>
 <header class="top-header top-header--transparent">
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
        <a href="index.html">
          <i class="fa fa-times fa-lg"></i>
        </a>
      </div>
      <div class="header__column">
        <i class="fa fa-user fa-lg"></i>
      </div>
    </div>
  </header>
  <form id="operForm" role="form" action="/app/reprofile" method="post">
  <main class="profile">
    <header style="height: 50vh; background-color: yellow;" class="profile__header">
      <div class="profile__header-container">
        <a href="kakao/profile"><img src="/resources/image/avatar.png" alt=""></a>
        <h3 class="profile-header-title">
        <input type="hidden" name="mno" value="<c:out value="${kakao.mno}"/>">
        <input type="text" name="userid" style="text-align: center" placeholder="<c:out value="${kakao.userName}"/>">
        </h3>
      </div>
    </header>
    <div class="profile__container">
    <input type="text" name="userid" style="text-align: center" placeholder="<c:out value="${kakao.userid}"/>">
      <div class="profile__actions" style="margin-top:70px;">
        <div class="profile__action" style="margin-left:100px;">
          <span class="profile__action-circle">
            <i class="fa fa-pencil fa-lg"></i>
          </span>
           <a href="#"><span class="profile__action-title">Edit Profile</span></a>
           <!-- <input type="submit" value="회 원 가 입" id="btn-join">-->
        </div>
        <div class="profile__action" style="margin-left:60px;">
          <span class="profile__action-circle">
            <i class="fa fa-comment fa-lg"></i>
          </span>
          <a href="chats"><span class="profile__action-title">My Chatroom</span></a>
        </div>
      </div>
    </div>
    </form>
  </main>
  <div class="bigScreenText">
    Please make your screen smaller
  </div>
  
  <script>
  $(document).ready(function () {
	  
	  var operForm = $("#operForm"); 
	  
  $(".profile__action-title").on("click", function(e){
	    
	    operForm.submit();
	    
	  });
  });
  </script>
  
  </body>
    
</html>