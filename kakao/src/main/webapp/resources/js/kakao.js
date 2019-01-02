console.log("Kakao Module........");

var kakaoService = (function(){
	

// 친구, 채팅리스트 조회시........
	function getList(param, callback, error) {

	    var mno = param.mno;
	   
	    $.getJSON("/kakao/list/" + mno + ".json",
	        function(data) {
	    	
	          if (callback) {
	            callback(data); // 댓글 목록만 가져오는 경우 
	            }
	        }).fail(function(xhr, status, err) {
	      if (error) {
	        error();
	      }
	    });
	  }

//채팅내용리스트 조회........	
	function getList2(param, callback, error) {

	    var cno = param.cno;
	   
	    
	    $.getJSON("/kakao/list2/" + cno + ".json",
	        function(data) {
	    	
	          if (callback) {
	            callback(data); 
	            }
	        }).fail(function(xhr, status, err) {
	      if (error) {
	        error();
	      }
	    });
	  }

	function get(mno, callback, error) {
		console.log("Kakao get Running........");
		$.get("/kakao/" + mno + ".json", function(result) {

			if (callback) {
				callback(result);
			}

		}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}
	//친구추가
	function add(user, callback, error) {
		console.log("add user...............");

		$.ajax({
			type : 'post',
			url : '/kakao/new2',
			data : JSON.stringify(user),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})
	}
	function confirm(conf) {
		console.log("confirm false를 true로 수정.....");

		$.ajax({
			type : 'post',
			url : '/kakao/confirm',
			data : JSON.stringify(conf),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})
	}
	function add2(chat, callback, error) {
		console.log("add user...............");

		$.ajax({
			type : 'post',
			url : '/kakao/new3',
			data : JSON.stringify(chat),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})
	}

	return {
		confirm : confirm,
		getList : getList,
		getList2 : getList2,
		get : get,
		add : add,
		add2 : add2
	};

})();
