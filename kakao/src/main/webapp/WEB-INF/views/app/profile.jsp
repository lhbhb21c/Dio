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
  <main class="profile">
    <header style="height: 50vh; background-color: yellow;" class="profile__header">
      <div class="profile__header-container">
        <a href="kakao/profile"><img src="/resources/image/avatar.png" alt=""></a>
        <h3 class="profile-header-title"><c:out value="${kakao.userName}"/></h3>
      </div>
    </header>
    <div class="profile__container">
    <input type="text" placeholder="<c:out value="${kakao.userid}"/>" readonly="readonly" style="text-align: center">
      <div class="profile__actions" style="margin-top:70px;">
        <form role="form" id="cre" action="/app/crechat" method="post">
        <div class="profile__action" style="margin-left:100px;">
          <span class="profile__action-circle">
            <i class="fa fa-comment fa-lg"></i>
          </span>
          
          <a href="#" id="creroom"><span class="profile__action-title">1:1 Chat</span></a>
        	<input type="hidden" id="creroom" name="mno" value="<c:out value="${kakao.mno}"/>">
        	
        </div>
        </form>
        <div class="profile__action" style="margin-left:60px;">
          <span class="profile__action-circle">
            <i class="fa fa-pencil fa-lg"></i>
          </span>
          <a href="#" id="add"><span class="profile__action-title">Add Friend</span></a>
          <div class="choose">
        <input type="hidden" id='addF1' name='mno' value="<c:out value="${kakao.mno}"/>">
        	<input type="hidden" id='addF2' name='userName' value="<c:out value="${kakao.userName}"/>">
        	<input type="hidden" id='addF3' name='state' value="<c:out value="${kakao.state}"/>">
        	</div>
        </div>
      </div>
    </div>
  </main>
  <div class="bigScreenText">
    Please make your screen smaller
  </div>
 
  <script type="text/javascript" src="/resources/js/kakao.js"></script>
<!-- 스크립트 시작======================================================================== -->
<script>
  $(document).ready(function () {
	  
	  var operForm = $("#cre"); 
	   var load = $(".choose"); 
	  var mno = load.find("input[name='mno']");
	    var userName = load.find("input[name='userName']");
	    var state = load.find("input[name='state']");
	    
  $("#creroom").on("click", function(e){
	    
	    operForm.submit();
	    
	  });
  $("#add").on("click",function(e){
      
	  
	  
	  
      var user = {
            mno: mno.val(), 
            userName: userName.val(),
            state: state.val()
          };
      
      kakaoService.add(user, function(result){
        
        alert(result);
               
      });
      
    });
  
  });
  </script>
 
  
  </body>
    
</html>