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
  <link rel="stylesheet" href="/resources/css/styles.css">
    <link rel="stylesheet" href="/resources/css/search.css">
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
        <span class="header__text">Edit</span>
      </div>
      <div class="header__column">
        <span class="header__text">Find</span>
      </div>
      <div class="header__column">

      </div>
    </div>
  </header>
  <%@include file="../includes/server.jsp"%>
  
  <main class="find">
    <section class="find__options">
      <div class="find__option">
        <i class="fa fa-address-book fa-lg"></i>
        <span class="find__option-title">Find</span>
      </div>
      <div class="find__option">
        <i class="fa fa-qrcode fa-lg"></i>
        <span class="find__option-title">QR Code</span>
      </div>
      <div class="find__option">
        <i class="fa fa-mobile fa-lg"></i>
        <span class="find__option-title">Shake</span>
      </div>
      <div class="find__option">
        <i class="fa fa-envelope-o fa-lg"></i>
        <span class="find__option-title">Invite via SMS</span>
      </div>
    </section>
<!-- 검색 입력란  ============================================================================== -->    
       <div class="box" style="margin-top:-200px; margin-left:50px;">
       	<form id="search" role="form">
       		<input type="text" id='mno' name='mno' placeholder="Id입력(친구)" >
       		<input type="button" id="go" value="Search">
       	</form>
       </div>
    <section class="find__recommended">
      <header>
        <h6 class="recommend__title">Find Friends</h6>
      </header>
      <div class="recommended__none">
      </div>
    </section>
<!-- 겁색친구 출력란==(자바스크립트를 통해 RestController 실행  -> ajax처리 예정 -->
<div class="flist">
</div>
               




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
    <a href="find" class="tab-bar__tab tab-bar__tab--selected">
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
<!-- 스크립트 시작======================================================================== -->
<script>
$(document).ready(function () {
	//댓글 조회 클릭 이벤트 처리 
 	  var flist = $(".flist");
	$("#go").on("click", function(e){
      
    var mno = $('#mno').val();
   	console.log("test1" + mno);
   	
    showList(mno); 
    
  
//검색친구 출력함수===============================================================================================  
  function showList(mno){
		
    kakaoService.get(mno, function(user){    
    
    console.log("test3"   +    user);
    //둘중 하나가 불러오는 방식인...참
    //친구 목록 출력===============================================================================================
    var str="";
     
     if(user == null){
       return;
       
     }
     	 str +="<div class='friends__section-rows'>";
    	 str +="<div class='friends__section-row with-tagline'>";
    	 str +="<div class='friends__section-column'>";
       	 str +="<a href='/app/profile?mno=" + user.mno + "' onclick='window.open(this.href, '','width=508,height=760,left=0,top=0'); return false;'>";
 		 str +="<img src='/resources/image/avatar.png' alt=''></a>";       
    	 str +="<span class='friends__section-name'>" + user.userid + "</span></div>";
      	 str +="<span class='friends__section-tagline'>" + user.state +"</span></div></div>";
     
     flist.html(str);     	
   
   });//end function
     
 }//end showList
});
});
</script>
  
  
  
  
  
  
  
  
  
  
  
  
  
</body>
 	   
</html>