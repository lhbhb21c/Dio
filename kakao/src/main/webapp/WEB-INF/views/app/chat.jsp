<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="/resources/css/styles.css">
<script type="text/javascript" src="../resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="../resources/js/jquery-ui-1.8.22.custom.min.js"></script>
<script type="text/javascript" src="../resources/js/stomp.js"></script>
<script type="text/javascript" src="../resources/js/activeMQ.js"></script>
 </head>
<body class="body-chat">
  <header class="top-header chat-header">
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
    
<!-- ******************************** 채팅부분****************************** -->    
    
    <div class="header__bottom">
      <div class="header__column">
        <a href="javascript:history.go(-1)">
          <i class="fa fa-chevron-left fa-lg"></i>
        </a>
      </div>
      <div class="header__column">
        <span class="header__text"><c:out value="${cchat.userName}"/></span>
      </div>
      <div class="header__column">
        <i class="fa fa-search"></i>
        <i class="fa fa-bars"></i>
      </div>
    </div>
  </header>
<main class="chat">
  <div class="date-divider">
    <span class="date-divider__text">Wednesday, August 2, 2017</span>
  </div>
  
   
  <div class='flist' id="flist">
<div id="conversations">
        <ul>
        </ul>
    </div>
</div>
</main>



<div class="type-message">
  <i class="fa fa-plus fa-lg"></i>
  <div class="type-message__input">
 
    <input type="text" id="chat_contend">
  <button id="btnSend" type="button" class="record-message"><i id="btnSend">send</i></button>

  </div>
</div>
<div class="bigScreenText">
  Please make your screen smaller
</div>


<script type="text/javascript" src="/resources/js/kakao.js"></script>



<script>

$(document).ready(function () {	
	var conf = {
			 cno : <c:out value="${incno}"/>,
			 chat2 : [{
       		   mno : <c:out value="${cchat2.mno}"/>,
       		   enable : 1
       		  }]	    
       	   };
       	   console.log(conf);
   // kakaoService.add2(chat, function(result){
   	//메세지 확인이 false로되있던 confirm 을 true로 바꿔줄 것이다.
	kakaoService.confirm(conf, function(result){
		
	});
	 
    });
	
	

	console.log("제발떠라");
	var myName =  ${sessionScope.mno};
	//stomp 에 접속
	console.log("떠라제발"+myName);	 


	ActiveMQ.connect(myName);

	
	
  var cnoValue = <c:out value="${incno}"/>;
  console.log(cnoValue);
  var mnoValue = <c:out value="${cchat2.mno}"/>	;
  console.log(mnoValue);
  
  var flist = $(".flist");
  showList(); 
   
//채팅내역 출력함수===============================================================================================  
  function showList(){
		
    console.log("show list ");
    kakaoService.getList2({cno:cnoValue}, function(list) {
      
    console.log("list  :  "+ list);   	
    
    //채팅내용 출력===============================================================================================
    var str="";
     
     if(list == null || list[0].Chat == 0){
       return;
     }
     
     for (var i = 0, len = list.length || 0; i < len; i++) {
if(list[i].mno == mnoValue ){
	
    	str += "<div class='chat__message chat__message-to-me'>";
    	str += "<img src='/resources/image/avatar.png' alt='' class='chat-message-avatar'>";
    	str += "<div class='chat__message-center'>";
    	str += "<h3 class='chat__message-username'><c:out value='${cchat.userName}'/></h3>";
    	str += "<span class='chat__message-body'>"+ list[i].content +  "</span></div>";
    	str += "<span class='chat__message-time'>" +"11:11" +"</span></div>";        

} else{
	str += "<div class='chat__message chat__message-from-me'>";
	str += "<span class='chat__message-time'>17:55</span>";
	str += "<span class='chat__message-body'>" + list[i].content + "</span></div>";

	
}
	

} 	
     flist.html(str);
	
    
   });//end function
      
 }//end showList

 // 채팅입력시 전송
 $("#btnSend").on("click",function(e){  

	 //서버로 메세지 전송	
	 var message = $('input#chat_contend').val();
	 console.log(message);
	 ActiveMQ.toChat(<c:out value="${cchat2.mno}"/>,<c:out value="${cchat.mno}"/>,message);
		console.log(<c:out value="${cchat.mno}"/>);
	var chat = {
			 cno : <c:out value="${incno}"/>,
			 chat2 : [{
        		   mno : <c:out value="${cchat.mno}"/>,
        		   content : $('input#chat_contend').val(),	   
        		   wtime: null,
        		   enable : null
        		  }]	    
        	   };
        	   console.log(chat);
     kakaoService.add2(chat, function(result){
    	 showList(); 
		 
     });
   });

</script>
</body>
    
</html>