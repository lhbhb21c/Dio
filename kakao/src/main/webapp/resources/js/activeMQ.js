var ActiveMQ = (function() {

	//우리가 접속할 주소입니다.
    var ActiveMQURL = 'ws://localhost:61614'; 
    var count = 0;
    var client;
    var connectedUsers = {};
    
    function connect(userName) {
  
        if(!userName || userName == '') {
            return;
        }
        //stomp.js 문법에 주소를 client 변수에 담습니다.
        client = Stomp.client(ActiveMQURL);
        //id, pw 는 적용 안하겠습니다.
        client.connect(null, null, onconnect, onerror);

        function onconnect() {
            console.log("성공했습니다....ㅎ");
            //쌓인 메세지를 부를때 필요합니다.
            subscribeMessageQueue();
            //주소
            subscribeActiveMQAdvisory();
            //접속을 true로 적용합니다.
            setConnected(true);
        }

        //에러시 출력함수
        function onerror() {
            console.log("Error!!!");
            //false로 적용합니다.
            setConnected(false);
        }

        // + userName에따라 큐가 만들어집니다.
        // 이 destination 을 기준으로 서로 메시지를 주고 받습니다...ㅎ
        function subscribeMessageQueue() {
            //클라이언트에 처음에 주소를 담았습니다.. 이주소에 chat.userName을 찾아 구독합니다.
        	client.subscribe('chat.' + userName, processMessage);
        }

        //받으면 창에 쓴사람 내용 받는이 를 나타낼것입니다.
        function processMessage(message) {
            console.log("====수신테스트=====");
            addMessage(message.headers.from, message.body, cleanWhitespaces(message.headers.from));
            counter();
            let $stompAlert = $('div#stompAlert');
            $stompAlert.css('display', 'block');
            $stompAlert.text(message.headers.from+" : "+message.body );
            
        }
        function counter(){
        	++count
        	console.log(count);
        }

        //기본적으로 조회할 주소입니다.(경기도 안양시 비산동 중에서 경기도? subscribeMessageQueue() chat.+userName은 비산동 + 임곡아파트 정도?
        function subscribeActiveMQAdvisory() {
            client.subscribe('/topic/ActiveMQ.Advisory.Consumer.Queue.chat.>', function(msg){
            });
        }

    }

    //접속을 끊는 함수이다.
    function disconnect() {
            client.disconnect();
    }

    function setConnected(connected) {
       // document.getElementById('connect').disabled = connected;
       // document.getElementById('disconnect').disabled = !connected;
        if (connected) {
            console.log("접속양호");
        } else {
        	console.log("접속이 안됩니다.....");
        }
    }


    //
    function cleanWhitespaces(text) {
        //공백을 처리하는 문법이다... 이문법을 적용안하면 그대로 출력될것이다.
    	return text.replace(/\s/g,"_");
        
    }

    //싸여있는 메세지를 받았다면 채팅창에 출력 하려고 한다....
    //채팅창 jsp에는 flist라는 아이디 값을 준 태그가 있다.. 
    function addMessage (from, message, conversationPanelId) {
    	var messages = $('#flist');

    	var str = "";
    	str += "<div class='chat__message chat__message-to-me'>";
    	str += "<img src='/resources/image/avatar.png' alt='' class='chat-message-avatar'>";
    	str += "<div class='chat__message-center'>";
    	str += "<h3 class='chat__message-username'>" +from + "</h3>";
    	str += "<span class='chat__message-body'>"+ message +  "</span></div>";
    	str += "<span class='chat__message-time'>" +"11:11" +"</span></div>";        
    	// 이 flist에 위제 변수에담은 str을 추가해서 출력할려고한다.
    	$(str).appendTo(messages);
    }
    
    //서버로 메세지를 전송하는것이다.
    function toChat(sender, receiver, message) {
    //{from:sender는} 준사람이 누군지 구분하기위해 from 변수에 sender를 담은 것이다.
    	client.send('chat.' + receiver, {from: sender}, message);
    }

    window.onbeforeunload = disconnect;

    return {
    	toChat : toChat,
    	connect : connect,
        disconnect : disconnect
    };
})();