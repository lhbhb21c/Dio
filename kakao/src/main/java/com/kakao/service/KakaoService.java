package com.kakao.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.kakao.domain.Chat;
import com.kakao.domain.Chat2;
import com.kakao.domain.ChatVO;
import com.kakao.domain.FriendVO;
import com.kakao.domain.KakaoVO;
import com.kakao.domain.SequenceException;
import com.mongodb.WriteResult;

public interface KakaoService {
	//등록
	public int register(KakaoVO vo);
	//목록조회
	public List<KakaoVO> getList(Long mno);
	//1의 조회  
	public KakaoVO get(Long mno);
	//삭제
	public WriteResult remove(Long mno);
	//수정
	public WriteResult modify(KakaoVO vo);
	//시퀀스증가
	Long getNextSequenceId(String key) throws SequenceException;
	//회원가입
	int join(KakaoVO vo);
	//로그인
	boolean get(String userid, String userpw,HttpServletRequest request);
	//채팅멤버찾기
	public boolean get2(Object attribute, KakaoVO vo);
	//채팅상대 정보조회
	public KakaoVO get3(Object attribute);
	
	
	//채팅방 새로만들기
	public ChatVO create(Object attribute, Long mno);
	
	public int add(FriendVO vo, Object object);
	
	//해당 채팅방으로 가기위한 cno에 채팅내용 추출
	public Long get4(Object attribute, KakaoVO vo);
	//채팅내역 뽑아내기
	public List<Chat2> getList2(Long cno);

	public int add2(Chat vo);
	public WriteResult confirm(Chat vo);

}
