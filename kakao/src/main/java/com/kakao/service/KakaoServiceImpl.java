package com.kakao.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.mongodb.core.FindAndModifyOptions;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kakao.domain.Chat;
import com.kakao.domain.Chat2;
import com.kakao.domain.ChatVO;
import com.kakao.domain.Counter;
import com.kakao.domain.FriendVO;
import com.kakao.domain.KakaoVO;
import com.kakao.domain.SequenceException;
import com.mongodb.WriteResult;

import lombok.AllArgsConstructor;


@Service
@AllArgsConstructor
@Transactional
public class KakaoServiceImpl implements KakaoService {

	private static final String MNO_SEQ_KEY = "hosting";
	private static final String MNO_SEQ_KEY2 = "hosting2";

	private MongoTemplate mongo;


	//회원가입
	@Override
	public int join(KakaoVO vo) {
		try {
			vo.setMno(getNextSequenceId(MNO_SEQ_KEY));
			System.out.println(vo.getUserpw());
		} catch (Exception e) {
			e.printStackTrace();
		}

		mongo.insert(vo);

		KakaoVO result = mongo.findById(vo.getMno(),KakaoVO.class,"kakao");
		if(result.getMno() == vo.getMno()) {
			return 1;
		} else {
			return 0;
		}
	}

	//로그인================================================================================================
	@Override
	public boolean get(String userid, String userpw, HttpServletRequest request) {

		Query query = new Query(new Criteria().andOperator(
				Criteria.where("userid").is(userid),
				Criteria.where("userpw").is(userpw)));

		List<KakaoVO> result = mongo.find(query, KakaoVO.class, "kakao");

		System.out.println(result);
		if(result.size() == 0) {
			return false;
		}else {
			HttpSession session = request.getSession(true);
			session.setAttribute("userName" , result.get(0).getUserName());
			session.setAttribute("mno" , result.get(0).getMno());

			return true;
		}

	}


	//등록==================================================================================================
	@Override
	public int register(KakaoVO vo) {
		System.out.println("?!?!?");
		mongo.insert(vo);

		KakaoVO result = mongo.findById(vo.getMno(),KakaoVO.class,"kakao");

		if(result == null) {
			return 1;
		} else {
			return 0;
		}
	}
	//친구목록조회=============================================================================================
	@Override
	public List<KakaoVO> getList(@Param("mno")Long mno) {

		Query query = new Query(new Criteria().andOperator(
				Criteria.where("_id").is(mno)));

		List<KakaoVO> result = mongo.find(query, KakaoVO.class, "kakao");

		return result;
	}

	//조회==================================================================================================
	@Override
	public KakaoVO get(Long mno) {

		System.out.println("서비스로직에서 "+mno+"의 정보를 가져오고 있습니다.?");
		return mongo.findById(mno, KakaoVO.class, "kakao");

	}

	//삭제===================================================================================================
	@Override
	public WriteResult remove(Long mno) {

		Query query = new Query(new Criteria("_id").is(mno));
		return mongo.remove(query,"kakao");
	}

	//수정====================================================================================================
	@Override
	public WriteResult modify(KakaoVO vo) {

		Query query = new Query(new Criteria("_id").is(vo.getMno()));
		//업데이트 내용을 저장할 객체 생성
		Update update = new Update();
		update.set("userid",vo.getUserid());
		update.set("userName",vo.getUserName());

		//query 조건, update 변경 내용, 컬렉션 내임
		return mongo.updateMulti(query,update,"kakao");

	}
	// 시퀀스 적용추출 작업.... ==================================================================
	// 이 Auto_Increase 기능은 다른 그룹에도 적용 시켜야할 중요한 로직이다.	
	@Override
	public Long getNextSequenceId(String key) throws SequenceException {

		//get sequence id
		Query query = new Query(Criteria.where("_id").is(key));

		//increase sequence id by 1
		Update update = new Update();
		update.inc("seq", 1);

		//return new increased id
		FindAndModifyOptions options = new FindAndModifyOptions();
		options.returnNew(true);

		//this is the magic happened.
		Counter counter = 
				mongo.findAndModify(query, update, options, Counter.class);

		//if no id, throws SequenceException
		//optional, just a way to tell user when the sequence id is failed to generate.
		if (counter == null) {
			throw new SequenceException("Unable to get sequence id for key" + key);
		}
		return counter.getSeq();
	}
	//채팅방 컬렉션의 내용을 가져올 로직
	//cno를 이용할것==============================================================================================
	
	
	
	//채팅방이 있는지 없는지 확인하는 로직======================================================================================
	@Override
	public boolean get2(Object attribute, KakaoVO vo) {
		KakaoVO name = mongo.findById(attribute, KakaoVO.class, "kakao");
		List<ChatVO> name2 = name.getChatVO();

		KakaoVO idx = mongo.findById(vo.getMno(), KakaoVO.class, "kakao");
		List<ChatVO> idx2 = idx.getChatVO();


		boolean result = false;
		if(name2 != null && idx2 != null) {

			for(int i = 0;   i < name2.size(); i++ ) {
				for(int m = 0;   m < idx2.size(); m++ ) {
					if(name2.get(i).getCno() == idx2.get(m).getCno()) {

						System.out.println(idx2.get(m).getCno());
						result = true;
					}
				}
			}
		}
		System.out.println(result);
		return result;	


	}

