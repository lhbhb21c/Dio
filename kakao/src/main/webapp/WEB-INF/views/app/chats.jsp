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
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/css/styles.css">
  <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
  <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
  <title>Chats</title>

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
        <span class="header__text">Edit</span>
      </div>
      <div class="header__column">
        <span class="header__text">Chats <i class="fa fa-caret-down"></i></span>
      </div>
      <div class="header__column">

      </div>
    </div>
  </header>
  <%@include file="../includes/server.jsp"%>
  
  <main class="chats">
    <div class="search-bar">
      <i class="fa fa-search"></i>
      <input type="text" placeholder="Find friends, chats, Plus Friends">
    </div>
  
  
    <ul class="chats__list">
    </ul>
  
  
      <div class="chat-btn">
        <i class="fa fa-comment"></i>
      </div>

  </main>
  <nav class="tab-bar">
    <a href="friends" class="tab-bar__tab">
      <i class="fa fa-user"></i>
      <span class="tab-bar__title">Friends</span>
    </a>
    <a href="chats" class="tab-bar__tab tab-bar__tab--selected">
      <i class="fa fa-comment"></i>
      <span class="tab-bar__title">Chats</span>
    </a>
    <a href="find" class="tab-bar__tab">
      <i class="fa fa-search"></i>
      <span class="tab-bar__title">Find</span>
    </a>
    <a href="more" class="tab-bar__tab">
      <i class="fa fa-ellipsis-h"></i>
      <span class="tab-bar__title">More</span>
    </a>
  </nav>
  <div class="bigScreenText">
    Please make your screen smaller
  </div>
  
<script type="text/javascript" src="/resources/js/kakao.js"></script>

<script>

$(document).ready(function () {
  
  var mnoValue = ${sessionScope.mno};
  console.log(mnoValue);
  var flist = $(".chats__list"); 
  
  showList(); 
   
//목록 출력함수===============================================================================================  
  function showList(){
		
    console.log("show list ");
    
	
  	
    kakaoService.getList({mno:mnoValue}, function(list) {
      
    	
    	
    console.log("list.mno"+ list[0].chatVO[0].mno);  
    
    //채팅 목록 출력===============================================================================================
    var str="";
     
     if(list == null || list[0].chatVO == 0){
       return;
     }
     
     for (var i = 0, len = list[0].chatVO.length || 0; i < len; i++) {
    	
         str +="<li class='chats__chat'>";
    	 str +="<a href='/app/chat?mno="+ list[0].chatVO[i].mno  +"' id='gocno'>";
    	 str +="<div class='chat__content'>";
    	 str +="<img src='/resources/image/avatar.png'>";
 		 str +="<div class='chat__preview'>";       
    	 str +="<h3 class='chat__user'>" + list[0].chatVO[i].mno + "</h3>";
      	 str +="<span class='chat__last-message'>" +list[0].chatVO[i].cno + "</span></div></div>";
      	 str +="<span class='chat__date-time'>" + "15:55" + "</span></a></li>";
   	
     }
     flist.html(str);
   
   });//end function     
 }//end showList


});
</script>

 </body>
 
 

 
   </html>