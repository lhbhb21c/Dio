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
  <link rel="stylesheet" href="/resources/css/styles.css">
         <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
      <script type="text/javascript" src="/resources/js/jQuery-form.min.js"></script>
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
  	
  <!-- 입력 폼********************************************** -->
  <form action="../file/uploadForm" id="form3" method="POST" enctype="multipart/form-data" >
  <main class="profile">
    <header style="height: 40vh; background-color: yellow;" class="profile__header">
      <div class="profile__header-container">

<!-- 사진입력*********************************************** -->
     <img src="../resources/image/avatar.png" alt="">
        <h3 class="profile-header-title">
		 Seungyong Lee</h3>
      </div>
    </header>
    
    <div class="profile__container">
      <div style="text-align: center; margin-top: 5px; margin-left:70px;">
    
      <input type="text" id="uid" name='uid' placeholder="Id"/><button>중복확인</button>
      <div class="profile__actions">
      </div>
    </div>
    </div>
    <div style="text-align: center; margin-top: -35px;">
    
      <textarea id="state" name='state' placeholder="상태메시지"
      cols="40" row="10" style="width:280px; height:80px;"></textarea>
      
      <div class="profile__actions">
      </div>
    </div>
    </div>
    
    <!-- 입력 폼******************************************************** -->
    
   <div class="profile__actions" style="margin-top:-10px;">
        <div class="profile__action" style="margin-left:260px;">
          <span class="profile__action-circle">
            <i class="fa fa-pencil fa-lg"></i>
          </span>
          <a href="chats"><span class="profile__action-title">수정하기</span></a>
        </div>
        <div class="profile__action" style="margin-left:60px;">
          <span class="profile__action-circle">
            <i class="fa fa-comment fa-lg"></i>
          </span>
          <a href="#" id="insert" ><span id="insert" class="profile__action-title">채팅방으로</span></a>
        </div>
      </div>
        
    <!-- 제출 버튼******************************************************* -->      
          
        </div>
    </form>   
  </main>
  
    
  <div class="bigScreenText">
    Please make your screen smaller
  </div>
  <!-- *********************************************스크립트***************************************** -->
 <script type="text/javascript" src="/resources/js/side.js"></script>
 
 <script type="text/javascript">
 $(document).ready(function(){
	
	 console.log(replyService);
 });
 
 </script>
 <script type="text/javascript">

 
//test
replyService.add(
		{uid:"test1", state:"good"}
		,
		function(result){
			alert("RESULT:" + result);
		}
	);
	
replyService.getList({id:"dlgduqja21c@naver.com"}, function(list) {
	
	for(var i = 0, len = list.length||0; i< len; i++){
		console.log(list[i]);
	}
});

 </script>
  
 </body>
    
</html>