	// 채팅방 만들기 ========================================================================================================
	@Override
	public ChatVO create(Object attribute, Long mno) {
		KakaoVO name = mongo.findById(attribute, KakaoVO.class, "kakao");
		KakaoVO idx = mongo.findById(mno, KakaoVO.class, "kakao");

		ChatVO vo = new ChatVO();

		try {
			vo.setCno(getNextSequenceId(MNO_SEQ_KEY2));
		} catch (Exception e) {
			e.printStackTrace();
		}
		vo.setMno(idx.getMno());


		mongo.updateFirst(
				Query.query(Criteria.where("_id").is(name.getMno())), 
				new Update().push("chatVO", vo), KakaoVO.class);

		vo.setMno(name.getMno());
		mongo.updateFirst(
				Query.query(Criteria.where("_id").is(idx.getMno())), 
				new Update().push("chatVO", vo), KakaoVO.class);

		return vo;	

	}

	@Override
	public KakaoVO get3(Object attribute) {
		KakaoVO name = mongo.findById(attribute, KakaoVO.class, "kakao");
		return name;
	}
	//친구추가 파트입니다.=================================================================

	@Override
	public int add(FriendVO vo,Object object) {

		FriendVO ddd = new FriendVO();
		ddd.setMno(vo.getMno());
		ddd.setState(vo.getState());
		ddd.setUserName(vo.getUserName());

		//=========================================================
		Query query = new Query(new Criteria().andOperator(
				Criteria.where("_id").is(object),
				Criteria.where("friendsVO").is(ddd)));

		List<KakaoVO> result2 = mongo.find(query, KakaoVO.class, "kakao");
		System.out.println(result2);	
		int result = 0;
		if(result2.toString() == "[]" ) {

			mongo.updateFirst(
					Query.query(Criteria.where("_id").is(object)), 
					new Update().push("friendsVO", vo), KakaoVO.class);
			result = 1;
		}
		return result;


	}
	//해당 채팅방으로 가기위한 cno에 채팅내용 추출 =====================================================
	@Override
	public Long get4(Object attribute, KakaoVO vo) {

		//로그인의 vo정보추출
		KakaoVO name = mongo.findById(attribute, KakaoVO.class, "kakao");
		//추출 vo중 chat부분 추출
		List<ChatVO> name2 = name.getChatVO();
		//대화상대 할사람의 vo 추출  
		KakaoVO idx = mongo.findById(vo.getMno(), KakaoVO.class, "kakao");
		//추출 vo중 chat 부분
		List<ChatVO> idx2 = idx.getChatVO();



		int result = 0;
		// 둘이 공통으로 가지고있는 채팅방 넘버 찾기
		for(int i = 0;   i < name2.size(); i++ ) {
			for(int m = 0;   m < idx2.size(); m++ ) {
				if(name2.get(i).getCno() == idx2.get(m).getCno()) {
					//로그인 멤버와 채팅멤머 할사람이 기존에 있던 cno(채팅방넘버)를 추출
					result = i;
				}
			}
		}
		System.out.println(result+" 안나오지?");
		// 채팅방 해당 넘버의 chat내용들 가져오기
		//채팅방 넘버를 리턴
		System.out.println(name2.get(result).getCno() + "나와라 cno");
		return name2.get(result).getCno();

	}

	// 채팅내역 뽑기=================================================================
	@Override
	public List<Chat2> getList2(Long cno) {


		//방번호로 조회한다.
		Chat name = mongo.findById(cno, Chat.class, "chat");
		System.out.println();
		List<Chat2> name2 = name.getChat2();
	
		return name2;
	}

	
	
	//채팅입력시 데이터베이스로 넘어가는 구간
	//채팅이 처음이면 데이터베이스안에 채팅내용을 담을 방번호id로된 필드가 생성된다.
	@Override
	public int add2(Chat vo) {
		

		Chat name = mongo.findById(vo.getCno(), Chat.class, "chat");
		System.out.println("name:" + name);
		
		if(name == null) {
			mongo.insert(vo);
		}else {
			Chat2 xo = new Chat2();
			xo.setContent(vo.getChat2().get(0).getContent());
			xo.setMno(vo.getChat2().get(0).getMno());
			xo.setWtime(vo.getChat2().get(0).getWtime());
			
			
		
			mongo.updateFirst(
					Query.query(Criteria.where("_id").is(vo.getCno())), 
					new Update().push("chat2", xo), Chat.class);
		}

		
		
		return 1;
	}

	//수신상태 업그레이드..
	@Override
	public WriteResult confirm(Chat vo) {
		System.out.println("현재 vo의 상태는"+vo);

		
		//채팅방 정보 추출
		Chat conf = mongo.findById(vo.getCno(), Chat.class, "chat");
		System.out.println("conf의 상태" + conf);
		
		//채팅방 정보 추출2
		List<Chat2> conf2 = conf.getChat2();
		System.out.println("conf2의 상태" + conf2);
		
		
		Query query = new Query(new Criteria("enable").is(null));

		Update update = new Update();
		update.set("confirm", 1 );
		
		mongo.updateMulti(query, update, "Chat2");
		
		System.out.println("conf2의 상태" + conf2);
		
		return mongo.updateMulti(query,update,"chat");

		//		
//		
//		Query query = new Query(new Criteria("_id").is(vo.getMno()));
//		//업데이트 내용을 저장할 객체 생성
//		Update update = new Update();
//		update.set("userid",vo.getUserid());
//		update.set("userName",vo.getUserName());
//
		//query 조건, update 변경 내용, 컬렉션 내임
//		return mongo.updateMulti(query,update,"kakao");

	}

	

}