<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <title>TectOne</title>     <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css"  href="resources/css/home.css">
    <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

   </head>    
  
    <body>
  
    <div class="bg">
           
    </div>
    <header>
        <a href="http://localhost:8282/"><H4>TECT ONE</H4></a>
        <ul>
            <li><a href="#">Login</a></li>
            <li> | </li>
            <li><a style="color: red" href="#">LogOut</a></li>
            <li><a href="#">MyPage</a></li>
        </ul>
    </header>
    <nav>
    <ul>
        <!--menu-->
        <li>
        <a href="#">INTRODUCE</a>
            <div>
            <h2><a href="#">INTRODUCE</a></h2>
            <p><img src="/resources/image/introduce.png"></p>
                <ul>
                    <li><a href="intro/profile">Profile</a></li>
                    <li><a href="intro/devspec">Develop Spec</a></li>
                    <li><a href="intro/proinfo">Program Info</a></li>
                    <li><a></a></li>
                </ul>
            </div>
        </li>
        <!--menu-->
        <li>
        <a href="#">KakaoTALK</a>
            <div>
            <h2><a href="#">KakaoTALK</a></h2>
            <p><img src="/resources/image/Kakao.png"></p>
                <ul>
                   <li><a href="#" onclick="window.open('app/loginform','window','width=508,height=760,left=0,top=0')">Login</a></li> 
                    <li><a href="#" onclick="window.open('app/chats','window','width=508,height760,left=0,top=0')">Chats</a></li>
                    <li><a href="#" onclick="window.open('app/friends','window','width=508,height=760,left=0,top=0')">Friends</a></li>
                    <li><a href="#" onclick="window.open('app/profile','window','width=508,height=760,left=0,top=0')">Profile</a></li>
                </ul>
            </div>
        </li>
        <!--menu-->
        <li>
        <a href="#">NOTICE BOARD</a>
            <div>
            <h2><a href="#">NOTICE BOARD</a></h2>
            <p><img src="/resources/image/notice.png"></p>
                <ul>
                    <li><a href="board/list">List</a></li>
                    <li><a href="#">Write</a></li>
                    <li><a href="#">Find</a></li>
                    <li><a></a></li>
                </ul>
            </div>
        </li>
        <!--menu-->
        <li>
        <a href="#">TICKETING</a>
            <div>
            <h2><a href="#">TICKETING</a></h2>
            <p><img src="/resources/image/movie.png"></p>
                <ul>
                    
                    <li><a href="movie/list">Movie List</a></li>
                    <li><a href="#">Ticketing</a></li>
                    <li><a href="#">Ticekt Confirm</a></li>
                    <li><a></a></li>
                </ul>
            </div>
        </li>
        <!--menu-->
        <li>
        <a href="#">Q n A</a>
            <div>
            <h2><a href="#">Q n A</a></h2>
                <p><img src="/resources/image/question.png"></p>
                <ul>
                    <li><a href="/qna">Custum Question</a></li>
                    <li><a></a></li>
                    <li><a></a></li>
                    <li><a></a></li>
                </ul>
            </div>
        </li>
        </ul>    
    </nav>
    <footer>
    <ul>
        <li><a href="#">Terms of Use</a></li>
        <li><a href="#">News letter</a></li>
        <li><a href="#">SiteMap</a></li>
        <li><a href="#">Careers</a></li>
        <li><a href="#">Credits</a></li>
        <li><a href="#">Privacy Notice</a></li>
    </ul>    
        <span>
            Copyright c 2018 Beom INT ALL Right Reserved.
        </span>
    </footer>
    
    <script>

//self.location ="/app/go";

</script>
    </body>
</html>
