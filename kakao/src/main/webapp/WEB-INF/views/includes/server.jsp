   
    <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>

<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="../resources/js/stomp.js"></script>
<script type="text/javascript" src="../resources/js/activeMQ.js"></script>
  <!-- 메시지 받으면 알림창..... -->
<div id="stompAlert" class="alert alert-warning" role="alert" style="display:none;">

</div>

<script>
$(document).ready(function () {	
	var myName =  ${sessionScope.mno};
	ActiveMQ.connect(myName);
});
</script>
