<!DOCTYPE HTML>
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link type="text/css" href="../resources/css/default.css?123" rel="stylesheet" />
    <link type="text/css" href="../resources/css/smoothness/jquery-ui-1.8.22.custom.css" rel="stylesheet" />
    <!-- Bootstrap 3.3.4 -->
    <link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript" src="../resources/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="../resources/js/jquery-ui-1.8.22.custom.min.js"></script>
    <script type="text/javascript" src="../resources/js/stomp.js"></script>
    <script type="text/javascript" src="../resources/js/activeMQClient.js?2032"></script>
    <title>관리자모드</title>
       <script type="text/javascript">
        $(function(){
            $('#conversations').tabs();
        });
    </script>
</head>
<body>

<div id="stompAlert" class="alert alert-warnning" role="alert" style="display:none;">
</div>



<h1> 관리자모드 
</h1>
<div id="container">
    <div class="leftPanel">
        <div class="userInfo">
            <span class="disconnected" id="status">disconnect</span>
            사용할 이름: <input type="text" id="userName"/><span class="onLineUserName"></span>
        </div>
        <div>
            <button id="connect" onclick="ActiveMQClient.connect($('#userName').val());">접속</button>
            <button id="disconnect" disabled="disabled" onclick="ActiveMQClient.disconnect()">해제</button>
        </div>
        <div id="onLineUsersPanel">
            <h3>접속유저</h3>
            <ul id="onlineUsers">

            </ul>
        </div>

    </div>

    <div id="conversations">
        <ul>
        </ul>
    </div>
</div>





</body>
</html>
