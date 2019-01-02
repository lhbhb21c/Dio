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

        <span class="header__battery">100% <!-- battery icon --><i class="fa fa-battery-full"></i></span>
      </div>
    </div>
    <div class="header__bottom">
      <div class="header__column">
        <span class="header__text">
       <h2>${sessionScope.userName}님</h2>
        </span>
      </div>
      <div class="fc">
      </div>
      <div class="header__column">
        <i class="fa fa-cog"></i>
      </div>
    </div>
  </header>
  <!-- 메시지 받으면 알림창..... -->
<%@include file="../includes/server.jsp"%>

  <div class="friends">
    <div class="search-bar">
      <i class="fa fa-search"></i>
      <input type="text" placeholder="Find friends, chats, Plus Friends">
    </div>
    <section class="friends__section">
      <header class="friends__section-header">
        <h6 class="friends_profile-title">My Profile</h6>
      </header>
    
      <div class="friends__section-rows">
        <div class="friends__section-row">
          <a href='/app/profile?mno=<c:out value="${sessionScope.mno}"/>'><img src="/resources/image/avatar.png" alt=""></a>
          <span class="friends__section-name">${sessionScope.userName}(Owner)</span>
        </div>
      </div>

    </section>
    
    
  <section class="friends__section">  
      <header class="friends__section-header">
        <h6 class="friends__section-title">Friends</h6>
      </header>
  
  <div class="flist">
  
  </div>
               
    </section>
  </div>
  <nav class="tab-bar">
    <a href="friends" class="tab-bar__tab tab-bar__tab--selected">
      <i class="fa fa-user"></i>
      <span class="tab-bar__title">Friends</span>
    </a>
    <a href="chats" class="tab-bar__tab">
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
  var flist = $(".flist");
  var fc = $(".fc");
  showList(); 
   
//목록 출력함수===============================================================================================  
  function showList(){
		
    console.log("show list ");
    
    kakaoService.getList({mno:mnoValue}, function(list) {
      
    console.log("list.mno"+ list[0].friendsVO[0].userName);  
    
    //친구 목록 출력===============================================================================================
    var str="";
     
     if(list == null || list[0].friendsVO == 0){
       return;
     }
     
     for (var i = 0, len = list[0].friendsVO.length || 0; i < len; i++) {
    	 str +="<div class='friends__section-rows'>";
    	 str +="<div class='friends__section-row with-tagline'>";
    	 str +="<div class='friends__section-column'>";
       	 str +="<a href='/app/profile?mno=" + list[0].friendsVO[i].mno + "' onclick='window.open(this.href, '','width=508,height=760,left=0,top=0'); return false;'>";
 		 str +="<img src='/resources/image/avatar.png' alt=''></a>";       
    	 str +="<span class='friends__section-name'>" + list[0].friendsVO[i].userName + "</span></div>";
      	 str +="<span class='friends__section-tagline'>" + list[0].friendsVO[i].state +"</span></div></div>";
     }
     flist.html(str);
 	//친구 전체 인원출력=============================================================================================
     var str2 ="";
   	 
     str2 +="<div class='header__column'>";
	 str2 +="<span class='header__text'>Friends</span>";
	 str2 +="<span class='header__number'>"+"&nbsp;" + list[0].friendsVO.length + "</span></div>";

     flist.html(str);
     fc.html(str2);
     	
   
   });//end function
     
 }//end showList
});
</script>

</body>
 	   
</html>