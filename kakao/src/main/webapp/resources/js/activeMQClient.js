var ActiveMQClient = (function() {

	//ActiveMQ.js 에서 설명하지 않은 것들만 주석을 남기겠습니다.
    var ActiveMQURL = 'ws://localhost:61614'; 

    var client;
    
    //온라인 유저들을 담을 변수입니다....
    var connectedUsers = {};
    //접속하는 함수입니다.
    //실시간으로 알림을 받을시에는  모든페이지를 include하는 jsp에 접속 함수를 집어넣을 생각입니다...
  
    function connect(userName) {
        if(!userName || userName == '') {
            return;
        }

        client = Stomp.client(ActiveMQURL);
        client.connect(null, null, onconnect, onerror);

        function onconnect() {
            console.log("접속 되었습니다.");
            initConnectedUsers();
            subscribeMessageQueue();
            subscribeActiveMQAdvisory();
            setConnected(true);
        }

        function onerror() {
            console.log("Error!!!");
            setConnected(false);
        }
        //리스트 [0] ,[1] 등 쌓이는데로 리스트 인덱스로 전체를 출력할 것입니다.
        function initConnectedUsers() {
            connectedUsers = {};
        }

        function subscribeMessageQueue() {
        	//멤버 id값은 mno로 데이터베이스에 저장되었습니다.
        	//이를 기준으로 하려고 합니다.. ㅎㅎㅎ
            client.subscribe('chat.' + userName, processMessage);
        }
        //메세지를 받을시 입니다.
        function processMessage(message) {
            showConversation(message.headers.from);
            //오면 화면에 출력해야 합니다...
            //뒤에 conversation 을 붙여 구분을 해줍니다. stomp.js 를 보시면 밑에 기능을 어떻게 쓸수 있는지 알수 있습니다.
            let $stompAlert = $('div#stompAlert');
            $stompAlert.css('display', 'block');
            $stompAlert.text(message.headers.from+" : "+message.body);
            addMessage(message.headers.from, message.body, cleanWhitespaces(message.headers.from) + 'conversation');
        }

        function subscribeActiveMQAdvisory() {
            client.subscribe('/topic/ActiveMQ.Advisory.Consumer.Queue.chat.>', function(msg){
                var jsonObject = JSON.parse(msg.body);
                //구독하면 실시간으로 내용을 보여주기위해 위에 설정한 proccessConsumers를 실행합니다.
                //->addMessage함수를 실행합니다
                proccessConsumers(jsonObject);
            
            });
        }

        //위에 함수가 실행됩니다... 구독한 메세지를 작동하는것입니다ㅣ.
        function proccessConsumers(msg) {
            if (msg.ConsumerInfo) {
                processConsumerInfo(msg.ConsumerInfo);
            } else if (msg.RemoveInfo) {
                processRemoveInfo(msg.RemoveInfo);
            } else {
                console.log('실패했습니다....' + msg);
            }
        }
        //구독자 이름과 정보를 사용하는 함수입니다.
        function processConsumerInfo(consumerInfo) {
            var connectionId = consumerInfo.consumerId.connectionId;
            var subscriptionName = consumerInfo.destination[0].replace('chat.', '');
            if (!connectedUsers[connectionId] && subscriptionName != userName) {
                addOnlineUser(subscriptionName);
                connectedUsers[connectionId] = subscriptionName;
            }
        }
        //접속이 끊키면 리스트에서 없에야겠습니다.
        function processRemoveInfo(removeInfo) {
            var connectionId = removeInfo.objectId.connectionId;
            var userName = connectedUsers[connectionId];
            removeOnlineUser(userName);
        }

    }
    //클라이언트(제가) 접속을 끊게된다면... 대화창을 다 닫아버릴것입니다.
    function disconnect() {
        if (client) {
            client.disconnect();
        }
        closeAllConversations();
        setConnected(false);
    }
    //접속자를 설정할때 사용합니다...
    //사실 admin아이디를 만들어 할지 순간순간 할지 고민중입니다.
    function setConnected(connected) {
        document.getElementById('connect').disabled = connected;
        document.getElementById('disconnect').disabled = !connected;
        cleanConnectedUsers();
        if (connected) {
            updateUserConnected();
        } else {
            updateUserDisconnected();
        }
    }

    //접속한 유저를 리스트에 실시간으로 업데이트합니다.
    function updateUserConnected() {
        var inputUsername = $('#userName');
        var onLineUserName = $('.onLineUserName');
        //상대가 입력한 유저를 받아서 리스트에 펼칠것이지만...
        //admin은 한명뿐이라... 고민중이지만 우선은  게스트 형식으로 하겠습니다.
        onLineUserName.html(inputUsername.val());
        //접속하면 아이디 입력하는 text구간은 숨기고
        inputUsername.css({display:'none'});
        //보여줍니다(html을 펼치는것입니다.)
        onLineUserName.css({visibility:'visible'});
        $('#status').html('Connect');
        //접속 클래스를 (속성을) 추가해줍니다.
        $('#status').attr({class : 'connected'});
        //유저들을 보여줍시다 (html)
        $('#onLineUsersPanel').css({visibility:'visible'});
    }

    //위와 방식은 같습니다 끊키면 제거해줍니다.
    function updateUserDisconnected() {
        $('.onLineUserName').css({visibility:'hidden'});
        $('#userName').css({display:''});
        $('#status').html('disconnected');
        $('#status').attr({class : 'disconnected'});
        $('#onLineUsersPanel').css({visibility:'hidden'});
    }

    //밑에는 유저 리스트와 관련된 함수들입니다.
    function cleanConnectedUsers() {
        $('#onlineUsers').html('');
    }

    function removeTab(conversationId) {
        $('#conversations').tabs('remove', conversationId);
    }

    function cleanWhitespaces(text) {
        return text.replace(/\s/g,"_");
    }

    //유저리스트에서 클릭시 펼처질 함수입니다.
    function showConversation(from) {
        var conversations = $('#conversations');
        conversations.css({visibility:'visible'});
        var conversationId = cleanWhitespaces(from) + 'conversation';
        //처음 만들어지는것이면(null값이면) 새로운 클래스와 요소들을 추가해줍니다.
        if(document.getElementById(conversationId) == null) {
            createConversationPanel(from);
            conversations.tabs('add', '#' + conversationId, from);
        }
        try {
            conversations.tabs('select', '#' + conversationId);
            $('#'+conversationId+'message').focus();
        } catch (e) {}

    }
    
 	//대화창을 만드는 함수입니다.
    function createConversationPanel(name) {
        var conversationId = cleanWhitespaces(name) + 'conversation';
        var conversationPanel = $(document.createElement('div'));
        conversationPanel.attr({id : conversationId, class : 'conversation'});
        $('<p class="messages"></p><textarea id="' + conversationId + 'message"></textarea>').appendTo(conversationPanel);
        //밑에 함수로부터 리턴받은 버튼입니다.
        var sendButton = createSendButton(name);
        sendButton.appendTo(conversationPanel);
        var closeButton = createCloseButton(cleanWhitespaces(name));
        closeButton.appendTo(conversationPanel);
        conversationPanel.appendTo($('#conversations'));
    }
    //전송시 움직일 버튼 설정
    function createSendButton(name) {
        var conversationId = cleanWhitespaces(name) + 'conversation';
        var button = $(document.createElement('button'));
        button.html('보내기');
        //리스트의 대화하고싶은 유저를 눌렀을시....
        //큐에 쌓인 내용들이 있다면 받아버리고, 아니면 시작하는 함수입니다. 
        button.click(function () {
            var from = document.getElementById('userName').value;
            var message = document.getElementById(conversationId+'message').value;
            toChat(from, name, message);
            addMessage(from, message, conversationId);
            document.getElementById(conversationId+'message').value = '';
        });
        return button;
    }

    //포문을 이용하여, 있는 유저들을 다닫아버립니다.(length는 전체 유저수입니다.)
    function closeAllConversations() {
        for (var i = $('#conversations').tabs('length'); i >= 0; i--) {
            $('#conversations').tabs('remove', i-1);
        }
        $('#conversations').css({visibility : 'hidden'});
    }

    //send버튼 만드는것과 같습니다.
    function createCloseButton(conversationId) {
        var button = $(document.createElement('button'));
        button.html('닫기');
        button.click(function () {
            removeTab(conversationId);
        });
        return button;
    }
    //메세지 더하는 구간입니다.
    function addMessage (from, message, conversationPanelId) {
        var messages = $('#' + conversationPanelId + ' .messages');
        $('<div class="message"><p>' + $('<p/>').text(message).html() + '</p></div>').appendTo(messages);
        messages.scrollTop(messages[0].scrollHeight);
        $('#'+conversationPanelId+' textarea').focus();
    }

    //client는 맨위에 정해진 변수에 stomp주소를 더하여 stomp.js와 연관되있는 함수입니다.
    //from sender는 보낸사람 받은사람 정보를 남기기 위해 설정한것입니다.(from에 sender가 담기겟지요)
    function toChat(sender, receiver, message) {
        client.send('chat.' + receiver, {from: sender}, message);
    }

    //유저 리스트 관련 함수 입니다.
    function addOnlineUser(userName) {
        var newOnlineUser = createOnlineUser(userName);
        newOnlineUser.appendTo($('#onlineUsers'));
    }

    function removeOnlineUser(userName) {
        $('#onlineUsers > li').each(function (index, elem) {
            if (elem.id == userName + 'onlineuser') {
                $(elem).remove();
            }
        });
    }

    function createOnlineUser(userName) {
        var link = $(document.createElement('a'));
        link.html(userName);
        link.click(function(){
            showConversation(userName);
        });
        var li = $(document.createElement('li'));
        li.attr({id : (userName + 'onlineuser')});
        link.appendTo(li);
        return li;
    }

    window.onbeforeunload = disconnect;

    // metodos publicos
    return {
        connect : connect,
        disconnect : disconnect
    };
})();